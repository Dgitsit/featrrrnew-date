//
//  PaymentSheetView.swift
//  featrrrnew
//
//  Created by Buddie Booking on 7/6/23.
//

import SwiftUI
import StripePaymentSheet
import StripePaymentsUI
import Kingfisher
import Firebase

class MyBackendModel: ObservableObject {
    
    let backendCheckoutUrl = URL(string: "https://createpaymentintent-7tciwcgjna-uc.a.run.app")! // Your backend endpoint
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    @Published var isPaymentComplete: Bool=false
    @Published var hasAskedForRefund: Bool = false
    @Published var erroString: String = ""
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    
    func preparePaymentSheet(payment:String, user:User, post:Post, currentuser:User) {
        let _id: String = post.id!
        print("post data:::", post)
        print("post id:::", _id)
        //        guard let currentUser = AuthViewModel.shared.currentUser else { return }
        //        print("current user:::", currentUser)
        // Access the current user from the shared instance of AuthViewModel
        
        
        
        // MARK: Fetch the PaymentIntent and Customer information from the backend
        var parameters = "{\n"
        if let fullname = currentuser.fullname {
            parameters += "\"name\": \"\(fullname)\",\n"
        } else {
            // If fullname is nil, you can provide a default name or handle it as needed.
            parameters += "\"name\": \"Default Name\",\n"
        }
        parameters += """
            "amount": \(payment),
            "email": "\(currentuser.email)",
            "postId": "\(_id)",
            "userId": "\(currentuser.id)"
        }
        """
        
        
        print("post id:::", parameters)
        
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: backendCheckoutUrl)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                  let customerId = json["customer"] as? String,
                  let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
                  let paymentIntentDict = json["paymentIntent"] as? [String: Any],
                  let paymentIntentClientSecret = paymentIntentDict["client_secret"] as? String,
                  let publishableKey = json["publishableKey"] as? String,
                  let self = self else {
                // Handle error
                return
            }
            
            STPAPIClient.shared.publishableKey = publishableKey
            // MARK: Create a PaymentSheet instance
            var configuration = PaymentSheet.Configuration()
            configuration.merchantDisplayName = "Example, Inc."
            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            // Set `allowsDelayedPaymentMethods` to true if your business handles
            // delayed notification payment methods like US bank accounts.
            configuration.allowsDelayedPaymentMethods = true
            
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
            }
        })
        task.resume()
    }
    
    func requstRefund(postID: String) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        guard let refreshToken = try? await AuthService.shared.userSession?.getIDToken()
        else{ return }
        
        let url = URL(string: "https://requestrefundpayment-7tciwcgjna-uc.a.run.app")
        let params: [String:String] = ["postId":postID]
      
        var request = URLRequest(url: url!)
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        let session = URLSession.shared
            session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                
            if let error{
                DispatchQueue.main.async {
                    self.erroString = error.localizedDescription
                    self.showError = true
                }
                return
            }
                
            guard let response = (response as? HTTPURLResponse),response.statusCode == 200
            else {
                DispatchQueue.main.async {
                    self.erroString = "Server is unable to complete your reuqest"
                    self.showError = true
                }
                return
                // Throw Bad Server Response
            }
            DispatchQueue.main.async {
                self.hasAskedForRefund = true
            }
            }.resume()
        
    }
    
    func onPaymentCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
        self.isPaymentComplete=true
    }
}

struct PaymentSheetView: View {
    
    
    //@StateObject var viewModel: PostListViewModel
    
    //@Binding var selectedUser: User?
    
    @State var currentTimeHr = Date()
    @State var endTimeHr = Date()
    
    @State var currentTimeTask = Date()
    
    @State var currentTimeStoryPost = Date()
    
    var post: Post
    
    let user: User
    
    var closedRange = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    
    @State private var isToggledHr = false
    
    @State private var isToggledTask = false
    
    @State private var isToggledStoryPost = false
    
    @State private var isEditing = false
    
    @State private var showTextField = false
    
    @State private var messageText = ""
    
    @State private var showBottomSheet = false
    
    @StateObject var viewModel = ContentViewModel()
    
    
    
    
    //@Environment(\.dismiss) var dismiss
    
    
    func getTimeDifference(post: Post, start: Date, end: Date, rate: Double, isToggledTask: Bool, isToggledStoryPost: Bool, isToggledHr: Bool) -> Double {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.hour, .minute], from: start)
        
        let endComponents = calendar.dateComponents([.hour, .minute], from: end)
        
        let startHours = Double(startComponents.hour ?? 0)
        let startMinutes = Double(startComponents.minute ?? 0)
        let endHour = Double(endComponents.hour ?? 0)
        let endMinute = Double(endComponents.minute ?? 0)
        let totalHours = endHour - startHours + ((endMinute - startMinutes) / 60)
        var totalCost = totalHours * rate
        
        if !isToggledHr {
            totalCost -= totalCost
        }
        
        if isToggledTask {
            totalCost += Double(post.task)
        }
        
        if isToggledStoryPost {
            totalCost += Double(post.storyPost)
        }
        
        return totalCost
    }
    @ObservedObject var model = MyBackendModel()
    
    //    func paymentCompletion(<#parameters#>) -> <#return type#> {
    //        <#function body#>
    //    }
    var _currentUser: User? {
        guard let user = AuthViewModel.shared.currentUser else {
            return nil
        }
        return user
    }
    
    
    
    var body: some View {
        if model.isLoading{
            ProgressView()
        }else{
            ScrollView{
                VStack {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 370, height: 350)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    Text(post.category)
                    
                    
                    
                    
                    VStack{
                        Form {
                            if !isToggledHr {
                                Toggle("Hourly - $\(post.hr)", isOn: $isToggledHr)
                                
                            }
                            else {
                                Section(header: Text("Hourly is usually done together with the hirer, and paid based on time. Choose a day and time  to begin working together.")) {
                                    DatePicker("Hourly - $\(post.hr)", selection: $currentTimeHr, in: Date()...)
                                    
                                    DatePicker("End TIme", selection: $endTimeHr, displayedComponents: .hourAndMinute)
                                    
                                    
                                    Toggle("", isOn: $isToggledHr)
                                }
                            }
                            
                            
                            if !isToggledTask {
                                Toggle("Task - $\(post.task)", isOn: $isToggledTask)
                            }
                            else {
                                Section(header: Text("Task are generally done apart from the hirer, recorded content associated with the talent's category and sent back to the hirer to be featrrred. Choose what day you want this task completed and sent to you.")) {
                                    DatePicker("Task - $\(post.task)", selection: $currentTimeTask, displayedComponents: .date)
                                    
                                    Toggle("", isOn: $isToggledTask)
                                }
                            }
                            
                            
                            if !isToggledStoryPost {
                                Toggle("Story post - $\(post.storyPost)", isOn: $isToggledStoryPost)
                                
                            }
                            else {
                                Section(header: Text("All story post are to last a minimum of 24hrs. Choose a day and time you would like this talent to post you and you can specify on which platform you'd like to be posted (prices usually reflect the best of their  socialmedia).")) {
                                    DatePicker("Story post - $\(post.storyPost)", selection: $currentTimeStoryPost, in: Date()...)
                                    
                                    Toggle("", isOn: $isToggledStoryPost)
                                }
                            }
                        }
                        .frame(height: 200)
                        .cornerRadius(8)
                        
                    }
                    .padding()
                    
                    
                    Spacer()
                    ScrollView {
                        ZStack {
                            if isToggledHr || isToggledTask || isToggledStoryPost {
                                if !showTextField {
                                    let hr = post.hr
                                    let isToggledTask = isToggledTask
                                    let isToggledStoryPost = isToggledStoryPost
                                    let totalCost = max(5, getTimeDifference(post: post, start: currentTimeHr, end: endTimeHr, rate: Double(hr), isToggledTask: isToggledTask, isToggledStoryPost: isToggledStoryPost, isToggledHr: isToggledHr))
                                    let formattedCost = String(format: "%.2f", totalCost)
                                   
                                    VStack {
                                        if let refundUser = post.refundRequestedUsers, refundUser.contains(where: { value in
                                            value == Auth.auth().currentUser?.uid ?? ""
                                        }) || model.hasAskedForRefund{
                                            
                                            Text("Refund Request Initiated")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                                .frame(width: 360, height: 44)
                                                .background(Color(.systemPurple))
                                                .cornerRadius(8)
                                            
                                        }
                                        else if let paidUser = post.paidUsers, paidUser.contains(where: { value in
                                            value == Auth.auth().currentUser?.uid ?? ""
                                        })
                                        {
                                            Button (action: {
                                                if let id = post.id{
                                                    Task{
                                                        await self.model.requstRefund(postID: id)
                                                    }
                                                }
                                            })
                                            {
                                                Text("Request Refund")
                                                    .font(.subheadline)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                    .frame(width: 360, height: 44)
                                                    .background(Color(.systemPurple))
                                                    .cornerRadius(8)
                                            }
                                        }
                                       
                                        else if let paymentSheet = model.paymentSheet {
                                            PaymentSheet.PaymentButton(
                                                paymentSheet: paymentSheet,
                                                onCompletion: model.onPaymentCompletion
                                            ) {
                                                Text("Total: $\(formattedCost)")
                                                    .font(.subheadline)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                    .frame(width: 360, height: 44)
                                                    .background(Color(.systemPurple))
                                                    .cornerRadius(8)
                                            }
                                        } else {
                                            Text("Loading…")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                                .frame(width: 360, height: 44)
                                                .background(Color(.systemPurple))
                                                .cornerRadius(8)
                                        }
                                        
                                    }.onAppear {
                                        if let currentuser = viewModel.currentUser {
                                            print("current user",currentuser.id,currentuser.email)
                                            model.preparePaymentSheet(payment: formattedCost, user: user, post: post, currentuser:currentuser)
                                            
                                        }
                                    }
                                    
                                    //
                                    
                                }
                                
                            }
                        }
                        .sheet(isPresented: $showBottomSheet) {
                            
                            
                            ChatsView(user: user)
                            
                        }
                        Button (action: {
                            //                          model.preparePaymentSheet()
                            if(model.isPaymentComplete){
                                showBottomSheet.toggle()
                            }
                        })
                        {
                            Text("Open Chat")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 360, height: 44)
                                .background(Color(.systemPurple))
                                .cornerRadius(8)
                            
                            
                        }
                    }
                    
                    
                    
                }
                
            }
            .alert(isPresented: $model.showError, content: {
                Alert(title: Text(model.erroString))
            })
        }
    }
}




struct PaymentSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSheetView( post: dev.posts[0], user: dev.user)
    }
}

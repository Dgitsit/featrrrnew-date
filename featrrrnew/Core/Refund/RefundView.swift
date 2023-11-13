//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by CodistanVentures on 10/29/23.
//

import SwiftUI
import Kingfisher


struct RefundView: View {
    
    @ObservedObject var refundViewModel = RefundViewModel()
    
    var body: some View {
        GeometryReader{ proxy in
            
            VStack(alignment: .center) {
                //MARK: Navigationbar
                navBar
                    .padding(.leading,24)
                    .padding(.bottom,16)
               
                //MARK: Selection
                HStack(spacing:0){
                    requestButton
                        .frame(width: proxy.size.width / 2.5)
                        .background{
                            RoundedRectangle(cornerSize: .zero)
                                .foregroundColor(refundViewModel.selection == .buyer ? .blue : .white)
                        }
                        .cornerRadius(16, corners: [.topLeft,.bottomLeft])
                        .foregroundColor(refundViewModel.selection == .buyer ? .white : .blue)
                    
                    approvalButton
                        .frame(width: proxy.size.width / 2.5)
                        .background{
                            RoundedRectangle(cornerSize: .zero)
                                .foregroundColor(refundViewModel.selection == .seller ? .blue : .white)
                        }
                        .cornerRadius(16, corners: [.topRight,.bottomRight])
                        .foregroundColor(refundViewModel.selection == .seller ? .white : .blue)
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 16).stroke())
            
                Spacer()
                if refundViewModel.isLoadingData{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                else if refundViewModel.data.isEmpty{
                    Text("No data found!")
                        .foregroundColor(.gray)
                }else{
                    List {
                       ForEach(refundViewModel.data) {
                           RefundListItem(refundRequest: $0, onRefundButtonTapped: refundViewModel.confirmRefund, proxy: proxy, isRefundButtonDisabled: (refundViewModel.selection == .seller))
                        }
                    }
                    
                    .listStyle(.plain)
                }
                Spacer()
            }
            
        }
        .alert(isPresented: $refundViewModel.showError, content: {
            Alert(title: Text(refundViewModel.errorMessage))
        })
        .task {
              await refundViewModel.fetchBuyerRequests()
        }
        
        
    }
    
    var navBar: some View{
        HStack(alignment: .center,spacing: 0){
            Text("Refunds")
                .font(.title2)
                .padding(.leading,16)
                .foregroundColor(.blue)
            Spacer()
        }
    }
    
    var requestButton: some View{
        Button {
            Task{ await refundViewModel.fetchBuyerRequests() }
        } label: {
            Text("Bought")
                .padding(16)
        }
    }
    
    var approvalButton: some View{
        Button {
            Task{
                await refundViewModel.fetchSellerRequests()
            }
        } label: {
            Text("Sold")
                .padding(16)
            
        }
    }
    
}


struct RefundListItem: View{
    
    let refundRequest: RefundRequest
    let onRefundButtonTapped: (RefundRequest) async -> Void
    let proxy: GeometryProxy
    let isRefundButtonDisabled: Bool
    
    var body: some View{
        HStack {
            Spacer()
            VStack(alignment: .leading){
                KFImage(URL(string: refundRequest.post.imageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width * 0.8)
                    .frame(height: proxy.size.width * 0.8)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                Text(refundRequest.post.category)
                Text(refundRequest.post.city)
                Text(refundRequest.post.postBio)
                    .lineLimit(2)
                Button {
                    if isRefundButtonDisabled && refundRequest.status == .pending{
                        Task{
                            await onRefundButtonTapped(refundRequest)
                        }
                    }
                } label: {
                    Text(refundRequest.status.rawValue.capitalized)
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(width: proxy.size.width * 0.8)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(refundRequest.status == .pending ? .red : .blue)
                                .shadow(color: .gray, radius: 2)
                            
                        }
                }
               
            }
            .padding(16)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2)
        }
            Spacer()
        }
    }
}
        


struct RefundView_Previews: PreviewProvider {
    static var previews: some View {
        RefundView()
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}




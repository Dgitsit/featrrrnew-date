//
//  RefundViewModel.swift
//  SwiftUIProject
//
//  Created by CodistanVentures on 10/30/23.
//

import Foundation

final class RefundViewModel: ObservableObject{
    
    
    //MARK: View States
    enum RequestStatus{
        case pending
        case approved
        case completed
    }
    
    enum Selection{
        case buyer
        case seller
    }
    
    struct RefundObject: Identifiable{
        let id: Int
    }
    
    
    //MARK: Data
    private let repository = HttpRefundRepository()
    @Published private(set) var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published private(set) var selection: RefundViewModel.Selection = .buyer
    @Published private(set) var data: [RefundRequest] = []
    @Published private(set) var isLoadingData: Bool = false
    
   
    //MARK: Fetch Requests
    func fetchBuyerRequests() async{
        showLoadingView()
        DispatchQueue.main.async {
            self.selection = .buyer
        }
        do{
            let data = try await repository.fetchRequestsBuyer()
            self.updateViewWithData(data)
        }
        catch let error{
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.updateViewWithData([])
                self.showError = true
            }
        }
        
    }
    
    //MARK: Fetch user's requests
    func fetchSellerRequests() async {
        showLoadingView()
        DispatchQueue.main.async {
            self.selection = .seller
        }
        do{
            let data = try await repository.fetchRequestSeller()
            self.updateViewWithData(data)
        }
        catch let error{
            DispatchQueue.main.async {
                self.showError = true
                self.errorMessage = error.localizedDescription
                self.updateViewWithData([])
            }
        }
    }
    
    //MARK: Confirm Refund
    func confirmRefund(refundRequest: RefundRequest) async {
        let refundID = refundRequest.id
        showLoadingView()
        if let result = try? await repository.approveRefund(id: refundID),result{
                selection == .seller ? await fetchSellerRequests() : await fetchBuyerRequests()
            DispatchQueue.main.async {
                self.showError = true
                self.errorMessage = "Refund Approved"
            }
        }else{
            DispatchQueue.main.async {
                self.showError = true
                self.errorMessage = "Oops something went wrong"
            }
        }
        
    }
    
    //MARK: Show Loading View and clears data
    private func showLoadingView(){
        DispatchQueue.main.async {
            self.isLoadingData = true
        }
    }
    
    //MARK: Update view with remote Data
    private func updateViewWithData(_ data: [RefundRequest]){
        DispatchQueue.main.async {
            self.data = []
            self.isLoadingData = false
            self.data = data
        }
    }
}

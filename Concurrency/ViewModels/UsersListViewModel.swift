//
//  UsersListViewModel.swift
//  Concurrency
//
//  Created by Dave Cameron on 2023-02-18.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var showingAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading = true
        defer {
            isLoading.toggle()
        }
        do {
            users = try await apiService.getJSON()
        } catch {
            showingAlert = true
            errorMessage = error.localizedDescription  + "\n Please contact the developer"
        }
    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = User.mockUsers
        }
    }
}

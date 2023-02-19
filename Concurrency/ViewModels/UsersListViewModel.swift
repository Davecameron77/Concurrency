//
//  UsersListViewModel.swift
//  Concurrency
//
//  Created by Dave Cameron on 2023-02-18.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var usersAndPosts: [UserAndPosts] = []
    @Published var isLoading = false
    @Published var showingAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        let apiService2 = APIService(urlString: "https://jsonplaceholder.typicode.com/posts")
        isLoading = true
        defer {
            isLoading.toggle()
        }
        do {
            let users: [User] = try await apiService.getJSON()
            let posts: [Post] = try await apiService2.getJSON()
            let (fetchedUsers, fetchedPosts) = await (try users, try posts)
            for user in fetchedUsers {
                let userPosts = fetchedPosts.filter { $0.userId == user.id }
                let newUserAndPosts = UserAndPosts(user: user, posts: posts)
                usersAndPosts.append(newUserAndPosts)
            }
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
            self.usersAndPosts = UserAndPosts.mockUserAndPosts
        }
    }
}

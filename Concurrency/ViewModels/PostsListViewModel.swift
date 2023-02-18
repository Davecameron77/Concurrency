//
//  PostsListViewModel.swift
//  Concurrency
//
//  Created by Dave Cameron on 2023-02-18.
//

import Foundation

class PostsListsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showingAlert = false
    @Published var errorMessage: String?
    var userId: Int?
    
    @MainActor
    func fetchPosts() async {
        if let userId = userId {
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/user/\(userId)/posts")
            isLoading = true
            
            isLoading.toggle()
            defer {
                isLoading.toggle()
            }
            do {
                posts = try await apiService.getJSON()
            } catch {
                showingAlert = true
                errorMessage = error.localizedDescription + "\n Please contact the developer"
            }
        }
    }
}

extension PostsListsViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockPosts
        }
    }
}

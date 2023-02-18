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
    
    func fetchPosts() {
        if let userId = userId {
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/user/\(userId)/posts")
            isLoading = true
            
            apiService.getJSON { (result: Result<[Post], APIError>) in
                defer {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                
                switch result {
                case.success(let posts):
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showingAlert = true
                        self.errorMessage = error.localizedDescription + "\nPlease contact the developer"
                    }
                }
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

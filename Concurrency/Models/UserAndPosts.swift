//
//  UserAndPosts.swift
//  Concurrency
//
//  Created by Dave Cameron on 2023-02-18.
//

import Foundation

struct UserAndPosts: Identifiable {
    var id = UUID()
    let user: User
    let posts: [Post]
    var numberOfPosts: Int {
        posts.count
    }
}

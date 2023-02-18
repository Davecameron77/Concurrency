//
//  Post.swift
//  Concurrency
//
//  Created by Dave Cameron on 2023-02-18.
//

import Foundation

// Source: https//jsonplaceholder.typicode.com/posts
// Single Post Source: https//jsonplaceholder.typicode.com/users/1/posts

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

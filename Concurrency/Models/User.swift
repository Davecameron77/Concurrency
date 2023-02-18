//
//  User.swift
//  Concurrency
//
//  Created by Dave Cameron on 2023-02-18.
//

import Foundation

// Source: https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

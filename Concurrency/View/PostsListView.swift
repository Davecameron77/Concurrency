//
//  PostsListView.swift
//  Concurrency
//
//  Created by Dave Cameron on 2023-02-18.
//

import SwiftUI

struct PostsListView: View {
    var posts: [Post]
    var userId: Int?
    
    var body: some View {
        List {
            ForEach(posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Posts")
        .listStyle(.plain)
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(posts: Post.mockSingleUsersPostArray)
        }
    }
}

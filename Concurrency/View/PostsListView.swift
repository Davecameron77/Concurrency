//
//  PostsListView.swift
//  Concurrency
//
//  Created by Dave Cameron on 2023-02-18.
//

import SwiftUI

struct PostsListView: View {
    @StateObject var vm = PostsListsViewModel()
    var userId: Int?
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
        }
        .overlay {
            if vm.isLoading {
                ProgressView()
            }
        }
        .alert("Application Error", isPresented: $vm.showingAlert, actions: {
            Button("OK") {}
        }, message: {
            if let errorMessage = vm.errorMessage {
                Text(errorMessage)
            }
        })
        .navigationTitle("Posts")
        .listStyle(.plain)
        .onAppear {
            Task {
                vm.userId = userId
                await vm.fetchPosts()
            }
        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(userId: 1)
        }
    }
}

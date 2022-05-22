//
//  FeedViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var posts = [PostCateg]()
    private let service = ServicioPost()
 
    init() {
        fetchPublications()
    }
    
    func fetchPublications() {
        service.fetchPosts { posts in
            self.posts = posts
        }
    }
}

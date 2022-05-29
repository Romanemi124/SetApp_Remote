//
//  FeedViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    /*Se almacenan todas las publicaciones recogidas según orden de fecha*/
    @Published var posts = [PostCateg]()
    private let service = ServicioPost()
 
    /*Una vez inicializamos el método para guardar en el array*/
    init() {
        fetchPublications()
    }
    
    /*Se almacenan todas las publicacioones en el array que se ha creado anteriormente*/
    func fetchPublications() {
        service.fetchPosts { posts in
            self.posts = posts
        }
    }
}

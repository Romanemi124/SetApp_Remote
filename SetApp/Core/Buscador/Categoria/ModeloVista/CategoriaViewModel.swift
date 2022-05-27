//
//  CategoriaViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 18/5/22.
//

import Foundation

//Para mostrar las publicaciones con la categoria que se pase por parámetro
class CategoriaViewModel: ObservableObject {
    
    @Published var posts = [PostCateg]()
    private let service = ServicioPost()
    let categoria: String

    init(categoria: String) {
        self.categoria = categoria
        fetchPosts()
    }
    
    func fetchPosts() {
        service.fetchPostsCategoria(categoria: categoria) { posts in
            
            self.posts = posts
        }
    }
}


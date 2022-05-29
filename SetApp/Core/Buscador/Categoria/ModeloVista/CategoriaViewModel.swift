//
//  CategoriaViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 18/5/22.
//

import Foundation

//Para mostrar las publicaciones con la categoria que se pase por parámetro
class CategoriaViewModel: ObservableObject {
    
    /*Se almacenan todas las publicaciones recogidas según la categoría en un array*/
    @Published var posts = [PostCateg]()
    private let service = ServicioPost()
    let categoria: String

    /*Una vez inicializamos las categorías para pasar por parámetro y saber que categoría se va a pasar por parámmetro*/
    init(categoria: String) {
        self.categoria = categoria
        fetchPosts()
    }
    
    /*Se almacenan todas las publicacioones en el array que se ha creado anteriormente*/
    func fetchPosts() {
        service.fetchPostsCategoria(categoria: categoria) { posts in
            
            self.posts = posts
        }
    }
}


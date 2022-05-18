//
//  MarcaViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 18/5/22.
//

import Foundation

//Para mostrar las publicaciones con la marca que se pase por parámetro
class MarcaViewModel: ObservableObject {
    
    @Published var posts = [PostCateg]()
    private let service = ServicioPost()
    let marca: String

    init(marca: String) {
        self.marca = marca
        fetchPosts()
    }
    
    func fetchPosts() {
        service.fetchPostsMarcas(marca: marca) { posts in
            
            self.posts = posts
        }
    }
}


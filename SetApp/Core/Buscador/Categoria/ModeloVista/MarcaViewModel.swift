//
//  MarcaViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 18/5/22.
//

import Foundation

//Para mostrar las publicaciones con la marca que se pase por parámetro
class MarcaViewModel: ObservableObject {
    
    /*Se almacenan todas las publicaciones recogidas según la marca en un array*/
    @Published var posts = [PostCateg]()
    private let service = ServicioPost()
    let marca: String

    /*Una vez inicializamos las marcas para pasar por parámetro y saber que marca se va a pasar por parámmetro*/
    init(marca: String) {
        self.marca = marca
        fetchPosts()
    }
    
    /*Se almacenan todas las publicacioones en el array que se ha creado anteriormente*/
    func fetchPosts() {
        service.fetchPostsMarcas(marca: marca) { posts in
            
            self.posts = posts
        }
    }
}


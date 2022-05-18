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
    
    /*
     func fetchPublications() {
         service.fetchPosts { publicaciones in
             self.publicaciones = publicaciones
             
             for i in 0 ..< publicaciones.count {
                 let uid = publicaciones[i].idUser
                 
                 self.userService.mostrarUsuario(withUid: uid) { usuario in
                     self.publicaciones[i].user = usuario
                 }
             }
         }
     }
     */
    
    /*
     @Published var posts = [Post2]()
     //let userService = ServicioUsuario()
     let service = ServicioPostPrueba()

     init() {
         fetchPublications()
     }
     
     func fetchPublications() {
         service.fetchPosts { posts in
             
             self.posts = posts
         }
     }
     */
    
}


//
//  FeedViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import Foundation

//DEPRECATED
//Para mostrar todas las pubvlicaciones: llamar al otro método
class FeedViewModel: ObservableObject {
    
    @Published var posts = [PostCateg]()
    //let userService = ServicioUsuario()
    let service = ServicioPost()

    init() {
        fetchPublications()
    }
    
    func fetchPublications() {
        service.fetchPosts { posts in
            
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
    
}

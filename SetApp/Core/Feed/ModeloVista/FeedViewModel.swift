//
//  FeedViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var publicaciones = [Publicacion]()
    let service = ServicioProducto()
    let userService = ServicioUsuario()
    
    init() {
        fetchPublications()
    }
    
    func fetchPublications() {
        service.fetchPublications { publicaciones in
            self.publicaciones = publicaciones
            
            for i in 0 ..< publicaciones.count {
                let uid = publicaciones[i].idUser
                
                self.userService.mostrarUsuario(withUid: uid) { usuario in
                    self.publicaciones[i].user = usuario
                }
            }
        }
    }
}

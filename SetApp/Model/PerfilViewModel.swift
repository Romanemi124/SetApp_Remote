//
//  PerfilViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import Foundation

class PerfilViewModel: ObservableObject {
    
    let user: Usuario
    
    init(user: Usuario) {
        self.user = user
        //self.mostrarPublicUsuarios()
    }
    
    /*
    func mostrarPublicUsuarios() {
        guard let uid = user.id else { return }
        service.fetchPublicationsUser(forUid: uid) { publicaciones in
            self.publicaciones = publicaciones
            
            for i in 0 ..< publicaciones.count {
                self.publicaciones[i].user = self.user
            }
        }
    }
     */
}

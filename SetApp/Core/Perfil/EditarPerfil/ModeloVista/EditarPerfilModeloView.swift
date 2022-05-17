//
//  EditarPerfilModeloView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 14/5/22.
//

import Foundation

class EditarPerfilModeloView: ObservableObject{
    
    /* Variable del objecto que pasar para la clase */
    let user: UsuarioFireBase
    
    //Inicializamos la clase con un usuario, esto permitirá reutilizar la clase en el buscador de personas y en la de editar o revisar el perfil
    init(user: UsuarioFireBase){
        self.user =  user
    }
    
}

//
//  BuscadorModeloView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 3/5/22.
//

import Foundation

class BuscadorModeloView: ObservableObject{

    /*!!![User]() buscar esa estructura*/
    @Published var usuarios = [Usuario]()
    //Variable que accede al texto que escribe en el buscador
    @Published var textoBuscar = ""
    
    //Variable que almacenar los usuarios buscados según el filtro de busqueda
    var searchableUsers: [Usuario]{
        
        if textoBuscar.isEmpty{
            
            //Nos mostrará ningún usuario
            return usuarios
            
        }else{
            
            //Pasamos todo a minusculas para realizar más fácil la busqueda
            let lowercasedQuery = textoBuscar.lowercased()
            
            return usuarios.filter({
                $0.nombreUsuario.contains(lowercasedQuery) ||
                //$0.fullname.lowercased().contains(lowercasedQuery) Mejorar el nivel de la busqueda (HABÍA PROBLEMAS con fullname)
                $0.nombreCompleto.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    let service = ServicioUsuario()
    
    init(){
        
       mostrarUsuarios()
    }
    
    func mostrarUsuarios(){
        service.mostrarUsuarios(){ usuarios in
            self.usuarios = usuarios
            print("DEBUG: Users are\(usuarios)")
        }
    }

}

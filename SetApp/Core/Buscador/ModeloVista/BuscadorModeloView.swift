//
//  BuscadorModeloView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 3/5/22.
//

import Foundation

class BuscadorModeloView: ObservableObject{
    
    //Para mostrar y dejar de mostrar la barra de búsqueda de la vista
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false

    /*!!![User]() buscar esa estructura*/
    @Published var usuarios = [UsuarioFireBase]()
    //Variable que accede al texto que escribe en el buscador
    @Published var textoBuscar = ""
    
    //Inicializamos buscando todos los usuarios de FireBase
    init(){
       mostrarUsuarios()
    }
    
    //Variable que almacenar los usuarios buscados según el filtro de busqueda
    var searchableUsers: [UsuarioFireBase]{
        
        if textoBuscar.isEmpty{
            
            //Nos mostrará ningún usuario
            return []
            
        }else{
            
            //Pasamos todo a minusculas para realizar más fácil la busqueda
            let lowercasedQuery = textoBuscar.lowercased()
            
            return usuarios.filter({
                //$0.nombreUsuario.lowercased().contains(lowercasedQuery) Al transformar todo a minúsculas mejorar el nivel de la busqueda, puesto que solo habra´distinción entre diferenteres caracteres sin imporatr la mayusculas o minúsculas
                $0.nombreUsuario.lowercased().contains(lowercasedQuery) ||
                $0.nombreCompleto.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    //Mostramos todos los usuarios de FireBase
    func mostrarUsuarios(){
        
        Store.recuperarTodosUsuarioFB{(result) in
            
            switch result {
            //En el caso que haya algún error nos imprimirá por consola el tipo de error
            case .failure(let error):
                print(error.localizedDescription)
            //En el caso que no haya ningún error guardaremos el usuario obtenido de FireBase en la variable usuario, de está forma puesto que se trata el usuario de un objecto de entorno podremos obtener sus datos en las demás vistas
            case .success(let user):
                self.usuarios = user
                print("USuarios Firebase \(user)")
            }
        }
    }

}

//
//  ServicioUsuario.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 6/4/22.
//

import Firebase
import FirebaseFirestoreSwift


//Deprecated

struct ServicioUsuario{
    
    //Mostrar los datos de un usuario según el id del usuario
    func mostrarUsuario(withUid uid:String, completion: @escaping(Usuario) -> Void){
        
        Firestore.firestore()
           /* .collection("usuarios") Seleccionamos la colección donde buscaremos los datos */
            .collection("usuarios")
        /* .document(uid) Seleccionamos el nodo principal de la colección, en este caso es el ID del usuario */
            .document(uid)
        /* .getDocument Selecionamos el documento */
            .getDocument{ snapshot, _ in
                
                //Salimos de la función se hay algún error
                guard let snapshot = snapshot else { return }
                
                //Guardamos el usuario y comprbamos si los datos se pueden guardar correctamente en la base de datos
                guard let usuario = try? snapshot.data(as: Usuario.self) else { return }
                
                //Guardamos los datos en Firebase
                completion(usuario)
                
            }
    }
    
    /* Mostrar todos los usuarios de la base de datos */
    func mostrarUsuarios(completion: @escaping([Usuario]) -> Void) {
        Firestore.firestore().collection("usuarios")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let usuarios = documents.compactMap({ try? $0.data(as: Usuario.self) })
                completion(usuarios)
            }
    }
}

//
//  PerfilInformacionViewModel.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/5/22.
//

import Foundation
import Firebase

/* Recogeremos los datos de los seguidores, seguidos y publicaciones */
class PerfilInformacionViewModel: ObservableObject{
    
    //Para recogeer los posts ya sea para mostrarlos en el perfil o en otras vistas
    @Published var posts: [Post] = []
    
    @Published var seguidos = 0
    @Published var seguidores = 0
    
    //Usuario de la clase
    let user: UsuarioFireBase
    
    //Inicializamos la clase con un usuario, esto permitirá reutilizar la clase en el buscador de personas y en la de editar o revisar el perfil
    init(user: UsuarioFireBase){
        self.user =  user
    }
    
    //@Published var followCheck = false
    
    static var following = StorageService.storeRoot.collection("following")
    static var followers = StorageService.storeRoot.collection("followers")
    
    static func followingCollection(userId: String) -> CollectionReference {
        return following.document(userId).collection("following")
    }
    
    static func followersCollection(userId: String) -> CollectionReference {
        return followers.document(userId).collection("followers")
    }
    
    static func followingId(userId: String) -> DocumentReference {
        return following.document(Auth.auth().currentUser!.uid).collection("following").document(userId)
    }
    
    static func followersId(userId: String) -> DocumentReference {
        return followers.document(userId).collection("followers").document(Auth.auth().currentUser!.uid)
    }
    
    //Cragar los datos recogidos en objetos de tipo Post para luego mostrarlos por pantalla
    func cargarPostUser(userId: String) {
        
        ServicioPost.loadUserPosts(userId: userId) { (posts) in
            self.posts = posts
        }
        
        follows(userId: userId)
        followers(userId: userId)
    }
    
    func follows(userId: String) {
        
        PerfilViewModel.followingCollection(userId: userId).getDocuments { (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.seguidos = doc.count
            }
        }
    }
    
    func followers(userId: String) {
        
        PerfilViewModel.followersCollection(userId: userId).getDocuments { (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.seguidores = doc.count
            }
        }
    }
}

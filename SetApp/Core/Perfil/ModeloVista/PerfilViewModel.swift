//
//  PerfilViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import Foundation
import Firebase

class PerfilViewModel: ObservableObject {
    
    //Para recogeer los posts ya sea para mostrarlos en el perfil o en otras vistas
    @Published var posts: [Post] = []
    
    @Published var seguidos = 0
    @Published var seguidores = 0
    
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
    
    /*Cargar las publicaciones y seguidores y seguidos para mostrar en el perfil del usuario cuando se inicializa*/
    func cargarPostUser(userId: String) {
        
        ServicioPost.loadUserPosts(userId: userId) { (posts) in
            self.posts = posts
        }
        
        follows(userId: userId)
        followers(userId: userId)
    }
    
    /*Cargan los seguidos del usuario*/
    func follows(userId: String) {
        
        PerfilViewModel.followingCollection(userId: userId).getDocuments { (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.seguidos = doc.count
            }
        }
    }
    
    /*Cargan los seguidores del usuario*/
    func followers(userId: String) {
        
        PerfilViewModel.followersCollection(userId: userId).getDocuments { (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.seguidores = doc.count
            }
        }
    }
}

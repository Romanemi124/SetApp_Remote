//
//  FollowService.swift
//  SetApp
//
//  Created by Emilio Roman on 15/5/22.
//

import Foundation
import Firebase

class FollowService: ObservableObject {
    
    func manageFollow(userId: String, followCheck: Bool,
        followingCount: @escaping (_ followingCount: Int) -> Void,
        followersCount: @escaping (_ followersCount: Int) -> Void) {
        
        if !followCheck {
            follow(userId: userId, followingCount: followingCount, followersCount: followersCount)
        } else {
            unfollow(userId: userId, followingCount: followingCount, followersCount: followersCount)
        }
    }
    
    //2º En el caso de siga  a la persona, se le pasa el id, y sus contadores en cuanto a seguidores
    func follow(userId: String, followingCount: @escaping (_
        followingCount: Int) -> Void, followersCount: @escaping (_
        followersCount: Int) -> Void) {
        
        PerfilViewModel.followingId(userId: userId).setData([:]) { (err) in
            
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
        
        PerfilViewModel.followersId(userId: userId).setData([:]) { (err) in
            
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
    }
    
    //2º En el caso de que deje de seguir a la persona, se le pasa el id, y sus contadores en cuanto a seguidores
    func unfollow(userId: String, followingCount: @escaping (_
        followingCount: Int) -> Void, followersCount: @escaping (_
        followersCount: Int) -> Void) {
        
        PerfilViewModel.followingId(userId: userId).getDocument { (document, err) in
            
            if let doc = document, doc.exists {
                
                doc.reference.delete()
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
        
        PerfilViewModel.followersId(userId: userId).getDocument { (document, err) in
            
            if let doc = document, doc.exists {
                
                doc.reference.delete()
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
    }
    
    //1º Actualizamos el contador de usuarios de las personas a las que sigue y deja de seguir
    func updateFollowCount(userId: String, followingCount: @escaping (_
        followingCount: Int) -> Void, followersCount: @escaping (_
        followersCount: Int) -> Void) {
           
        //Se añade el id del usuario en la coleccion de personas que sigue
            PerfilViewModel.followingCollection(userId: userId).getDocuments { (snap, error) in
                
                if let doc = snap?.documents {
                    followingCount(doc.count)
                }
            }
            
            PerfilViewModel.followersCollection(userId: userId).getDocuments { (snap, error) in
                
                if let doc = snap?.documents {
                    followersCount(doc.count)
                }
            }
    }
    
    //Comprobar si ya sigue al usuario o todavía no
    static func buscarSeguimientoUser(withIdUsuario userId: String, completionHandler:@escaping (Result<Bool,Error>) -> Void){
        
        //whereField("followers", isEqualTo: userId) seleccionar el campo
        Firestore.firestore().collection("followers").whereField("followers", isEqualTo: userId).getDocuments{ (resultado, error) in
            
            if let error = error {
                print("Follow: error al encontrar el usuario \(error.localizedDescription)")
            }else{
                //Si encuentra al usuario
                if (resultado!.documents.count > 0){
                    completionHandler(.success(true))
                    print("follower encontrado")
                }else{
                    //No encuentra al usuario
                    completionHandler(.success(false))
                    print("follower No encontrado")
                }
            }
        }
    }
}

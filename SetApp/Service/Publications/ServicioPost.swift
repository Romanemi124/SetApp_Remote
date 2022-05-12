//
//  ServicioPost.swift
//  SetApp
//
//  Created by Emilio Roman on 3/5/22.
//

import Firebase
import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class ServicioPost: ObservableObject {
 
    static var Posts = StorageService.storeRoot.collection("posts")
    static var AllPosts = StorageService.storeRoot.collection("allPosts")
    static var Timeline = StorageService.storeRoot.collection("timeline")
    
    static func PostUserId(userId: String) -> DocumentReference {
        
        return Posts.document(userId)
    }

    static func timelineUserId(userId: String) -> DocumentReference {
        
        return Timeline.document(userId)
    }
    
    static func uploadPost(imageData: Data, categoria: String, nombreProducto: String, marca: String, valoracion: String, caracteristicas: String, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {

        guard let userId = Auth.auth().currentUser?.uid else { return }
        let postId = ServicioPost.PostUserId(userId: userId).collection("posts").document().documentID
        let storagePostRef = StorageService.storagePerfilId(idUsuario: postId)
        let metadata = StorageMetadata()
        
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(imageData: imageData, categoria: categoria, nombreProducto: nombreProducto, marca: marca, valoracion: valoracion, caracteristicas: caracteristicas, userId: userId, postId: postId, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    }
    
    //Cargar los datos para luego pasarlo a objetos de tipo post
    static func loadUserPosts(userId: String, onSuccess: @escaping(_ posts: [Post]) -> Void) {
        
        ServicioPost.PostUserId(userId: userId).collection("posts").getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            var posts = [Post]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder =  try? Post.init(fromDictionary: dict)
                        
                else {
                    return
                }
                
                posts.append(decoder)
            }
            onSuccess(posts)
        }
    }
}

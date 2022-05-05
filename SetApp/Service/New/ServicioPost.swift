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

//struct
class ServicioPost {
    
    static var Posts = AuthService.storeRoot.collection("posts")
    
    static var AllPosts = AuthService.storeRoot.collection("allPosts")
    static var Timeline = AuthService.storeRoot.collection("timeline")
    
    static func PostUserId(userId: String) -> DocumentReference {
        return Posts.document(userId)
    }
    
    static func timelineUserId(userId: String) -> DocumentReference {
        return Timeline.document(userId)
    }
    
    
    static func uploadPost(imageData: Data, categoria: String, nombreProducto: String, marca: String, valoracion: String, caracteristicas: String, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let postId = ServicioPost.PostUserId(userId: userId).collection("posts").document().documentID
        
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(imageData: imageData, categoria: categoria, nombreProducto: nombreProducto, marca: marca, valoracion: valoracion, caracteristicas: caracteristicas, userId: userId, postId: postId, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    }
}

/*
 static func uploadPost(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
     
     guard let userId = Auth.auth().currentUser?.uid else {
         return
     }
     
     let postId = ServicioPost.PostUserId(userId: userId).collection("posts").document().documentID
     
     let storagePostRef = StorageService.storagePostId(postId: postId)
     let metadata = StorageMetadata()
     metadata.contentType = "image/jpg"
     
     StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
 }
 */


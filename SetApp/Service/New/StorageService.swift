//
//  StorageService.swift
//  SetApp
//
//  Created by Emilio Roman on 3/5/22.
//

import Firebase
import FirebaseAuth
import FirebaseStorage
import UIKit

class StorageService {
    
    
    static var storage = Storage.storage()
    static var storageRoot = storage.reference()
    static var storageProfile = storageRoot.child("profile")
    static var storagePost = storageRoot.child("posts")
    
    static func storagePostId(postId: String) -> StorageReference {
        return storagePost.child(postId)
    }
    
    static func savePostPhoto(imageData: Data, categoria: String, nombreProducto: String, marca: String, valoracion: String, caracteristicas: String, userId: String, postId: String, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storagePostRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storagePostRef.putData(imageData, metadata: metadata) {
                
                (StorageMetadata, error) in
                
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                
                storagePostRef.downloadURL {
                    
                    (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        let firestorePostRef = ServicioPost.PostUserId(userId: userId).collection("posts").document(postId)
                        
                        let post = Post.init(likes: [:], geoLocation: "", OwnerId: userId, postId: postId, /*username: Auth.auth().currentUser!.displayName!,*/ mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0, categoria: categoria, nombreProducto: nombreProducto, marca: marca, valoracion: valoracion, caracteristicas: caracteristicas)
                        
                        guard let dict = try? post.asDictionary() else { return }
                        
                        firestorePostRef.setData(dict) {
                            
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                            
                            ServicioPost.timelineUserId(userId: userId).collection("timeline").document(postId).setData(dict)
                            
                            ServicioPost.AllPosts.document(postId).setData(dict)
                            onSuccess()
                        }
                    }
                }
            }
        }
    }
}

/*
 static func savePostPhoto(userId: String, postId: String, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
     
     storagePostRef.putData(imageData, metadata: metadata) {
         (StorageMetadata, error) in
         
         if error != nil {
             onError(error!.localizedDescription)
             return
         }
         
         storagePostRef.putData(imageData, metadata: metadata) {
             
             (StorageMetadata, error) in
             
             if error != nil {
                 onError(error!.localizedDescription)
                 return
             }
             
             storagePostRef.downloadURL {
                 
                 (url, error) in
                 if let metaImageUrl = url?.absoluteString {
                     let firestorePostRef = ServicioPost.PostUserId(userId: userId).collection("posts").document(postId)
                     
                     let post = Post.init(caption: caption, likes: [:], geoLocation: "", OwnerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, profile: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0, categoria: "", nombreProducto: "", marca: "", valoracion: "", caracteristicas: "")
                     
                     guard let dict = try? post.asDictionary() else { return }
                     
                     firestorePostRef.setData(dict) {
                         
                         (error) in
                         if error != nil {
                             onError(error!.localizedDescription)
                             return
                         }
                         
                         ServicioPost.timelineUserId(userId: userId).collection("timeline").document(postId).setData(dict)
                         
                         ServicioPost.AllPosts.document(postId).setData(dict)
                         onSuccess()
                     }
                 }
             }
         }
     }
 }
 */

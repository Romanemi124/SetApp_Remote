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
    
    //--Para el feed
    static var following = StorageService.storeRoot.collection("following")
    
    static func followingCollection(userId: String) -> CollectionReference {
        return following.document(userId).collection("following")
    }
    static func followingId(userId: String) -> DocumentReference {
        return following.document(Auth.auth().currentUser!.uid).collection("following").document(userId)
    }
    //--Para el feed
    
    static func PostUserId(userId: String) -> DocumentReference {
        
        return Posts.document(userId)
    }

    static func timelineUserId(userId: String) -> DocumentReference {
         
        return Timeline.document(userId)
    }
    
    static func uploadPost(imageData: Data, categoria: String, nombreProducto: String, marca: String, valoracion: String, puntosPositivos: String, puntosNegativos: String, usuario: UsuarioFireBase?, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postId = ServicioPost.PostUserId(userId: userId).collection("posts").document().documentID
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(userId: userId, imageData: imageData, categoria: categoria, nombreProducto: nombreProducto, marca: marca, valoracion: valoracion, puntosPositivos: puntosPositivos, puntosNegativos: puntosNegativos, postId: postId, metadata: metadata, storagePostRef: storagePostRef, usuario: usuario, onSuccess: onSuccess, onError: onError)
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
    
    /*-------------------*/
    /*-------------------*/
    /*-------------------*/
    /*-------------------*/
    /*
    func likePost(_ post: Post, completion: @escaping() -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.postId else { return }
        
        let userLikesRef = Firestore.firestore().collection("usuarios").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("allPosts").document(postId)
            .updateData(["likeCount": post.likeCount + 1]) { _ in
                userLikesRef.document(postId).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    func unlikePost(_ post: Post, completion: @escaping() -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.postId else { return }
        guard post.likeCount > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("usuarios").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("allPosts").document(postId)
            .updateData(["likeCount": post.likeCount - 1]) { _ in
                userLikesRef.document(postId).delete { _ in
                    completion()
                }
            }
    }
    
    func checkIfUserLikedTweet(_ post: Post, completion: @escaping(Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let postId = post.postId else { return }
        
        Firestore.firestore().collection("usuarios")
            .document(uid)
            .collection("user-likes")
            .document(postId).getDocument { snapshot, _ in
                
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    */
    /*-------------------*/
    /*-------------------*/
    /*-------------------*/
    /*-------------------*/
}

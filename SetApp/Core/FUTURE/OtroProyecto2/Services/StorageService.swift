//
//  StorageService.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 4/5/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

/*  */
class StorageService {
    
    //Acceso por referencia a la ubucación donde almancenaramos los datos
    static var storage =  Storage.storage()
    //Seleccianamos el sitio donde almancenaramos los datos
    static var storageRoot = storage.reference(forURL: "gs://setapp-a2961.appspot.com")
    //La carpeta donde almacenaremos los datos
    static var storageProfile = storageRoot.child("perfil")
    
    
    //    static var storage = Storage.storage()
    //        static var storageRoot = storage.reference()
    //        static var storageProfile = storageRoot.child("profile")
    static var storagePost = storageRoot.child("posts")
    
    static func storagePostId(postId: String) -> StorageReference {
        return storagePost.child(postId)
    }
    
    /* Función para identificar la imagen con el id del usuario que ha elegido la foto */
    static func storageProfileId(userId:String) -> StorageReference{
        return storageProfile.child(userId)
    }
    
    static func saveProfileImage(userId:String, userName: String,  email: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: UserModel)->Void, onError: @escaping(_ errorMesage:String)->Void){
        
        storageProfileImageRef.putData(imageData, metadata: metaData){ (StorageMetadata, error) in
            
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            storageProfileImageRef.downloadURL{ (url, error)in
                if let metaImageUrl = url?.absoluteString{
                    //Si esta autentificado el usuario podremos cambiar su foto de perfil
                    if let changeRequest =  Auth.auth().currentUser?.createProfileChangeRequest(){
                        changeRequest.photoURL = url
                        changeRequest.displayName = userName
                        changeRequest.commitChanges{ (error) in
                            if error != nil{
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    
                    let fireStoreUserId = AuthService.getUserId(userId: userId)
                    
                    let user = UserModel.init(uid: userId, emial: email, profileImageUrl: metaImageUrl, userName: userName, searchName: userName.splitString(), bio: "")
                    
                    guard let dict = try?user.asDictionary() else {return}
                    
                    fireStoreUserId.setData(dict){ error in
                        
                        if error != nil{
                            onError(error!.localizedDescription)
                        }
                    }
                    
                    //En caso de que no haya errores
                    onSuccess(user)
                    
                }
            }
            
        }
        
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

//
//  AuthService.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 4/5/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

/* Clase para conexión con FireBase para Registrarse e Iniciar Sesión */
class AuthService{
    
    static var storeRoot =  Firestore.firestore()
    
    static func getUserId(userId: String)-> DocumentReference{
        return storeRoot.collection("usuarios").document(userId)
    }
    
    static func signUp(userName: String,  emial: String, password:String, imageData:Data, onSuccess: @escaping(_ user: UserModel)->Void, onError: @escaping(_ errorMesage:String)->Void){
        
        Auth.auth().createUser(withEmail: emial, password: password){ (authData, error) in
            
            //En caso de error
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else{return}
            
            let storageProfileUserId =  StorageService.storageProfileId(userId: userId)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            StorageService.saveProfileImage(userId: userId, userName: userName, email: emial, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onSuccess: onSuccess, onError: onError)
        }
    }
    
    static func signIn(email:String, password: String,onSuccess: @escaping(_ user: UserModel)->Void, onError: @escaping(_ errorMesage:String)->Void){
        
        Auth.auth().signIn(withEmail: email, password: password){ (authData, error) in
            
            //En caso de error
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else{return}
            
            let firestoreUserId =  getUserId(userId: userId)
            
            firestoreUserId.getDocument{ (document, error) in
                
                if let dict =  document?.data(){
                    
                    guard let decodeUser = try? UserModel.init(fromDictionary: dict) else{return}
                    
                    onSuccess(decodeUser)
                }
            }
            
            
        }
        
    }
    
    
    
}


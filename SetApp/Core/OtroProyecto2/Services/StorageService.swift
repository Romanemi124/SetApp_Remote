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

/* Clase para guardar los datos del usuario incluido la foto de perfil */
class StorageService {
    
    //Acceso por referencia a la ubucación donde almancenaramos los datos
    static var storage =  Storage.storage()
    //Seleccianamos el sitio donde almancenaramos los datos
    static var storageRoot = storage.reference(forURL: "gs://setapp-a2961.appspot.com")
    //La carpeta donde almacenaremos los datos
    static var storageProfile = storageRoot.child("perfil")
    
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
                    
                    let user = UserModel.init(uid: userId, email: email, profileImageUrl: metaImageUrl, userName: userName, searchName: userName.splitString(), bio: "")
                    
                    guard let dict = try?user.asDictornary() else {return}
                    
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
    
}

//
//  StorageService.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 10/5/22.
//

import SwiftUI
import Kingfisher
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

/* Clase para acceder al almacen de FireBase */
class StorageService {
    
    //Acceso por referencia a la ubucación donde almancenaramos los datos
    static var storage = Storage.storage()
    //Seleccianamos el sitio donde almacenaremos los datos
    static var storageRoot = storage.reference(forURL: "gs://setapp-a2961.appspot.com")
    //La carpeta donde almacenaremos los datos
    static var storagePerfil = storageRoot.child(Claves.RutaColeccion.usuarioImagenPerfil)
    static var storagePost = storageRoot.child("posts")
    
    static var storeRoot =  Firestore.firestore()
    
    static func getUserId(userId: String)-> DocumentReference{
        return storeRoot.collection(Claves.RutaColeccion.usuarios).document(userId)
    }
    
    /* Función para identificar la imagen con el id del usuario */
    static func storagePerfilId(idUsuario: String) -> StorageReference{
        return storagePerfil.child(idUsuario)
    }
    
    /* Función buscar una publicación según el id del usuario */
    static func storagePostId(postId: String) -> StorageReference {
        return storagePost.child(postId)
    }
    
    /* Guardamos la foto de peril según el id del usuario que la ha seleccionado, además pasamos por parámetro los metadatos de la imagen y donde se va alamacenar en Firebase */
    static func guardarFotoPerfil(id: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference) {
        
        /* - imageData objecto de tipo Data, el cual es un búfer de bytes en la memoria
         - metaData objecto de tipo StorageMetadata es una clase que representa los metadatos de un objeto en Firebase Storage.
         Estos metadatos se devuelven en operaciones exitosas y se pueden usar para recuperar URL de descarga, tipos de contenido y una referencia de almacenamiento al objeto en cuestión.
         En este caso lo utilizaremso para alamcenar la foto de perfil
         - storageProfileImageRef sitio donde se almacenará la imagen */
        
        SubirImagen.subirImagen(imageData: imageData, metaData: metaData, storageProfileImageRef: storageProfileImageRef){ urlImagenPerfil in
            
            //Seleccionamos la colección donde se guardará el usuario ha registrar
            Firestore.firestore().collection(Claves.RutaColeccion.usuarios)
            //NODO principal del documnto, el cual debe coincidir con el id del documento
                .document(id)
            //Subimos la imagen de perfil
                .updateData([Claves.Usuario.urlImagenPerfil: urlImagenPerfil]){ _ in }
        }
        
    }
    //completion: @escaping (Result<Bool,Error>) -> Void
    static func eliminarFotoPerfil(id:String,completion: @escaping (Result<Bool,Error>) -> Void){
        
        storageRoot.child(Claves.RutaColeccion.usuarioImagenPerfil).child(id).delete{ error in
            
            if let error = error{
                print("Error: Al borrar foto de perfil \(error.localizedDescription)")
                completion(.failure(error))
            }else{
                print("Se ha borrado correctamente")
                completion(.success(true))
            }
        }
    }
    
    // MARK: - Borrar publicaciones
    /* Eliminar publicacion storage */
    static func eliminarPublicacion(idPublicacion:String,completion: @escaping (Result<Bool,Error>) -> Void){
        //storageRoot.child("posts").child(idPublicacion) seleccionamos la publicacion
        storageRoot.child("posts").child(idPublicacion).delete{ error in
            
            if let error = error{
                print("Error: Al borrar foto de perfil \(error.localizedDescription)")
                completion(.failure(error))
            }else{
                print("Se ha borrado correctamente")
                completion(.success(true))
            }
        }
    }
    
    static func savePostPhoto(userId: String, imageData: Data, categoria: String, nombreProducto: String, marca: String, valoracion: String,
                              link:String, puntosPositivos: String, puntosNegativos: String, postId: String, metadata: StorageMetadata, storagePostRef: StorageReference, usuario: UsuarioFireBase?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storagePostRef.putData(imageData, metadata: metadata) { (StorageMetadata, error) in
            
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
                
                storagePostRef.downloadURL { (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        let firestorePostRef = ServicioPost.PostUserId(userId: userId).collection("posts").document(postId)
                        
                        let post = Post.init(likes: [:], geoLocation: "", OwnerId: userId, postId: postId, username: usuario!.nombreUsuario, profile: usuario!.urlImagenPerfil, mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0, categoria: categoria, nombreProducto: nombreProducto, marca: marca, valoracion: valoracion, link: link, puntosPositivos: puntosPositivos, puntosNegativos: puntosNegativos)
                        
                        guard let dict = try? post.asDictionary() else { return }
                        
                        firestorePostRef.setData(dict) { (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                            
                            ServicioPost.AllPosts.document(postId).setData(dict)
                            onSuccess()
                        }
                    }
                }
            }
        }
    }
}

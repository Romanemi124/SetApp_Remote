//
//  StorageService2.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 10/5/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

/* Clase para acceder al almacen de FireBase */
class StorageService2 {
    
    //Acceso por referencia a la ubucación donde almancenaramos los datos
    static var storage =  Storage.storage()
    //Seleccianamos el sitio donde almacenaremos los datos
    static var storageRoot = storage.reference(forURL: "gs://setapp-a2961.appspot.com")
    //La carpeta donde almacenaremos los datos
    static var storagePerfil = storageRoot.child("perfil")
    static var storagePost = storageRoot.child("posts")
    
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
        
        SubirImagen2.subirImagen(imageData: imageData, metaData: metaData, storageProfileImageRef: storageProfileImageRef){ urlImagenPerfil in
            
            //Seleccionamos la colección donde se guardará el usuario ha registrar
            Firestore.firestore().collection(Claves.RutaColeccion.usuarios)
            //NODO principal del documnto, el cual debe coincidir con el id del documento
                .document(id)
            //Subimos la imagen de perfil
                .updateData([Claves.Usuario.urlImagenPerfil: urlImagenPerfil]){ _ in }
        }
        
    }
    
    //Guardar publicación
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

/* Estructura para subir la imagen de peril */
struct SubirImagen2{
    
    /*  @escaping son aquellos que pueden ser ejecutados o llamados más tarde, después de que la función que los contiene haya terminado de ejecutarse */
    static func subirImagen(imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference,completion: @escaping(String) -> Void){
        
        //Guardamos la imagen en Firebase
        storageProfileImageRef.putData(imageData, metadata: metaData){ (StorageMetadata, error) in
            
            //Mostramos los errores
            if let error = error{
                print("Debug: Failerd to uplad with error: \(error.localizedDescription)")
                return
            }
            
            storageProfileImageRef.downloadURL{ (url, error)in
                
                //Evaluamos si la imagen es una URL de tipo String, el caso que no lo sea sala de la función
                guard let imageUrl = url?.absoluteString else { return }
                
                //Guardamos la imagen
                completion(imageUrl)
                
            }
        }
    }
}



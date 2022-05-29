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

/*Clase principal que se usa para almacenar las publicaciones y mostrarlas en toda la aplicación de distinta manera*/
class ServicioPost: ObservableObject {
    
    static var Posts = StorageService.storeRoot.collection("posts")
    static var AllPosts = StorageService.storeRoot.collection("allPosts")
    
    //--Para el feed
    static var following = StorageService.storeRoot.collection("following")
    
    static func followingCollection(userId: String) -> CollectionReference {
        return following.document(userId).collection("following")
    }
    static func followingId(userId: String) -> DocumentReference {
        return following.document(Auth.auth().currentUser!.uid).collection("following").document(userId)
    }
    /*Para recoger todas las publicaciones que tengan el id del usuario*/
    static func PostUserId(userId: String) -> DocumentReference {
        
        return Posts.document(userId)
    }
    
    /*Una vez el usuario haya rellenado todos los campos, llama a este método que los recoge y llama al método del StorageService para guardarlos en las tablas de Firebase que se hayan seleccionado*/
    static func uploadPost(imageData: Data, categoria: String, nombreProducto: String, marca: String, valoracion: String, link: String, puntosPositivos: String, puntosNegativos: String, usuario: UsuarioFireBase?, onSuccess: @escaping() -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        
        /*Recoge el id del usuario que haya hecho la publicación*/
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        /*Los datos principales como el id del post, y el formato de imagen así como la carpeta donde se alamenarán todas las publicaciones*/
        let postId = ServicioPost.PostUserId(userId: userId).collection("posts").document().documentID
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        /*Método creado anteriormente para guardar las publicaciones en las tablas de Firebase*/
        StorageService.savePostPhoto(userId: userId, imageData: imageData, categoria: categoria, nombreProducto: nombreProducto, marca: marca, valoracion: valoracion, link: link, puntosPositivos: puntosPositivos, puntosNegativos: puntosNegativos, postId: postId, metadata: metadata, storagePostRef: storagePostRef, usuario: usuario, onSuccess: onSuccess, onError: onError)
    }
    
    
    /*Cargar los datos para luego pasarlo a objetos de tipo post*/
    static func loadUserPosts(userId: String, onSuccess: @escaping(_ posts: [Post]) -> Void) {
        
        /*Recoge todas las publicaciones del is del usuario que se le pase por parámetro ordenados de manera cronológica*/
        ServicioPost.PostUserId(userId: userId).collection("posts").order(by: "date", descending: true).getDocuments {
            (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error")
                return
            }
            
            /* Se almacenan todas las publicaciones recogidas en un array para luego mostrarlas por la vista*/
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
    
    //Se muestran todas las fotos de los usuarios de la aplicación
    func fetchPosts(completion: @escaping([PostCateg]) -> Void) {
        
        Firestore.firestore().collection("allPosts").order(by: "date", descending: true).getDocuments { snapshot, _ in
            
            guard let documents = snapshot?.documents else { return }
            let posts = documents.compactMap({ try? $0.data(as: PostCateg.self) })
            
            completion(posts)
        }
    }
    
    //Se muestran todas las fotos filtradas por categoria
    func fetchPostsCategoria(categoria: String, completion: @escaping([PostCateg]) -> Void) {
        
        Firestore.firestore().collection("allPosts").whereField("categoria", isEqualTo: categoria).getDocuments { snapshot, _ in
            
            guard let documents = snapshot?.documents else { return }
            var posts = documents.compactMap({ try? $0.data(as: PostCateg.self) })
                        
            //Ordenamos los documentos por fecha
            posts.sort(by: {$0.date > $1.date})

            completion(posts)
        }
    }
    
    //Se muestran todas las fotos filtradas por marca
    func fetchPostsMarcas(marca: String, completion: @escaping([PostCateg]) -> Void) {
        
        Firestore.firestore().collection("allPosts").whereField("marca", isEqualTo: marca).getDocuments { snapshot, _ in
            
            guard let documents = snapshot?.documents else { return }
            var posts = documents.compactMap({ try? $0.data(as: PostCateg.self) })
                        
            //Ordenamos los documentos por fecha
            posts.sort(by: {$0.date > $1.date})
            
            completion(posts)
        }
    }
}

//
//  ServicioProducto.swift
//  SetApp
//
//  Created by Emilio Roman on 24/4/22.
//

import Firebase
import UIKit

struct ServicioProducto {
    
    func uploadPublication(image: UIImage, categoria: String, nombreProducto: String, marca: String, valoracion: String, caracteristicas: String, completion: @escaping(Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        /*----------------------------*/
        
        //Evaluamos si hay una imagen y con image.jpegData(compressionQuality: 0.5) devolvemos un objeto de datos que contiene la imagen especificada en formato JPEG
        /* compressionQuality indicamos la calidad de la imagen JPEG resultante */
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        //Agregamos un id a la imagen
        let filename = NSUUID().uuidString
        //"/fotoPerfil/" será el nombre del directorio donde se alamcenará las fotos en el Storage de Firebase
        let ref = Storage.storage().reference(withPath: "/fotoPublicacion/\(filename)")
        
        /*----------------------------*/
        
        //Guardamos la imagen en Firebase
        ref.putData(imageData, metadata: nil){ _, error in
            
            //Mostramos los errores
            if let error = error{
                print("Debug: Failerd to uplad with error: \(error.localizedDescription)")
                return
            }
            
            //Guardamos en la imagen en formato URL
            ref.downloadURL{ imageUrl, _ in
                
                //Evaluamos si la imagen es una URL de tipo String, el caso que no lo sea sala de la función
                guard let imageUrl = imageUrl?.absoluteString else { return }
                
                let data = ["idUser": uid,
                            "UrlImagePublicacion": imageUrl,
                            "categoria": categoria,
                            "nombreProducto": nombreProducto,
                            "marca": marca,
                            "valoracion": valoracion,
                            "caracteristicas": caracteristicas,
                            "likes": 0,
                            "timestamp": Timestamp(date: Date())] as [String : Any]
                
                //Guardamos la imagen
                Firestore.firestore().collection("publicaciones").document()
                    .setData(data) { error in
                        
                        if let error = error {
                            print("Error al guardar la publicación: \(error.localizedDescription)")
                            completion(false)
                            return
                        }
                        
                        completion(true)
                    }
                
            }
        }
    }
    
    //Para poder ver las publicaciones en el apartado de home
    func fetchPublications(completion: @escaping([Publicacion]) -> Void) {
        Firestore.firestore().collection("publicaciones")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let publicaciones = documents.compactMap({ try? $0.data(as: Publicacion.self) })
            completion(publicaciones)
        }
    }
    
    //Para mostrar las publicaciones en los perfiles de los usuarios
    func fetchPublicationsUser(forUid uid: String, completion: @escaping([Publicacion]) -> Void) {
        Firestore.firestore().collection("publicaciones")
            .whereField("idUser", isEqualTo: uid)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let publicaciones = documents.compactMap({ try? $0.data(as: Publicacion.self) })
            completion(publicaciones.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
        }
    }
}


//
//  ServicioProducto.swift
//  SetApp
//
//  Created by Emilio Roman on 24/4/22.
//

import Firebase
import UIKit

struct ServicioProducto {
    
    func uploadPublication(/*image: UIImage,*/ categoria: String, nombreProducto: String, marca: String, valoracion: String, caracteristicas: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["idUser": uid,
                    /*"UrlImagePublicacion": image,*/
                    "categoria": categoria,
                    "nombreProducto": nombreProducto,
                    "marca": marca,
                    "valoracion": valoracion,
                    "caracteristicas": caracteristicas,
                    "likes": 0] as [String : Any]
        
        Firestore.firestore().collection("publicaciones").document()
            .setData(data) { _ in
                print("Publicación guardada")
            }
        
    }
}

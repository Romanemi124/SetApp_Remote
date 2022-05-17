//
//  SubirImagen.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 17/5/22.
//

import Foundation

import Firebase
import FirebaseAuth
import FirebaseStorage

/* Estructura para subir la imagen de peril */
struct SubirImagen{
    
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

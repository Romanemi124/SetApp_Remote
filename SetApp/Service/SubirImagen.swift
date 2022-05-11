//
//  SubirImagen.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 5/4/22.
//


/*DEPRECATED*/

import Firebase
import UIKit

struct SubirImagen{
    
    /*  @escaping son aquellos que pueden ser ejecutados o llamados más tarde, después de que la función que los contiene haya terminado de ejecutarse */
    static func subirImagen(image: UIImage, completion: @escaping(String) -> Void){
        
        //Evaluamos si hay una imagen y con image.jpegData(compressionQuality: 0.5) devolvemos un objeto de datos que contiene la imagen especificada en formato JPEG
        /* compressionQuality indicamos la calidad de la imagen JPEG resultante */
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        //Agregamos un id a la imagen
        let filename = NSUUID().uuidString
        
        //"/fotoPerfil/" será el nombre del directorio donde se alamcenará las fotos en el Storage de Firebase
        let ref = Storage.storage().reference(withPath: "/fotoPerfil/\(filename)")
          
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
                
                //Guardamos la imagen
                completion(imageUrl)
                
            }
        }
    }
}


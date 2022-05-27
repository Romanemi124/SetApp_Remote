//
//  ImagePicker.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 4/5/22.
//

import Foundation
import SwiftUI

/* Clase para la gestion de imagenes */
struct ImagePicker: UIViewControllerRepresentable {
    
    //Tipo de dato que se va a usar para recoger la foto y almacenarla
    @Binding var pickedImage : Image?
    @Binding var showImagePicker : Bool
    @Binding var imageData : Data
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(self)
    }
    
    //Controlador de la imagen para seleccionar el formato de imagen como la calidad de la misma
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate  = context.coordinator
        picker.allowsEditing =  true
        return picker
    }
    
    //Necesario para la estructura principal de la clase
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    //Coordinador que permite seleccionar la imagen ya sea desde la galería o cámara con la  calidad requerida
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]) {
            
            let uiImage = info[.editedImage] as! UIImage
            parent.pickedImage = Image(uiImage: uiImage)
            
            if let mediaData = uiImage.jpegData(compressionQuality: 0.5){
                
                parent.imageData = mediaData
            }
            
            parent.showImagePicker = false
            
        }
    }
    
}



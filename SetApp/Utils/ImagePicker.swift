//
//  ImagePicker.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 4/5/22.
//

import Foundation
import SwiftUI

/* Clase para la gestion de imagenes, se usa UIViewControllerRepresentable para mostrar en la vista la imagen que se escoga */
struct ImagePicker: UIViewControllerRepresentable {
    
    /* Tipo de dato que se va a usar para recoger la foto y almacenarla */
    @Binding var pickedImage : Image?
    @Binding var showImagePicker : Bool
    @Binding var imageData : Data
    var sourceType: UIImagePickerController.SourceType = .camera
    
    /* Este método se implementa cunado si los cambios del controlador de vista pueden afectar a otras partes de la aplicación. En su implementación, cree una instancia Swift personalizada que pueda comunicarse con otras partes de su interfaz, en este caso para la imagen seleccionada */
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(self)
    }
    
    /* Controlador de la imagen para seleccionar el formato de imagen como la calidad de la misma, toma la calidad y estructrua de la imagen */
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate  = context.coordinator
        /*Para poder editar las imágenes*/
        picker.allowsEditing =  true
        return picker
    }
    
    /*Necesario para la estructura principal de la clase*/
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    //Coordinador que permite seleccionar la imagen ya sea desde la galería o cámara con la  calidad requerida
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        /*Tipo objeto de la clase que se va a usar para seleccionar la foto*/
        var parent: ImagePicker
        
        /*Inizializamos la clase recogiendo ese valor de la imagen*/
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]) {
            
            /*Una vez la imagen ha sido seleccionada se guarda esa imagen como tipo UIImage, debido a que cuando se selecciona la imagen es de tipo Image, se pasa a un tipo de imagen*/
            let uiImage = info[.editedImage] as! UIImage
            parent.pickedImage = Image(uiImage: uiImage)
            
            /*Una vez la imagen ha sido guardada como otra  variable se  compresiona la calidad de la imagen para guardarla en Firebase*/
            if let mediaData = uiImage.jpegData(compressionQuality: 0.5){
                
                parent.imageData = mediaData
            }
            
            /*Retorna que la imagen ya ha sido almacenada para poderla publicar*/
            parent.showImagePicker = false
            
        }
    }
    
}



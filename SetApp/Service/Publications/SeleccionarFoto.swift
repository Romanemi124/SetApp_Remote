//
//  SeleccionarFoto.swift
//  SetApp
//
//  Created by Emilio Roman on 24/4/22.
//

import Foundation
import SwiftUI

/*Esta clase se usa para acceder a la galería y a la cámara*/
class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /*El formato  de imagen y comprobar si se ha seleccionado una imagen o no*/
    @Binding var image: Image?
    @Binding var isShown: Bool
    
    /*Para inicializar la clase es necesario estos dos atributos*/
    init(image: Binding<Image?>, isShown: Binding<Bool>) {
        _image = image
        _isShown = isShown
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
                               [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? Image {
            image = uiImage
            isShown = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
} 
 
struct SeleccionarFoto: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    @Binding var image: Image?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context:
        UIViewControllerRepresentableContext<SeleccionarFoto>) {
    }
    
    func makeCoordinator() -> SeleccionarFoto.Coordinator {
        return ImagePickerCoordinator(image: $image, isShown: $isShown)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SeleccionarFoto>) ->
    UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
}

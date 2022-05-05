////
////  ImagePicker.swift
////  TwitterSwiftUI
////
////  Created by Omar Bonilla Varela on 5/4/22.
////
//
//import SwiftUI
//
///* UIViewControllerRepresentable Una vista que representa un controlador de vista UIKit, de esta forma, podemos acceder a carterísticas de UKit*/
//struct ImagePicker: UIViewControllerRepresentable{
//
//    /* Al utilizar UIViewControllerRepresentable para que el controlador de vista se coordine con otras vistas de SwiftUI, debe proporcionar una clase Coordinator para facilitar esas interacciones
//     Una clase Coordenador es un objeto que sirve para comunicar el comportamiento del controlador de vista Ukit y el estado a los objetos de SwiftUI */
//
//    /* Variable  será la encargada de almacenar la imagen del usuario y cada vez que se cambie se notificará a la vista donde se incluya el componente ImagePicker, permitiéndonos actualizar la vista para mostrar esta imagen.*/
//    @Binding var selectedImage: UIImage?
//    //Animación quitar el buscador de imágenes( Galería)
//    @Environment(\.presentationMode) var presentationMode
//
//    /* Crea la instancia personalizada que usa para comunicar los cambios de su controlador de vista a otras partes de su interfaz de SwiftUI. Con esto SwiftUI llamará automáticamente al implementar la clase */
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//
//    /* Crea el objeto del controlador de vista y configura su estado inicial */
//    func makeUIViewController(context: Context) -> some UIViewController {
//
//        //Instanciamos la imagen
//        let picker = UIImagePickerController()
//        // notificar cuando se haya seleccionado la imagen y su ubicación correspondiente
//        picker.delegate = context.coordinator
//
//        return picker
//    }
//    /* Actualiza el estado del controlador de vista especificado con nueva información de SwiftUI */
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//    }
//}
//
//extension ImagePicker{
//
//    /* Es necesario heredar de NSObject para indicar ,al Coordinador, la acción que se va realizar y si la admite */
//    /*  UINavigationControllerDelegate es una clase de controlador de vista que facilita la navegación entre varios controladores de vista, esencial para buscar la imagen deseada
//     UIImagePickerControllerDelegate permite acceder a la galería de imágenes y notificar cuando se ha seleccionado una imagen */
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
//
//        /* Creamos el objecto ImagePicker permitirá mostrar la galería del usuario */
//        let parent : ImagePicker
//
//        //Creamos el constructor
//        /* De esta forma indicamos al coordinador cuál es su clase padre, para que luego en esa clase padree pueda modificar los valores allí directamente */
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        //picker: UIImagePickerController seleccionamos la imagen elegidad
//        /*  picker: UIImagePickerController seleccionamos la imagen elegida
//         didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any] indica cuando ha seleccionado una imagen [UIImagePickerController.InfoKey : Any] restringe que solo se pueda utilizar una imagen */
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//            //Controla si ha elegido la imagen o no
//            guard let image = info[.originalImage] as? UIImage else {return}
//
//            //Guardamos la imagen seleccionada
//            parent.selectedImage = image
//
//            //Nos saca de la galería al elegir la imaen
//            parent.presentationMode.wrappedValue.dismiss()
//
//        }
//    }
//}
//

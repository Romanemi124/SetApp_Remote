COLORES PRINCIPALES
- Morado claro - Color(red: 0.721, green: 0.491, blue: 0.849)
- Morado normal - Color(red: 0.331, green: 0.074, blue: 0.423)
- Morado oscuro - Color(red: 0.113, green: 0.031, blue: 0.16)


VARIABLES DE LAS VISTAS PRINCIPALES

VISTA ContentView
-

VISTA LoginView
- emailTxt
- passwordTxt

VISTA RegistroView
- nombreTxt
- telefonoTxt
- sexoTxt
- nacimientoTxt
- correoTxt
- contrasenaTxt

VISTA RecuPassView
- emailAuxTxt

VISTA NuevaPassView
- nuevaPassTxt
- repePassTxt

VISTA PerfilView
- nombreTxt
- seguidosTxt
- seguidoresTxt
- fotoPerfil

PUBLICACIÓN
- id
- categoria
- foto
- nombreProducto
- marca
- valoración
- características
- likes









//
//  ServicioProducto.swift
//  SetApp
//
//  Created by Emilio Roman on 24/4/22.
//

import Firebase
import UIKit

struct ServicioProducto {
    
    func uploadPublication(image: UIImage, categoria: String, nombreProducto: String, marca: String, valoracion: String, caracteristicas: String) {
        
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
        
        /*
        let data = ["idUser": uid,
                    "UrlImagePublicacion": imageUrl,
                    "categoria": categoria,
                    "nombreProducto": nombreProducto,
                    "marca": marca,
                    "valoracion": valoracion,
                    "caracteristicas": caracteristicas,
                    "likes": 0] as [String : Any]
         */
        
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
                            "likes": 0] as [String : Any]
                
                //Guardamos la imagen
                Firestore.firestore().collection("publicaciones").document()
                    .setData(data) { _ in
                        print("Publicación guardada")
                    }
                
            }
        }
        
        /*
        Firestore.firestore().collection("publicaciones").document()
            .setData(data) { _ in
                print("Publicación guardada")
            }
        */
    }
}











//
//  EditPubliView.swift
//  SetApp
//
//  Created by Emilio Roman on 17/4/22.
//

import SwiftUI
import Kingfisher

struct EditPubliView: View {
    
    //@Binding var image: UIImage?
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var mode
    
    //Atributos que tiene la publicación
    @State private var categoria: String = ""
    @State private var nombreProducto: String = ""
    @State private var marca: String = ""
    @State private var valoracion: String = ""
    @State private var caracteristicas: String = ""
    
    @ObservedObject var viewModel = GuardarPublicacionViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color(red: 0.113, green: 0.031, blue: 0.16)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                
                //Parte superior de la vista
                /* Al llamar a esta variable mostramos la parte de la vista guarda en ella */
                headerView
                    .padding(.bottom, 10)
                
                //Información del usuario
                editAccount
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct EditPubliView_Previews: PreviewProvider {
    static var previews: some View {
        EditPubliView(image: .constant(UIImage(named: "publi")))
    }
}

extension EditPubliView {
    
    //Variable guardará a la parte superior de la vista
    var headerView: some View{
        
        /* ZStack El componente ZStack permite apilar vistas en el eje Z, lo que da resultado que las vistas se solapen una sobre otra
         bottomLeading orientar los elementos abajo y hacia la derecha */
        ZStack(alignment: .bottomLeading){
            //Color de fondo
            Color(red: 0.113, green: 0.031, blue: 0.16)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            HStack(spacing:260) {
                
                Button{
                    //Cambiamos el valor de la variable para que vuelva a la anterior vista
                    mode.wrappedValue.dismiss()
                }label: {
                    
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 25, height: 20)
                        .foregroundColor(.white)
                        .padding(15)
                }
                HStack {
                    
                    Button{
                        
                        //Una vez se hayan rellenado todos los campos, esta función se encargará de guardar esta publicación
                        
                        viewModel.uploadPublicacion(withImage: image ?? UIImage(named: "publi")!, withCategoria: categoria, withNombreProducto: nombreProducto, withMarca: marca, withValoracion: valoracion, withCaracteristicas: caracteristicas)
                    }label: {
                        
                        Image(systemName: "icloud.and.arrow.up.fill")
                            .resizable()
                            .frame(width: 35, height: 30)
                            .foregroundColor(.white)
                            .padding(15)
                    }
                }
            }
            .padding(.leading)
            .padding(.bottom, 12)
            .padding(.top, 12)

        }
        .frame(height: 30)
    }
    
    //En esta parte de la vista, se podrán rellenar los datos de la publicación, así como ver la publicación que se quiere subir al perfil
    var editAccount: some View{
            
        //Todo se colocará en la parte superior de la vista
        ZStack(alignment: .topLeading) {
            
            Color(red: 0.113, green: 0.031, blue: 0.16)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            VStack {
                
                Text("Editar publicación")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(.bottom, 25)
                    .padding(.top, 25)
                
                //Se cargará la imagen anterior para poder ver la publicación
                Image(uiImage: image ?? UIImage(named: "publi")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .cornerRadius(0)
                
                //Parte donde se encontrarán los campos a rellenar
                ScrollView {
                    
                    Group{
                        
                        CamposEntrada(placeholder: "Categoría", isSecureField: false,text: $categoria)
                        
                        CamposEntrada(placeholder: "Nombre componente", isSecureField: false,text: $nombreProducto)
                        
                        CamposEntrada(placeholder: "Marca",isSecureField: false, text: $marca)
                        
                        CamposEntrada(placeholder: "Valoración", isSecureField: false,text: $valoracion)
                        
                        CamposEntrada(placeholder: "Características",isSecureField: false, text: $caracteristicas)
                    }
                    .padding(.top, 30)
                }
            }
        }
    }
}


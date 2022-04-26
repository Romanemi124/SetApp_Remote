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
    
    //Para poder subir la foto y pasarla a la función de guardar
    @State private var showImagePicker = false
    @State private var publicationImage: Image?
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
            .onReceive(viewModel.$didUploadPublication) { success in
                if success {
                    mode.wrappedValue.dismiss()
                }
            }
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
                        
                        if let selectedImage = image {
                            
                            viewModel.uploadPublicacion(withImage: selectedImage, withCategoria: categoria, withNombreProducto: nombreProducto, withMarca: marca, withValoracion: valoracion, withCaracteristicas: caracteristicas)
                        }
                    }label: {
                        
                        Image(systemName: "icloud.and.arrow.up.fill")
                            .resizable()
                            .frame(width: 35, height: 30)
                            .foregroundColor(.white)
                            .padding(15)
                    }
                    .sheet(isPresented: $showImagePicker,
                           onDismiss: loadImage){
                        
                        //Guardamos la imagen seleccionada
                        ImagePicker(selectedImage: $image)
                        
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
    
    //Cargar las imágenes
    func loadImage(){
        //Guardamos la imagen en la variable
        guard let selectedImage = image else { return }
        publicationImage = Image(uiImage: selectedImage)
    }
}

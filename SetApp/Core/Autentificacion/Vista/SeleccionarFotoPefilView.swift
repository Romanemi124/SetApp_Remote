//
//  PhotoSelectorView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 5/4/22.
//

import SwiftUI

struct SeleccionarFotoPefilView: View {
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AutentificacionModelView
    
    var body: some View {
        
        //Diseño de la vista principal de la app
        ZStack {
            
            //Imagen de fondo de la vista
            EstablecerFondoPrincipal()
            
            VStack {
                
                CabeceraAutentificacionView(titulo1: "Crear cuenta", titulo2: "Seleccionar  imagen de perfil")
                
                Button{
                    //Activar selector de imágenes del dispositivo
                    showImagePicker.toggle()
                    
                }label: {
                    
                    //Si ya se ha elegido una imagen
                    if let profileImage = profileImage {
                        
                        profileImage
                            .resizable()
                            .modifier(ProfileImageModifier())
                        
                    } else {
                        
                        Image("FotoPerfil").resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color(.white))
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                    }
                    
                }
                .sheet(isPresented: $showImagePicker,
                       onDismiss: loadImage){
                    
                    //Guardamos la imagen seleccionada
                    //ImagePicker(selectedImage: $selectedImage)
                    
                }
            .padding(.top, 100)
            .padding(.bottom, 20)
                
                //Botón para continuar el registro, solo se muestra cuando se ha elegido la foto
                if let selectedImage = selectedImage {
                    
                    //Botón de Registarse
                    Button{
                     
                        viewModel.subirImagenPerfil(selectedImage)
                        
                    }label:{
                        
                        PrimaryButton(title: "Continuar")
                    }
                }
            }
        }
    }
    
    
    //Cargar las imágenes
    func loadImage(){
        //Guardamos la imagen en la variable
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.systemBlue))
            .scaledToFill()
            .frame(width: 180, height: 180)
            .clipShape(Circle())
    }
}

struct SeleccionarFotoPefilView_Previews: PreviewProvider {
    static var previews: some View {
        SeleccionarFotoPefilView()
    }
}

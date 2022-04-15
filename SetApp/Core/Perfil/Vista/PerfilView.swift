//
//  ProfileView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import SwiftUI
import Kingfisher

struct PerfilView: View {
    
    //Varibale necesario para la animación
    @Namespace var animation
    @Environment(\.presentationMode) var mode
    //Creamos el objeto usuario que luego se va mostrar sus datos
    private let usuario:Usuario
    
    //Inicializamos el usuario
    init(usuario: Usuario){
        self.usuario = usuario
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            //Parte superior de la vista
            /* Al llamar a esta variable mostramos la parte de la vista guarda en ella */
            headerView
                .padding(.bottom, 10)
            
            //Botones de acciones(Notificaciones + editar perfil)
            userInfoDetailsInfo
            
            //Información del usuario
            actionButtons
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView(usuario: Usuario(id: NSUUID().uuidString, nombreUsuario: "", nombreCompleto: "", email: "", sexo: "", fechaNacimiento: "", UrlImagenPerfil: ""))
    }
}


/* Método que contendrá:
 1º La parte superior de nuesta vista(flecha atrás + foto de perfil + color de fondo)
 2º  */
/* Las extensiones agregan nueva funcionalidad a una clase, estructura, enumeración o tipo de protocolo existente. */
extension PerfilView {
    
    //Variable guardará a la parte superior de la vista
    var headerView: some View{
        
        /* ZStack El componente ZStack permite apilar vistas en el eje Z, lo que da resultado que las vistas se solapen una sobre otra
         bottomLeading orientar los elementos abajo y hacia la derecha */
        ZStack(alignment: .bottomLeading){
            //Color de fondo
            Color(red: 0.113, green: 0.031, blue: 0.16)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            HStack(spacing:30) {
                //Flecha de atrás
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
                
                //Nombre completo + verficado
                HStack {
        
                    
                    //Nombre de usario
                    Text("@\(usuario.nombreUsuario)")
                        .font(.title3).bold()
                        .foregroundColor(.white)
                    
                    //Verificado
                    /*
                    Image(systemName: "checkmark.seal.fill").foregroundColor(Color(.systemBlue))
                     */
                }
            }
            .padding(.leading)
            .padding(.bottom, 12)
            .padding(.top, 12)

        }
        .frame(height: 30)
    }
    //Variable que guarda los botones de acciones(Notificaciones + editar perfil)
    var userInfoDetailsInfo: some View{
        
        ZStack{
            
            //Foto de perfil del usuario
            KFImage(URL(string: usuario.UrlImagenPerfil))
                .resizable()
            
        }
        .frame(height: 200)
    }
    
    var actionButtons: some View{
        
        ZStack(alignment: .bottomLeading){
            //Color de fondo
            Color(red: 0.113, green: 0.031, blue: 0.16)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            VStack {
                
                HStack{
                    
                    //Nombre de usario
                    Text(usuario.nombreCompleto)
                        .font(.title)
                        .foregroundColor(.white)
                    Spacer()
                }
                //trailing darle relleno al borde
                .padding(.leading, 20)
                .padding(.top, 15)
                
                //Parte donde aparecen los seguidores y seguidos
                HStack(spacing:40) {
                    
                    //Estado de usuario
                    Text("seguidores").font(.subheadline)
                        .foregroundColor(.white)
                
                    Text("siguiendo").font(.subheadline)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                //trailing darle relleno al borde
                .padding(.leading, 20)
                .padding(.top, 1)
                
                //Botones donde se puede seguir y donar
                HStack(spacing:40) {
                    
                    //Botón para seguir o dejar de seguir
                    //En caso del usuario tiene que aparecer editar perfil
                    NavigationLink{
                        
                        EditPerfilView(usuario: usuario)
                            .navigationBarHidden(true)
                        
                    } label: {
                            
                        Text("Seguir")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: 80)
                            .frame(height: 6)
                            .padding()
                            .background(Color(red: 0.331, green: 0.074, blue: 0.423))
                            .cornerRadius(10)
                    }
                
                    Button(action: {
                        
                        print("donaciones")
                    }, label: {
                        
                        Text("Donar")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: 80)
                            .frame(height: 6)
                            .padding()
                            .background(Color(red: 0.331, green: 0.074, blue: 0.423))
                            .cornerRadius(10)
                    })
                    
                    Spacer()
                }
                //trailing darle relleno al borde
                .padding(.leading, 20)
                .padding(.top, 5)
                .padding(.bottom, 20)
            }
        }
        .frame(height: 100)
        .padding(.top, 16)
    }
}


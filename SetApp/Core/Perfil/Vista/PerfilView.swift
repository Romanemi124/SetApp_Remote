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
            
            //Botones de acciones(Notificaciones + editar perfil)
            actionButtons
            
            //Información del usuario
            userInfoDetailsInfo
            
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
            Color(.systemIndigo)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            VStack {
                //Flecha de atrás
                Button{
                    //Cambiamos el valor de la variable para que vuelva a la anterior vista
                    mode.wrappedValue.dismiss()
                }label: {
                    
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 16, y: -4)
                }
                //Foto de perfil
                KFImage(URL(string: usuario.UrlImagenPerfil))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                //Elegimos el punto donde se va ubicar
                    .offset(x: 16, y: 12)
                
            }
        }
        .frame(height: 96)
        
    }
    //Variable que guarda los botones de acciones(Notificaciones + editar perfil)
    var actionButtons: some View{
        
        VStack{
            
            HStack(spacing:12){
                
                Spacer()
                
                //Notificaciones
                Image(systemName: "bell.badge")
                    .font(.title3).padding(6)
                    .overlay(Circle().stroke(Color.gray,lineWidth: 0.75))
                
                //Editar perfil
                Button{
                    
                }label: {
                    Text("Edit Profile")
                        .font(.subheadline).bold()
                        .frame(width: 120, height: 32)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray,lineWidth: 0.75))
                }
            }
            //trailing darle relleno al borde
            .padding(.trailing)
        }
        
    }
    
    var userInfoDetailsInfo: some View{
        VStack(alignment: .leading, spacing: 4){
            
            //Nombre completo + verficado
            HStack {
                //Nombre completo
                Text(usuario.nombreCompleto).font(.title2).bold()
                
                Image(systemName: "checkmark.seal.fill").foregroundColor(Color(.systemBlue))
            }
            
            //Nombre de usario
            Text("@\(usuario.nombreUsuario)").font(.subheadline).foregroundColor(.gray)
            
            //Estado de usuario
            Text("I´m defender of truth").font(.subheadline).padding(.vertical)
            
            //Ubicación y enlaces usuario
            HStack(spacing: 24){
                //Ubicación
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                    Text("Gothan, NY")
                }
                
                //Enlaces usuario
                HStack{
                    Image(systemName: "link")
                    Text("www.thebatman.com")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            
        }
        .padding(.horizontal)
    }
    
}

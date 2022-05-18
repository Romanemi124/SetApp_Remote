//
//  ProfileView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import SwiftUI
import Kingfisher
import FirebaseAuth

struct PerfilView: View {
    
    @StateObject var viewModel = PerfilViewModel()
    
    @EnvironmentObject var session: EstadoAutentificacionUsuario
    @State private var selection = 0
    
    //Para volver la vista hacia atrás
    @Environment(\.presentationMode) var mode
    
    //Irse a otra vista
    private var editarPerfil = false
    
    //Inicilizamos la clase con el objeto usuario que pasamos por parámetro
    /*
     @ObservedObject var viewModel:  PerfilViewModel
     
     init(user: UsuarioFireBase) {
     self.viewModel = PerfilViewModel(user: user)
     }*/
    
    var body: some View {
        
        ZStack {
            
            FondoPantallasApp()
            
            ScrollView {
                
                VStack {
                    
                    //Vista superior del perfil
                    PerfilHeader(usuario: self.session.usuario, postCount: viewModel.posts.count, seguidos: $viewModel.seguidos, seguidores: $viewModel.seguidores)
                    
                    //Editar y Eliminar Cuenta
                    HStack{
                        
                        //Botón para editar el perfil en caso de su cuenta, o seguir a la persona en caso de otro usuario de la app
                        HStack {
                            
                            NavigationLink{
                                
                                EditarPerfilView(user: self.session.usuario)
                                
                            }label: {
                                Text("Editar").foregroundColor(.white)
                            }
                            
                        }
                        .padding()
                        //Recuadro que enmarca el texto
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                            //Quitar el fondo del rectángulo con la opacidad del color
                                .stroke(.white, lineWidth: 2)
                        )
                        //Separación de los laterales de la vista
                        .cornerRadius(10)
                        .padding(35)
                        //Para que sólo se mueva uno
                        .frame(height: 70)
                        
                        //Botón para ajustes de perfil(cambiar de contraseña y eliminar cuenta)
                        HStack {
                            
                            NavigationLink{
                                
                                AjustePerfilView()
                                
                            }label: {
                                Text("Ajustes").foregroundColor(.white)
                            }
                            
                        }
                        .padding()
                        //Recuadro que enmarca el texto
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                            //Quitar el fondo del rectángulo con la opacidad del color
                                .stroke(.white, lineWidth: 2)
                        )
                        //Separación de los laterales de la vista
                        .cornerRadius(10)
                        .padding(35)
                        //Para que sólo se mueva uno
                        .frame(height: 70)
                        
                        
                    }

                }
                .padding(.bottom, 10)
                
                Picker("", selection: $selection) {
                    Image(systemName: "circle.grid.2x2.fill").tag(0)
                    Image(systemName: "suit.heart.fill").tag(1)
                    Image(systemName: "star.fill").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                
                //Dependiendo de la selcción aparecerán las publicaciones ordenadas de una forma u otra
                if selection == 0 {
                    
                    VStack {
                        
                        ForEach(self.viewModel.posts, id:\.postId) { (post) in
                            
                            PerfilPublicacion(post: post)
                        }
                    }
                    .padding()
                    .padding(.bottom, 150)
                }
            }
        }
        .onAppear {
            viewModel.cargarPostUser(userId: self.session.usuario.id!)
        }
    }
}

//Para mostrar el orden de las publicaciones
/*
 func getIndex(post: Post) -> Int {
 
 return _post.firstIndex { currentPost in
 return post.postId == currentPost.postId
 } ?? 0
 }*/

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        //PerfilView(user: UsuarioFireBase(id: NSUUID().uuidString, nombreCompleto: "j", nombreUsuario: "j", email: "j", sexo: "j", fechaNacimiento: "j", urlImagenPerfil: "j")
        PerfilView()
    }
}

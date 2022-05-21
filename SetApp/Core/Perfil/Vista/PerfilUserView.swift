//
//  PerfilUserView.swift
//  SetApp
//
//  Created by Emilio Roman on 16/5/22.
//

import SwiftUI
import Kingfisher
import FirebaseAuth

struct PerfilUserView: View {
    
    var user: UsuarioFireBase
    var boolCheck: Bool
    @StateObject var viewModel = PerfilViewModel()
    
    @State private var selection = 0
    
    var body: some View {
        
        ZStack {
            
            FondoPantallasApp()
            
            ScrollView {
                
                VStack {
                    
                    //Vista superior del perfil
                    PerfilHeader(usuario: user, postCount: viewModel.posts.count, seguidos: $viewModel.seguidos, seguidores: $viewModel.seguidores)
                    
                    //Botón para editar el perfil en caso de su cuenta, o seguir a la persona en caso de otro usuario de la app
                    HStack {
                        
                        FollowButton(user: user, followCheck: boolCheck, followingCount: $viewModel.seguidos, followersCount: $viewModel.seguidores)
                    }
                    .padding(.bottom, 10)
                    
                    Picker("", selection: $selection) {
                        Image(systemName: "circle.grid.2x2.fill").tag(0)
//                        Image(systemName: "suit.heart.fill").tag(1)
//                        Image(systemName: "star.fill").tag(2)
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
                viewModel.cargarPostUser(userId: user.id!)
            }
        }
    }
}

/*
struct PerfilUserView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilUserView(user: UsuarioFireBase(id: NSUUID().uuidString, nombreCompleto: "j", nombreUsuario: "j", email: "j", sexo: "j", fechaNacimiento: "j", urlImagenPerfil: "j"))
    }
}
 */

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
    
    @StateObject var servicioPostUser = PerfilViewModel()
    
    @EnvironmentObject var session: EstadoAutentificacionUsuario
    @State private var selection = 0
    
    var body: some View {
        
        ZStack {
            
            FondoPantallasApp()
            
            ScrollView {
                
                VStack {
            
                    PerfilHeader(usuario: self.session.usuario, postCount: servicioPostUser.posts.count, seguidos: $servicioPostUser.seguidos, seguidores: $servicioPostUser.seguidores)
                    
                    //Botón para editar el perfil en caso de su cuenta, o seguir a la persona en caso de otro usuario de la app
                    HStack {
                        Button(action: {}) {
                            Text("Editar perfil")
                                .foregroundColor(.white)
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
                           
                            ForEach(self.servicioPostUser.posts, id:\.postId) { (post) in
                                
                                PerfilPublicacion(post: post)
                            }
                        }
                        .padding()
                        .padding(.bottom, 150)
                    }
                }
            }
            .onAppear {
                self.servicioPostUser.cargarPostUser(userId: Auth.auth().currentUser!.uid)
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
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView()
    }
}

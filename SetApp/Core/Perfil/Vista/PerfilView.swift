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
    
    @ObservedObject var viewModel:  PerfilViewModel
    
    @EnvironmentObject var session: EstadoAutentificacionUsuario
    @State private var selection = 0
    
    //Para volver la vista hacia atrás
    @Environment(\.presentationMode) var mode
    
    //Inicilizamos la clase con el objeto usuario que pasamos por parámetro
    init(user: UsuarioFireBase) {
        self.viewModel =  PerfilViewModel(user:user)
    }
    
    var body: some View {
        
        ZStack {
            
            FondoPantallasApp()
            
            ScrollView {
                
                VStack {
                    
                    //Vista superior del perfil
                    headerView
                    
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
                self.viewModel.cargarPostUser(userId: Auth.auth().currentUser!.uid)
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
        PerfilView(user: UsuarioFireBase(id: NSUUID().uuidString, nombreCompleto: "j", nombreUsuario: "j", email: "j", sexo: "j", fechaNacimiento: "j", urlImagenPerfil: "j"))
    }
}


extension PerfilView {
    
    //Variable guardará a la parte superior de la vista
    var headerView: some View{
        
        VStack{
            
            HStack(spacing: 20) {
                
                Button(action: {
                    
                    //Cambiamos el valor de la variable para que vuelva a la anterior vista
                    mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                
                Text("@\(viewModel.user.nombreUsuario)")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
            }
            .padding(.top, 15)
            
            HStack {
                
                VStack {
                    
                    //WebImage(url: URL(string: usuario!.urlImagenPerfil)!)
                    KFImage(URL(string:viewModel.user.urlImagenPerfil))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .trailing)
                        .padding(.leading)
                    
                    
                    Text(viewModel.user.nombreCompleto)
                        .font(.headline)
                        .bold()
                        .padding(.leading)
                        .foregroundColor(.white)
                }
                .navigationTitle("Perfil")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    
                    //Cambiamos el valor de la variable para que vuelva a la anterior vista
                    mode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .foregroundColor(.red)
                })
                
                /* Aquí hay Falloooooooooos */
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack {
                            
                            Text("\(viewModel.posts.count)").font(.title3)
                                .foregroundColor(.white)
                            Text("Publicaciones")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        //.padding(.top, 30)
                        
                        Spacer()
                        
                        VStack {
                            Text("\(viewModel.seguidos)").font(.title3)
                                .foregroundColor(.white)
                            Text("Seguidores")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        //.padding(.top, 30)
                        
                        Spacer()
                        
                        VStack {
                            
                            Text("\(viewModel.seguidores)").font(.title3)
                                .foregroundColor(.white)
                            Text("Seguidos")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        //.padding(.top, 30)
                        
                        Spacer()
                    }
                }
            }
        }
    }
    
}

import SwiftUI
import Kingfisher
import FirebaseAuth

struct PerfilView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    @ObservedObject var informacionPerfil:  PerfilInformacionViewModel
    
    @EnvironmentObject var usuarioSesion: EstadoAutentificacionUsuario
    @State private var selection = 0
    
    //Para volver la vista hacia atrás
    @Environment(\.presentationMode) var mode
    
    //Inicializamos la clase con el objeto usuario que pasamos por parámetro
    init(user: UsuarioFireBase) {
        self.informacionPerfil =  PerfilInformacionViewModel(user:user)
    }
    
    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
        
            //Mostramos la vista deseada
            ZStack {
                
                FondoPantallasApp()
                
                ScrollView {
                    
                    VStack {
                        
                        //Vista superior del perfil
                        //PerfilHeader(usuario: usuarioSesion.usuario, postCount: informacionPerfil.posts.count, seguidos: $informacionPerfil.seguidos, seguidores: $informacionPerfil.seguidores)
                        headerPerfil
                        
                        
                        //Editar y Eliminar Cuenta
                        HStack{
                            
                            //Botón para editar el perfil en caso de su cuenta, o seguir a la persona en caso de otro usuario de la app
                            HStack {
                                
                                NavigationLink{
                                    
                                    EditarPerfilView(user: self.usuarioSesion.usuario)
                                    
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
    //                    Image(systemName: "suit.heart.fill").tag(1)
    //                    Image(systemName: "star.fill").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                    
                    //Dependiendo de la selcción aparecerán las publicaciones ordenadas de una forma u otra
                    if selection == 0 {
                        
                        VStack {
                            
                            ForEach(self.informacionPerfil.posts, id:\.postId) { (post) in
                                
                                PerfilPublicacion(post: post)
                            }
                        }
                        .padding()
                        .padding(.bottom, 150)
                    }
                }
            }
            .onAppear {
                informacionPerfil.cargarPostUser(userId: self.usuarioSesion.usuario.id!)
            }
            
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
        PerfilView(user: UsuarioFireBase(id: NSUUID().uuidString, nombreCompleto: "j", nombreUsuario: "j", email: "j", sexo: "j", fechaNacimiento: "j", urlImagenPerfil: "j"))
    }
}

extension PerfilView{
    
    //Vista superior del perfil(informacion del usuario) y los seguidores, seguidos y publicaciones
    var headerPerfil: some View{
        
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
                
                Text("@\(informacionPerfil.user.nombreUsuario)")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
            }
            .padding(.top, 15)
            
            HStack {
                
                VStack {
                    
                    //WebImage(url: URL(string: usuario!.urlImagenPerfil)!)
                    KFImage(URL(string: informacionPerfil.user.urlImagenPerfil))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .trailing)
                        .padding(.leading)
                    
                    Text(informacionPerfil.user.nombreCompleto)
                        .font(.headline)
                        .bold()
                        .padding(.leading)
                        .foregroundColor(.white)
                }
                
                
                //Seguidores
                PerfilSeguidoresView(postCount: informacionPerfil.posts.count, seguidos: $informacionPerfil.seguidos, seguidores: $informacionPerfil.seguidores)
            }
            
        }
        
    }
    
}

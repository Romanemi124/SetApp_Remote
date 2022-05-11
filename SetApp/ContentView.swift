//
//  ContentView.swift
//  SetApp
//
//  Created by Emilio Roman on 3/4/22.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    //Variable que controla el menu
    @State private var mostraMenu = false
    
    /* @EnvironmentObject es un objeto que vive en el entorno actual, disponible para leer cuando sea necesario. Un objeto de entorno se define en una vista de nivel superior y cualquier vista secundaria puede acceder a él si es necesario
     Esto nos permite compartir datos del modelo en cualquier lugar que sea necesario, al mismo tiempo que garantiza que nuestras vistas se mantengan actualizadas automáticamente cuando cambien los datos.
     En este caso compartiremos con las demás vistas la credenciales del usuario */
    @EnvironmentObject var vistaModelo: AutentificacionModelView
    
    //Para OtroProyecto
    // @EnvironmentObject var informacionUsuario: InformacionUsuario
    
    //Para OtroProyecto
    @EnvironmentObject var estadoUsuario: EstadoAutentificacionUsuario
    
    var body: some View {
    
        /* Lógica para verificar la autentificación de los usuarios */
        Group{
            if estadoUsuario.estaUsuarioAutentificado == .indefinido{
                /* Se añadirá una vista cuando el usuario no esté autentificando. Tras aparecer está vista llamará a la función y al comprobar que no se ha auntetificado refrescará la vista y llamará a la vista LoginView() */
                Text("Cargando..")
            }else if estadoUsuario.estaUsuarioAutentificado == .iniciarSesion{
                /* Cuando el usuario esté logeado nos mostrará la pantalla principal de la aplicación */
                mainInterfaceView
            }else if estadoUsuario.estaUsuarioAutentificado == .cerrarSesion{
                /* Cuando el usuario no está logeado nos mostrará la pantalla de Login */
                IniciarSesionView()
            }
            //Escuchará los cambios que se producirán en las vistas
        }.onAppear{
            
            //Buscar los cambios de estado de autentificación de los usuarios
            self.estadoUsuario.configuracionFireBaseCambioEstado()
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    //Interfaz principal
    var mainInterfaceView: some View{
        
        /* Un tipo que recopila varias instancias de un tipo de contenido, como vistas, escenas o comandos, en una sola unidad. */
        Group{
            
            ZStack(alignment: .topLeading){
                
                MainTabView()
                //Escodemos el menu de forma predeterminada
                    .navigationBarHidden(mostraMenu)
                
                //Mostrar el menu
                if mostraMenu{
                    ZStack{
                        //Mostrar o escoder el menu
                        Color(.black).opacity(mostraMenu ? 0.25 : 0.0)
                        
                    }.onTapGesture {
                        
                        withAnimation(.easeInOut){
                            mostraMenu = false
                        }
                    }
                    .ignoresSafeArea()
                }
                
                //Menu se muestra con una animación hacia el lado derecho
                MenuDeslizanteView()
                    .frame(width: 300)
                    .offset(x: mostraMenu ? 0 : -300, y: 0)
                    .background(mostraMenu ? Color.white : Color.clear)
                
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    
                    //Si el usuario es igual al usuario que ha iniciado sesión
                    if let usuario =  vistaModelo.usuarioActual{
                        Button{
                            withAnimation(.easeInOut){
                                //Mostramos el menu al pulsar
                                mostraMenu.toggle()
                            }
                        }label: {
                            KFImage(URL(string: usuario.UrlImagenPerfil))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle() )
                        }
                    }
                }
            }
            //Cada vez que aparezca esta vista la variable de mostrar el menu será falsa, es decir, que no se verá el menu
            .onAppear{
                mostraMenu = false
            }
        }
    }
}

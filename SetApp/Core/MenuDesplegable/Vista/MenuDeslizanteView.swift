//
//  MenuDeslizanteView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 12/4/22.
//

import SwiftUI
/* Con esta librería utilizamos para el manejo de las imágenes (mostrar las imágenes) */
import Kingfisher

struct MenuDeslizanteView: View {
    
    //Importante llamarlo diferente de vista modelo porque o sino el programa confunde las variables autentificacionVistaModelo
    @EnvironmentObject var autentificacionVistaModelo: AutentificacionModelView
    
    var body: some View {
        
        ZStack {
            
            Color(red: 0.331, green: 0.074, blue: 0.423)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            if let usuario = autentificacionVistaModelo.usuarioActual{
                
                //Vstack 1
                VStack (alignment: .leading, spacing: 32){
                    //Vstack 2
                    VStack(alignment: .leading){
                        
                        //Foto de perfil
                        /*KFImage(URL) realiza el tratamiento de la imagen como url */
                        KFImage(URL(string: usuario.UrlImagenPerfil))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 48, height: 48)
                        
                        //Nombre completo
                        VStack (alignment: .leading, spacing:4){
                            Text(usuario.nombreCompleto).font(.headline)
                                .foregroundColor(.white)
                            //Nombre de usario
                            Text("@\(usuario.nombreUsuario)").font(.caption).foregroundColor(.white)
                        }
                    //END-Vstack 2
                    }
                    .padding(.leading)
                    
                    //ForEach
                    //Recorremos la imagen de perfil del usuario y las opciones de navegación entre vistas
                    ForEach(MenuDeslizanteModeloView.allCases, id: \.rawValue){ vistaModelo  in
                        
                        if vistaModelo == .perfil{
                            /*
                            //Nos dirigimos al perfil
                            NavigationLink{
                                //Mostramos el usuario gracias el usuario que hemos guardado de  le sesión
                               PerfilView(usuario: usuario)
                            }label: {
                               MenuDeslizanteFilaElementoView(vistaModelo: vistaModelo)
                            }
                            */
                        }else if(vistaModelo == .logout){
                            
                            //Cada vez que se cierre sesión se mostrá ese mensaje
                            Button {
                                
                                /*!!!!!!!!*/
                                autentificacionVistaModelo.cerrarSesion()
                                
                            }label: {
                                
                               
                                MenuDeslizanteFilaElementoView(vistaModelo: vistaModelo)
                            }
                            
                        }else{
                            MenuDeslizanteFilaElementoView(vistaModelo: vistaModelo)
                        }
                        
                    //END-ForEach
                    }
                    
                    Spacer()
               //END-Vstack 1
                }
                
            //END-if
            }
        }
      
    }
}

struct MenuDeslizanteView_Previews: PreviewProvider {
    static var previews: some View {
        MenuDeslizanteView()
    }
}

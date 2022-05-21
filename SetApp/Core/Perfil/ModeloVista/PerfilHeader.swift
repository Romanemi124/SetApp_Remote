//
//  PerfilHeader.swift
//  SetApp
//
//  Created by Emilio Roman on 11/5/22.
//

import Kingfisher
import SwiftUI
import SDWebImageSwiftUI

//Cabezera de la vista del perfil donde se muestra su nombre, usuario, y datos principales como el número de publicaciones totales, sus seguidores y seguidos
//Para el buscador
struct PerfilHeader: View {
    
    var usuario: UsuarioFireBase?
    
    //Para mostrar el número de publicaciones que ha subido el usuario
    var postCount: Int
    
    //Recoger los datos de las personas que sigue y sus seguidores
    @Binding var seguidos: Int
    @Binding var seguidores: Int
    
    //Para volver la vista hacia atrás
    @Environment(\.presentationMode) var mode
  
    var body: some View {
        
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
            
            Text("@\(usuario!.nombreUsuario)")
                .font(.headline)
                .bold()
                .foregroundColor(.white)
        }
        .padding(.top, 15)
        
        HStack {
            
            VStack {
                
                if usuario != nil {
                    
                    //WebImage(url: URL(string: usuario!.urlImagenPerfil)!)
                    KFImage(URL(string: usuario!.urlImagenPerfil)!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .trailing)
                        .padding(.leading)
                } else {
                    Color.init(red: 0.9, green: 0.9, blue: 0.9).frame(width: 100, height: 100, alignment: .trailing)
                        .padding(.leading)
                }
                
                Text(usuario!.nombreCompleto)
                    .font(.headline)
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)
            }
            
            VStack {
                
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("\(postCount)").font(.title3)
                            .foregroundColor(.white)
                        Text("Publicaciones")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    //.padding(.top, 30)
                    
                    Spacer()
                    
                    VStack {
                        Text("\(seguidores)").font(.title3)
                            .foregroundColor(.white)
                        Text("Seguidores")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    //.padding(.top, 30)
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("\(seguidos)").font(.title3)
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

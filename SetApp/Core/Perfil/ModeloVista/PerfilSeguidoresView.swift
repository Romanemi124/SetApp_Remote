//
//  PerfilSeguidoresView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/5/22.
//

import SwiftUI

/* Vista para mostrar los seguidores, seguidos y publicaciones del usuario que iniciado sesión */
struct PerfilSeguidoresView: View {
    
    //Para mostrar el número de publicaciones que ha subido el usuario
    var postCount: Int
    
    //Recoger los datos de las personas que sigue y sus seguidores
    @Binding var seguidos: Int
    @Binding var seguidores: Int
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Spacer()
                
                VStack {
                    
                    Text("\(postCount)").font(.title3)
                        .foregroundColor(.white)
                    Text("Posts")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                //.padding(.top, 30)
                
                Spacer()
                
                VStack {
                    Text("\(seguidores)").font(.title3)
                        .foregroundColor(.white)
                    Text("perfil-seguidores")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                //.padding(.top, 30)
                
                Spacer()
                
                VStack {
                    
                    Text("\(seguidos)").font(.title3)
                        .foregroundColor(.white)
                    Text("perfil-seguidos")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                //.padding(.top, 30)
                
                Spacer()
            }
        }
    }
}

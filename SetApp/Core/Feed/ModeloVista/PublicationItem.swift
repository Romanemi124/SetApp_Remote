//
//  PublicationItem.swift
//  SetApp
//
//  Created by Emilio Roman on 18/4/22.
//

import SwiftUI
import Kingfisher

//Esta es la estructura que va a tener la publicación y se cargará en la vista FeedView para ver todas las publicaciones de las personas que sigue
struct PublicationItem: View {
    
    /*
    var namespace: Namespace.ID
    @Binding var show: Bool
    */
    
    let publicacion: Publicacion
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8.0) {
            
            Spacer()
            
            //Parte donde se cargará la foto de perfil del usuario y su nombre de usuario
            if let usuario = publicacion.user {
                
                HStack {
                    
                    //Image("publi")
                    KFImage(URL(string: usuario.UrlImagenPerfil))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .cornerRadius(10)
                        .padding(5)
                        .background(.ultraThinMaterial, in:
                                        RoundedRectangle(cornerRadius: 16, style: .continuous))
                        //.strokeStyle(cornerRadius: 16)
                    
                    Text(usuario.nombreUsuario)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                
            }
            
            //Textos donde cargarán las características de la publicación y la valoración por parte del usuario
            Text(publicacion.nombreProducto)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary,.primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .lineLimit(1)
            
            //Cada uno de los textos tiene un estilo diferente así como el tamaño y color del texto
            Text(publicacion.marca)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            
            Text(publicacion.categoria)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
        }
        .padding(.all, 20.0)
        .padding(.vertical, 5)
        .frame(height: 550.0)
        //Fondo de la publicación con un borde redondeado
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        //.shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
        .padding(.horizontal, 20)
        .overlay(
            //Foto de la publicación
            KFImage(URL(string: publicacion.UrlImagePublicacion))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 350)
                .cornerRadius(20)
                .padding(.bottom, 180)
        )
        .padding(.bottom, 50)
    }
}

/*
struct PublicationItem_Previews: PreviewProvider {
    
    //@Namespace static var namespace
    
    static var previews: some View {
        PublicationItem()
        //PublicationItem(namespace: namespace, show: .constant(true))
    }
}
*/

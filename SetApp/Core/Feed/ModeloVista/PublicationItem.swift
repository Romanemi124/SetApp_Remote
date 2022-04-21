//
//  PublicationItem.swift
//  SetApp
//
//  Created by Emilio Roman on 18/4/22.
//

import SwiftUI

//Esta es la estructura que va a tener la publicación y se cargará en la vista FeedView para ver todas las publicaciones de las personas que sigue
struct PublicationItem: View {
    
    /*
    var namespace: Namespace.ID
    @Binding var show: Bool
    */
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8.0) {
            
            Spacer()
            
            //Parte donde se cargará la foto de perfil del usuario y su nombre de usuario
            HStack {
                
                Image("publi")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26.0, height: 26.0)
                    .cornerRadius(10)
                    .padding(9)
                    .background(.ultraThinMaterial, in:
                                    RoundedRectangle(cornerRadius: 16, style: .continuous))
                    //.strokeStyle(cornerRadius: 16)
                
                Text("Emilio")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            //Textos donde cargarán las características de la publicación y la valoración por parte del usuario
            Text("Monitor LG UltraGear")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary,.primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .lineLimit(1)
            
            //Cada uno de los textos tiene un estilo diferente así como el tamaño y color del texto
            Text("LG".uppercased())
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            
            Text("Escritorio gaming 2022")
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
            Image("publi")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 350)
                //.offset(x: 32, y: -60)
                .padding(.bottom, 180)
                .cornerRadius(20)
        )
        .padding(.bottom, 50)
    }
}

struct PublicationItem_Previews: PreviewProvider {
    
    //@Namespace static var namespace
    
    static var previews: some View {
        PublicationItem()
        //PublicationItem(namespace: namespace, show: .constant(true))
    }
}

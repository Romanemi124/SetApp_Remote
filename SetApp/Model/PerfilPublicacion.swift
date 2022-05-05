//
//  PerfilPublicacion.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import SwiftUI
import Kingfisher
/*
struct PerfilPublicacion: View {
    
    let publicacion: Publicacion
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Spacer()
            
            //Parte donde se cargarán las publicaciones que ha realizado el usuario
            HStack {
                
                //Image("publi")
                KFImage(URL(string: publicacion.UrlImagePublicacion))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 10)
                
                //Textos donde cargarán las características de la publicación y la valoración por parte del usuario
                VStack(alignment: .leading, spacing: 8.0) {
                    
                    Text(publicacion.nombreProducto)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    //Cada uno de los textos tiene un estilo diferente así como el tamaño y color del texto
                    Text(publicacion.marca)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(publicacion.categoria)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 20)
                .padding(.leading, 20)
            }
        }
        .frame(width: 350, height: 120)
        .cornerRadius(0)
        .padding(.all, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 0.331, green: 0.074, blue: 0.423), lineWidth: 3))
    }
}

/*
struct PerfilPublicacion_Previews: PreviewProvider {
    static var previews: some View {
        PerfilPublicacion()
    }
}
*/
 */

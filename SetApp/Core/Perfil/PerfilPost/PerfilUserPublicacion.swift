//
//  PerfilUserPublicacion.swift
//  SetApp
//
//  Created by Emilio Roman on 23/5/22.
//

import SwiftUI
import Kingfisher

struct PerfilUserPublicacion: View {
    
    var post: Post
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            //Cargamos la foto de la publicación
            KFImage(URL(string: post.mediaUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(post.nombreProducto)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Label {
                    Text("\(post.categoria.uppercased())" + " / " + "\(post.marca.uppercased())")
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "gamecontroller.fill")
                        .foregroundColor(.white)
                }
                
                PostCardLikes(post: post)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

/*
struct PerfilUserPublicacion_Previews: PreviewProvider {
    static var previews: some View {
        PerfilUserPublicacion()
    }
}
 */

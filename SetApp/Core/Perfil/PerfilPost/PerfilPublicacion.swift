//
//  PerfilPublicacion.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import SwiftUI
import Kingfisher

struct PerfilPublicacion: View {
    
    var post: Post
    
    var body: some View {
        
        HStack(spacing: 12) {
            
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
                    Text(post.categoria)
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "gamecontroller.fill")
                        .foregroundColor(.white)
                }
                
                PostCardLikes(post: post)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            /*
            Button {
                
            } label: {
                
                Image(systemName: "suit.heart")
                    .font(.title3)
                    .foregroundColor(.white)
            }
             */
            
            NavigationLink{
                //Mostramos el usuario gracias el usuario que hemos guardado de la sesión
                CourseView(post: post)
                    .navigationBarHidden(true)
            }label: {
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            /*
            Button {
                
            } label: {
                
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .foregroundColor(.white)
            }*/
        }
    }
}

/*
struct PerfilPublicacion_Previews: PreviewProvider {
    static var previews: some View {
        PerfilPublicacion()
    }
}
*/

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
    /*
    @ObservedObject var viewModel: ServicioPostCard
    
    init(post: Post) {
        self.viewModel = ServicioPostCard(post: post)
    }
     */
    
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
                /*
                Button(action: {
                    viewModel.post.didLike ?? false ?
                    viewModel.unlikePost() :
                    viewModel.likePost()
                }) {
                    
                    Image(systemName: viewModel.post.didLike ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .font(.title3)
                        .foregroundColor(viewModel.post.didLike ?? false ? .red : .gray)
                }
                 */
                PostCardLikes(post: post)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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

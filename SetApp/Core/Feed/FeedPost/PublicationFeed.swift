//
//  PublicacionItem.swift
//  SetApp
//
//  Created by Emilio Roman on 6/5/22.
//

import Foundation
import SwiftUI
import Kingfisher

//Esta estructura se usa en la vista principal para poder ver la foto de la publicación con el nombre de usuario y nombre del producto
struct PostItem: View {
    
    let post: PostCateg
    //var animation: Namespace.ID
    
    var body: some View {
        
        VStack {
            
            KFImage(URL(string: post.mediaUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                //Para la animación
                //.matchedGeometryEffect(id: post.contentImage, in: animation)
                .frame(width: UIScreen.main.bounds.width - 30, height: 300)
            
            HStack {
                
                Image("publi")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(post.nombreProducto)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(post.categoria)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                
                Spacer(minLength: 0)
                
                VStack {
                    /*
                    Button(action: {}) {
                        
                        Text("Get")
                            .padding(.vertical, 10)
                            .padding(.horizontal, 25)
                            .background(Color.primary.opacity(0.1))
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                    }
                     */
                    
                    Text("Ver más")
                        .font(.caption)
                        .foregroundColor(.white)
                } 
            }
            //.matchedGeometryEffect(id: post.id, in: animation)
            .padding()
            .background(Color.gray.opacity(0.5))
        }
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.top)
    }
}

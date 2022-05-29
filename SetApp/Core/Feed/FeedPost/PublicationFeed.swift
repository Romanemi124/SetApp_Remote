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
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            ZStack(alignment: .topLeading) {
                
                /*El Geometry Reader se usa para ajustar la imagen según el tamaño del móvil*/
                GeometryReader { proxy in
                    
                    let size = proxy.size
                    
                    /*Se ajusta el tamaño de la imagen*/
                    KFImage(URL(string: post.mediaUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 15))
                }
                .frame(height: 400)
            }
            
            HStack(spacing: 12) {
                
                /*Se ponen las características principales de cada publicación*/
                KFImage(URL(string: post.profile))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("\(post.categoria.uppercased())" + " / " + "\(post.marca.uppercased())")
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Text(post.nombreProducto.uppercased())
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("@" + "\(post.username)")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding([.horizontal, .bottom])
        }
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(red: 0.113, green: 0.031, blue: 0.16))
        }
        .padding(.bottom, 20)
    }
}

//Para dar la forma a la imagen principal de la publicación
struct CustomCorner: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
    
}

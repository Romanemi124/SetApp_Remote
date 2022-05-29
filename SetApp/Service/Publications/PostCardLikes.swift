//
//  PostCard.swift
//  SetApp
//
//  Created by Emilio Roman on 12/5/22.
//

import SwiftUI

//Para la animación de like de cada poblicacion
struct PostCardLikes: View {
    
    @ObservedObject var servicioPost = ServicioPostCard()
    
    /*Una vez se llama a esta parte de la publicación, llama al método de los likes para subir o restar el contador de los likes*/
    init(post: Post) {
        self.servicioPost.post = post
        self.servicioPost.hasLikedPost()
    }
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    
                    if(self.servicioPost.isLiked) {
                        self.servicioPost.unLike()
                    } else {
                        self.servicioPost.like()
                    }
                })
            }) {
                /*En caso de dar like se muestra el corazón relleno o vacío cuando se lo quita*/
                Image(systemName: (self.servicioPost.isLiked) ? "heart.fill": "heart")
                    .foregroundColor((self.servicioPost.isLiked) ? Color(red: 0.721, green: 0.491, blue: 0.849) : .white)
            }
            
            if(self.servicioPost.post.likeCount > 0) {
                Text("\(self.servicioPost.post.likeCount) likes")
                    .foregroundColor(.white)
            }
        }
    }
}

/*
struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        PostCard()
    }
}
*/

//
//  ServicioPostCard.swift
//  SetApp
//
//  Created by Emilio Roman on 11/5/22.
//

import Foundation
import Firebase
import SwiftUI

/*Servicio para guardar el recuento de los likes*/
class ServicioPostCard: ObservableObject { 
    
    @Published var post: Post!
    @Published var isLiked = false
    
    /*Se revisa que el usuario ya haya dado like a la publicación*/
    func hasLikedPost() {
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true: false
    }
    
    /*El caso de dar like se guarda en el campo de la tabla la suma de todos los likes que tenga la publicación*/
    func like() {
        post.likeCount += 1
        isLiked = true
        
        /*Se suman sólo a las publicaciones de los usuarios que tengan ese id y el id de la publicación*/
        ServicioPost.PostUserId(userId: post.OwnerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        ServicioPost.AllPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
    
    /*En caso de quitar el like de la publicación*/
    func unLike() {
        post.likeCount -= 1
        isLiked = false
        
        ServicioPost.PostUserId(userId: post.OwnerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        ServicioPost.AllPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
    }
}

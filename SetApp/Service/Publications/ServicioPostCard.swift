//
//  ServicioPostCard.swift
//  SetApp
//
//  Created by Emilio Roman on 11/5/22.
//

import Foundation
import Firebase
import SwiftUI

//Para la suma de los likes

class ServicioPostCard: ObservableObject {
    
    @Published var post: Post!
    @Published var isLiked = false
    
    func hasLikedPost() {
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true: false
    }
    
    func like() {
        post.likeCount += 1
        isLiked = true
        
        ServicioPost.PostUserId(userId: post.OwnerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        ServicioPost.AllPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        ServicioPost.timelineUserId(userId: post.OwnerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
    
    func unLike() {
        post.likeCount -= 1
        isLiked = false
        
        ServicioPost.PostUserId(userId: post.OwnerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        ServicioPost.AllPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        ServicioPost.timelineUserId(userId: post.OwnerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
    }
}

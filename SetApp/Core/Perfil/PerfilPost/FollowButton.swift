//
//  FollowButton.swift
//  SetApp
//
//  Created by Emilio Roman on 15/5/22.
//

import SwiftUI

struct FollowButton: View {
    
    @ObservedObject var followService = FollowService()
    
    var user: UsuarioFireBase
    
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    @Binding var followCheck: Bool
    
    init (user: UsuarioFireBase, followCheck: Binding<Bool>, followingCount: Binding<Int>, followersCount: Binding<Int>) {
        
        self.user = user
        self._followCheck = followCheck
        self._followingCount = followingCount
        self._followersCount = followersCount
    }
    
    func follow() {
        if !self.followCheck {
            followService.follow(userId: user.id!, followingCount: { (followingCount) in
                self.followingCount = followingCount
            }) { (followersCount) in
                self.followersCount = followersCount
            }
            
            self.followCheck = true
        } else {
            
            followService.unfollow(userId: user.id!, followingCount: { (followingCount) in
                self.followingCount = followingCount
            }) { (followersCount) in
                self.followersCount = followersCount
            }
            
            self.followCheck = false
        }
    }
    
    var body: some View {
        
        Button(action: follow) {
            Text((self.followCheck) ? "Unfollow": "Follow")
        }
        .padding()
        //Recuadro que enmarca el texto
        .background(
            RoundedRectangle(cornerRadius: 10)
            //Quitar el fondo del rectángulo con la opacidad del color
                .stroke(.white, lineWidth: 2)
        )
        //Separación de los laterales de la vista
        .cornerRadius(10)
        .padding(35)
        //Para que sólo se mueva uno
        .frame(height: 70)
    }
}

/*
struct FollowButton_Previews: PreviewProvider {
    static var previews: some View {
        FollowButton()
    }
}
 */

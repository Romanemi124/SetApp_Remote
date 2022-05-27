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
    @State private var followCheck: Bool
    
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    //@Binding var followCheck: Bool
    
    init (user: UsuarioFireBase, followCheck: Bool, followingCount: Binding<Int>, followersCount: Binding<Int>) {
        
        self.user = user
        self.followCheck = followCheck
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
    
    //Esta función comprueba que la persona está siguiendo a la persona o no
    func followPrueba(userid: String) {
        
        print("En la vista el valor recibido es = \(followCheck)")
        
        PerfilViewModel.followingId(userId: userid).getDocument { (document, error) in
            
            if let doc = document, doc.exists {
                self.followCheck = false
                print("Valor del followCheck si existe en switch = \(followCheck)")
                
                //Como el usuario existe se da unfollow
                followService.unfollow(userId: user.id!, followingCount: { (followingCount) in
                    self.followingCount = followingCount
                }) { (followersCount) in
                    self.followersCount = followersCount
                }
            } else {
                self.followCheck = true
                print("Valor del followCheck si no existe en switch = \(followCheck)")
                
                //Como el usuario no existe se da unfollow
                followService.follow(userId: user.id!, followingCount: { (followingCount) in
                    self.followingCount = followingCount
                }) { (followersCount) in
                    self.followersCount = followersCount
                }
            }
        }
        
        print("Followers totales = \(followersCount)")
    }
    
    func prueba() {
        followPrueba(userid: user.id!)
    }
    
    var body: some View {
        
        Button(action: prueba) {
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

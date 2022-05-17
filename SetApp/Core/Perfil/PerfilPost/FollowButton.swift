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

/*
struct FollowButton_Previews: PreviewProvider {
    static var previews: some View {
        FollowButton()
    }
}
 */


/*
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
 
 func follow() {
     
     //Verificamos que el usuario principal sigue al usuario buscado
     FollowService.buscarSeguimientoUser(withIdUsuario: user.id!){ (restult) in
         
         // Mostramos los resultados de la busqueda
         switch restult {
             
             //En caso de error o que no haya encontrado
         case .failure(let error):
             
             print("error a la hora de buscar")
             //En caso de que se no lo haya encontrado
         case .success(true):
             
             self.followCheck = true
             print("Valor del followCheck en switch true = \(followCheck)")
             
             followService.unfollow(userId: user.id!, followingCount: { (followingCount) in
                 self.followingCount = followingCount
             }) { (followersCount) in
                 self.followersCount = followersCount
             }
             //En caso de que lo haya encontrado
         case .success(false):
             self.followCheck = false
             print("Valor del followCheck en switch false = \(followCheck)")
             
             followService.follow(userId: user.id!, followingCount: { (followingCount) in
                 self.followingCount = followingCount
             }) { (followersCount) in
                 self.followersCount = followersCount
             }
         }
     }
 */

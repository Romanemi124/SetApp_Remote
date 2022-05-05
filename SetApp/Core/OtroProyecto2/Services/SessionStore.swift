//
//  SessionStore.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

/* Clase para observar los cambios de autentificación del usuario */
class SessionStore: ObservableObject{
    
    /* Se obtinee los eventos que ocurre */
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: UserModel?{didSet{self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    //Llevar los cambios que suceden con el usuario
    func listen(){
        
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            if let user = user {
                
                let fireStoreUserId = AuthService.getUserId(userId: user.uid)
    
                fireStoreUserId.getDocument{ (document, error) in

                    if let dict =  document?.data(){
                        
                        guard let docodeUser = try? UserModel.init(fromDictionary: dict) else {return}
                        self.session = docodeUser
                        
                    }
                    
                }

            // if let user
            }else{
                self.session = nil
            }
        })
        
        //func
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
        }catch{
            
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit{
        unbind()
    }
}


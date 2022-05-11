//
//  FeedView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    
    //Clase será la pantalla principal de la app
    var body: some View {
        //12:55
        ZStack {
            
            FondoPantallasApp()
            
            ContentFeedView()
            
            VStack{
                
                Text("Holaa")
                
                Button{
                    
                    Autentificacion.cerrarSesion{ result in
                        
                        print("cerrando sesión")
                        
                    }
                    
                }label: {
                    Text("Cerrar seión")
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

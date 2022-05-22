//
//  MessagesView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import SwiftUI

struct ChatView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
        
            //Mostramos la vista deseada
            Text("Chat")
            
        }
            
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

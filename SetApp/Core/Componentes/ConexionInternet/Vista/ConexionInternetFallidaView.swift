//
//  ConexionInternetFallidaView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/5/22.
//

import SwiftUI
/* Esta clase solo se mostrará cuando la conexión a internet falle */
struct ConexionInternetFallidaView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        ZStack {
            
            Color(.systemBlue).ignoresSafeArea()
            
            VStack {
                Image(systemName: networkManager.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)
                
                Text("conexion-internet-fallida")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
    
}
/*
 
 //Verficamos que esté conectado a Internet
 if !networkManager.isConnected {
     
     //Mostramos la vista de fallo de conexión a Internet
     ConexionInternetFallidaView(networkManager: networkManager)
     
 }else{
 
     //Mostramos la vista deseada
     
     
 }
 
 */

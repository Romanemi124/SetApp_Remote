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
            
            Color(red: 0.331, green: 0.074, blue: 0.423).ignoresSafeArea()
            
            VStack {
                
                Image("logoWifi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)
                
                Text("Ups!")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("conexion-internet-fallida")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
    
}

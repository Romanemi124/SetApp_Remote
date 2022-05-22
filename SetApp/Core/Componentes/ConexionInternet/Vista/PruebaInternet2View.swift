//
//  PruebaInternet2View.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/5/22.
//

import SwiftUI

struct PruebaInternet2View: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        VStack{
            
            if networkManager.isConnected {
                
                Text("Esta conextado muestra algo")
                
            }else{
                
                ConexionInternetFallidaView(networkManager: networkManager)
                
//                ZStack {
//
//                    Color(.systemBlue).ignoresSafeArea()
//
//                    VStack {
//                        Image(systemName: "wifi.slash")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 200, height: 200)
//                            .foregroundColor(.white)
//
//                        Text(networkManager.connectionDescription)
//                            .font(.system(size: 18, weight: .semibold))
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
//                            .padding()
//
//                        Button {
//                            print("Handle action..")
//                        } label: {
//                            Text("Retry")
//                                .padding()
//                                .font(.headline)
//                                .foregroundColor(Color(.systemBlue))
//                        }
//                        .frame(width: 140)
//                        .background(Color.white)
//                        .clipShape(Capsule())
//                        .padding()
//                    }
//                }
            }
        }
        
    }
}

struct PruebaInternet2View_Previews: PreviewProvider {
    static var previews: some View {
        PruebaInternet2View()
    }
}

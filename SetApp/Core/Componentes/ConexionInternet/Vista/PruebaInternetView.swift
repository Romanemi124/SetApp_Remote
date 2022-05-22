//
//  PruebaInternetView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/5/22.
//

import SwiftUI

struct PruebaInternetView: View {
    
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
                
                Text(networkManager.connectionDescription)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                if networkManager.isConnected {
                    Button {
                        print("Handle action..")
                    } label: {
                        Text("Retry")
                            .padding()
                            .font(.headline)
                            .foregroundColor(Color(.systemBlue))
                    }
                    .frame(width: 140)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding()
                }
            }
        }
    }
}

struct PruebaInternetView_Previews: PreviewProvider {
    static var previews: some View {
        PruebaInternetView()
    }
}

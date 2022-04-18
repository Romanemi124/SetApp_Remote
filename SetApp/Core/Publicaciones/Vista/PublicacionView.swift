//
//  PublicacionView.swift
//  SetApp
//
//  Created by Emilio Roman on 14/4/22.
//

import SwiftUI

struct PublicacionView: View {
    
    var body: some View {
        
        ZStack {
            
            GeometryReader {proxy in
                
                let fotoFondo = proxy.size
                
                Image("publi")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: fotoFondo.width, height: fotoFondo.height, alignment: .center)
                    .cornerRadius(0)
            }
            .ignoresSafeArea()
            .overlay(.ultraThinMaterial)
            
            VStack {
                
                Text("Publicar")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    ZStack {
                        
                        Image("publi")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height / 1.8)
                            .cornerRadius(12)
                    }
                    
                    HStack {
                        
                        Button(action: {}, label: {
                            Text("Cámara")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.331, green: 0.074, blue: 0.423))
                                .cornerRadius(12)
                        })
                        
                        Button(action: {}, label: {
                            Text("Galería")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.331, green: 0.074, blue: 0.423))
                                .cornerRadius(12)
                        })
                    }
                    .padding(.top, 350)
                    
                    
                    //Este link se muestra en el momento en el que ya se ha seleccionado una foto para publicar
                    HStack{
                        
                        Spacer()
                        
                        NavigationLink{
                            
                            EditPubliView().navigationBarHidden(true)
                        }label: {
                            
                            Text("Continuar")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                            
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 25, height: 20)
                                .foregroundColor(.white)
                                .padding(10)
                        }
                    }
                    .padding(.top, 420)
                }

            }
            .padding(30)
            .padding(.top, 70)
        }
    }
}

struct PublicacionView_Previews: PreviewProvider {
    static var previews: some View {
        PublicacionView()
    }
}

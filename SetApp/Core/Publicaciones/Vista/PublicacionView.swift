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
            
            //GeometryReader es un contenedor de vistas que permite acceder a su tamaño y posición
            GeometryReader {proxy in
                
                //Para poder establecer un tamaño idóneo a la foto de fondo
                let fotoFondo = proxy.size
                
                //Foto de fondo con un fondo distorsionado, en este caso, se cargará de fondo la imagen que se ha seleccionado para publicar
                Image("publi")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: fotoFondo.width, height: fotoFondo.height, alignment: .center)
                    .cornerRadius(0)
            }
            .ignoresSafeArea()
            .overlay(.ultraThinMaterial)
            
            //Parte donde se encontrará la foto que se publicar y los botones para poder seleccionar galería o cámara
            VStack {
                
                Text("Publicar")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                //Para poder establecer un tamaño idóneo a la foto que se va publicar en la vista
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    ZStack {
                        
                        //Foto donde se cargará la imagen seleccionada para publicar en su perfil
                        Image("publi")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height / 1.8)
                            .cornerRadius(12)
                    }
                    
                    //Parte horizontal donde se encuentran los dos botones principales de la vista
                    HStack {
                        
                        //En este caso se va a redirigir a la cámara para poder tomar una foto y publicarla
                        Button(action: {}, label: {
                            Text("Cámara")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.331, green: 0.074, blue: 0.423))
                                .cornerRadius(12)
                        })
                        
                        //En este caso accederá a la galería una vez dados los permisos, y se cargará en la foto de prueba
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
                        
                        //Sólo se activará en el caso de que el usuario haya cargado una foto ya sea desde la galería o cámara
                        NavigationLink{
                            
                            //Redirigirá a la vista donde se pondrán todas las características del componente
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

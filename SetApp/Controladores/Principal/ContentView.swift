//
//  ContentView.swift
//  SetApp
//
//  Created by Emilio Roman on 3/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            
            //Diseño de la vista principal de la app
            ZStack {
                
                //Imagen de fondo de la vista
                EstablecerFondoPrincipal()
                
                VStack {
                    
                    Text("Bienvenido")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(x: 35)
                    
                    Image("SetApp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200, alignment: .leading)
                    
                    Spacer(minLength: 180)
                    
                    Text("SetApp")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(10)
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: LoginView().navigationBarHidden(true),
                        label: {
                            PrimaryButton(title: "Iniciar Sesión")
                    })
                    .navigationBarHidden(true)
                    PrimaryButton(title: "Iniciar con Google")
                        .padding()
                    NavigationLink(
                        destination: RegistroView().navigationBarHidden(true),
                        label: {
                            PrimaryButton(title: "Registrarse")
                    })
                    .navigationBarHidden(true)
                    
                    Spacer()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Estilos del botón morado
struct PrimaryButton: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: 280)
            .padding(10)
            .background(Color(red: 0.331, green: 0.074, blue: 0.423))
            .cornerRadius(50)
    }
}

struct EstablecerFondoPrincipal: View {
    var body: some View {
        Image("fondo")
            .resizable()
        // Para ocupar toda la pantalla
            .ignoresSafeArea()
    }
}

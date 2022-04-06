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
                
                //Se usa el VStack, no cambiar a ZStack
                VStack {
                    
                    //Cabezera de la parte principal de la app
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
                    //Los spacer le añaden separación entre elementos
                    Spacer(minLength: 180)
                    //Título de la app
                    Text("SetApp")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(10)
                    Spacer()
                    
                    /*------------------------------------*/
                    //FALTA iniciar sesión con Google
                    
                    //Los botones tienen un link que los redirige a otra de las vistas de la app
                    NavigationLink(
                        //Dirección a la que redirige al pulsar el botón
                        destination: LoginView().navigationBarHidden(true), label: {
                            //Título del botón
                            PrimaryButton(title: "Iniciar Sesión")
                    })
                    //Se hace desaparecer el icono de navegación a la izq de la pantalla
                    .navigationBarHidden(true)
                    //Botón para iniciar sesión con Google (Configurar)
                    PrimaryButton(title: "Iniciar con Google")
                        .padding()
                    //Botón para el registro de un nuevo usuario
                    NavigationLink(
                        destination: RegistroView().navigationBarHidden(true), label: {
                            PrimaryButton(title: "Registrarse")
                    })
                    .navigationBarHidden(true)
                    Spacer()
                }
            }
        }
    }
}

//Se usa en todas las vistas principales del acceso del usuario para poner de fondo
struct EstablecerFondoPrincipal: View {
    var body: some View {
        Image("fondo")
            .resizable()
        // Para ocupar toda la pantalla
            .ignoresSafeArea()
    }
}

// Estilos del botón morado para iniciar sesión o registrarse
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

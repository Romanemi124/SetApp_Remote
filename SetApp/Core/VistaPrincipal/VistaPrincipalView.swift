//
//  VistaPrincipalView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 9/4/22.
//

import SwiftUI

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

//Fondo de los círculos donde
struct FondoPantallasApp: View {
    
    var body: some View {
        
        LinearGradient(colors: [Color(red: 0.113, green: 0.031, blue: 0.16), Color(red: 0.331, green: 0.074, blue: 0.423)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
        GeometryReader { proxy in
            
            let size = proxy.size
            
            Color.black
                .opacity(0.7)
                .blur(radius: 200)
                .ignoresSafeArea()
            
            //Color oscuro
            Circle()
                .fill(Color(red: 0.331, green: 0.074, blue: 0.423))
                .padding(50)
                .blur(radius: 120)
                .offset(x: -size.width / 1.8, y: -size.height / 5)
            Circle()
                .fill(Color(red: 0.331, green: 0.074, blue: 0.423))
                .padding(100)
                .blur(radius: 110)
                .offset(x: -size.width / 1.8, y: size.height / 2)
            
            //Color claro
            Circle()
                .fill(Color(red: 0.721, green: 0.491, blue: 0.849))
                .padding(50)
                .blur(radius: 150)
                .offset(x: size.width / 1.8, y: -size.height / 2)
            Circle()
                .fill(Color(red: 0.721, green: 0.491, blue: 0.849))
                .padding(100)
                .blur(radius: 110)
                .offset(x: size.width / 1.8, y: size.height / 2)
        }
    }
}

//Fondo de los círculos donde
struct FondoPantallaClaroApp: View {
    
    var body: some View {
        
        LinearGradient(colors: [Color(.white), Color(.white)], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        
        GeometryReader { proxy in
            
            let size = proxy.size
            
            /*
            Color.white
                .opacity(0.8)
                .blur(radius: 200)
                .ignoresSafeArea()
            */
            
            //Color oscuro
            Circle()
                .fill(Color(red: 0.721, green: 0.491, blue: 0.849))
                .padding(50)
                .blur(radius: 120)
                .offset(x: -size.width / 1.8, y: -size.height / 5)
            Circle()
                .fill(Color(red: 0.721, green: 0.491, blue: 0.849))
                .padding(100)
                .blur(radius: 110)
                .offset(x: -size.width / 1.8, y: size.height / 2)
            
            //Color claro
            Circle()
                .fill(Color(red: 0.721, green: 0.491, blue: 0.849))
                .padding(50)
                .blur(radius: 150)
                .offset(x: size.width / 1.8, y: -size.height / 2)
            Circle()
                .fill(Color(red: 0.721, green: 0.491, blue: 0.849))
                .padding(100)
                .blur(radius: 110)
                .offset(x: size.width / 1.8, y: size.height / 2)
        }
    }
}




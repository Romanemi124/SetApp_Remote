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



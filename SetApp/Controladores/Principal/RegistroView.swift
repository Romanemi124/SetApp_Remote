//
//  RegistroView.swift
//  SetApp
//
//  Created by Emilio Roman on 3/4/22.
//

import SwiftUI

struct RegistroView: View {
    
    @State private var nombreTxt: String = ""
    @State private var telefonoTxt: String = ""
    @State private var sexoTxt: String = ""
    @State private var nacimientoTxt: String = ""
    @State private var correoTxt: String = ""
    @State private var contrasenaTxt: String = ""
    
    var body: some View {
        
        //Diseño de la vista principal de la app
        ZStack {
            
            //Imagen de fondo de la vista
            EstablecerFondoPrincipal()
            
            VStack {
                
                Text("SetApp")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 35)
                
                Text("Únete ahora")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 45)
                
                TextoDatos(placeholder: "Nombre", text: self.$nombreTxt)
                TextoDatos(placeholder: "Teléfono", text: self.$telefonoTxt)
                TextoDatos(placeholder: "Sexo", text: self.$sexoTxt)
                TextoDatos(placeholder: "Fecha nacimiento", text: self.$nacimientoTxt)
                TextoDatos(placeholder: "Correo electrónico", text: self.$correoTxt)
                TextoDatos(placeholder: "Contraseña", text: self.$contrasenaTxt)
                
                PrimaryButton(title: "Iniciar Sesión")
            }
        }
    }
}

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView()
    }
}

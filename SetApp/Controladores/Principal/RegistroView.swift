//
//  RegistroView.swift
//  SetApp
//
//  Created by Emilio Roman on 3/4/22.
//

import SwiftUI

struct RegistroView: View {
    
    @State var nombreTxt = ""
    @State var telefonoTxt = ""
    @State var sexoTxt = ""
    @State var nacimientoTxt = ""
    @State var correoTxt = ""
    @State var contrasenaTxt = ""
    
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
                
                CamposText(titulo : "Nombre", texto : nombreTxt)
                CamposText(titulo : "Teléfono", texto : telefonoTxt)
                CamposText(titulo : "Sexo", texto : sexoTxt)
                CamposText(titulo : "Fecha nacimiento", texto : nacimientoTxt)
                CamposText(titulo : "Correo electrónico", texto : correoTxt)
                CamposText(titulo : "Contraseña", texto : contrasenaTxt)
                
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

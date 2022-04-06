//
//  NuevaPassView.swift
//  SetApp
//
//  Created by Emilio Roman on 6/4/22.
//

import SwiftUI

struct NuevaPassView: View {
    
    @State private var nuevaPassTxt: String = ""
    @State private var repePassTxt: String = ""
    
    var body: some View {
        
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
                
                Text("Ingresa tu nueva contraseña")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 45)
                
                Spacer(minLength: 220)
                
                /*------------------------------------*/
                //FALTA revisar colores con el custom
                
                //TextField donde se introducen los datos y el campo que voy a pasar
                TextoDatos(placeholder: "Nueva contraseña", text: self.$nuevaPassTxt)
                TextoDatos(placeholder: "Repetir contraseña", text: self.$repePassTxt)
                       
                Spacer(minLength: 220)
                
                /*------------------------------------*/
                
                PrimaryButton(title: "Guardar contraseña")
                
                Spacer()
            }
        }
    }
}

struct NuevaPassView_Previews: PreviewProvider {
    static var previews: some View {
        NuevaPassView()
    }
}

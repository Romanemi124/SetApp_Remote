//
//  CamposEntrada.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 10/4/22.
//

import SwiftUI

struct CamposEntrada: View {
    
    //Los datos rellenados
    let placeholder: String
    //Para evaluar si el campo elegido 
    var isSecureField: Bool? = false
    //Nombre del dato que queremos que rellene
    @Binding var text: String
    
    var body: some View{
        
        //Dentro irán todos los elementos de la parte del login
        //Todo se coloca a la derecha de la pantalla
        ZStack (alignment: .leading) {
            
            Text(placeholder)
                .foregroundColor(.white)
                .offset(y: text.isEmpty ? 0 : -25)
                .scaleEffect(text.isEmpty ? 1 : 0.9, anchor: .leading)
                
            //Nos mostrará diferentes campos de entrada de texto dependiendo del campo
            TextField("", text: $text)
                .foregroundColor(.white)
            
        }
        .padding(.top, self.text.isEmpty ? 0 : 18)
        //Hace el efecto más suave
        //Encontrar algo más actual por versión de iOS
        .padding()
        //Recuadro que enmarca el texto
        .background(
            RoundedRectangle(cornerRadius: 10)
                //Quitar el fondo del rectángulo con la opacidad del color
                .stroke(text.isEmpty ? .white : .white, lineWidth: 2)
        )
        //Separación de los laterales de la vista
        .cornerRadius(10)
        .padding(35)
        //Para que sólo se mueva uno
        .frame(height: 70)
    
    }
}

struct CamposEntrada_Previews: PreviewProvider {
    static var previews: some View {
        CamposEntrada(placeholder: "Email",isSecureField: false, text: .constant(""))
    }
}

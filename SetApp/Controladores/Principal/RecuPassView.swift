//
//  RecuPassView.swift
//  SetApp
//
//  Created by Emilio Roman on 6/4/22.
//

import SwiftUI

struct RecuPassView: View {
    
    @State var emailAuxTxt = ""
    
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
                
                Text("¿Has olvidado tu contraseña?")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 45)
                
                Spacer(minLength: 250)
                
                //TextField donde se introducen los datos, y el campo que voy a pasar
                TextoDatos(placeholder: "Email de recuperación", text: self.$emailAuxTxt)
                       
                Spacer(minLength: 280)
                
                PrimaryButton(title: "Recuperar contraseña")
                
                Spacer()
            }
        }
    }
}

struct RecuPassView_Previews: PreviewProvider {
    static var previews: some View {
        RecuPassView()
    }
}

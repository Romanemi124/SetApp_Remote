//
//  LoginView.swift
//  SetApp
//
//  Created by Emilio Roman on 3/4/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var emailTxt: String = ""
    @State private var passwordTxt: String = ""
    
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
                
                Text("¡Bienvenido de nuevo!")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 45)
                
                Spacer(minLength: 220)
                
                /*------------------------------------*/
                
                //TextField donde se introducen los datos y el campo que voy a pasar
                TextoDatos(placeholder: "Email", text: self.$emailTxt)
                TextoDatos(placeholder: "Contraseña", text: self.$passwordTxt)
                       
                Spacer(minLength: 220)
                
                /*------------------------------------*/
                
                PrimaryButton(title: "Iniciar Sesión")
                
                Spacer()
            }
        }
    }
}

//Estructura de los TextField donde se insertan los datos
struct TextoDatos: View {
    
    //Los datos rellenados
    let placeholder: String
    //Nombre del dato que queremos que rellene
    @Binding var text: String
    
    var body: some View {
        
        //Dentro irán todos los elementos de la parte del login
        //Todo se coloca a la derecha de la pantalla
        ZStack (alignment: .leading) {
            
            Text(placeholder)
                .foregroundColor(.white)
                .offset(y: self.text.isEmpty ? 0 : -25)
                .scaleEffect(self.text.isEmpty ? 1 : 0.9, anchor: .leading)
                //.font(.system(self.text.isEmpty ? .title3 : .title3, design: .rounded))
            
            TextField("", text: self.$text)
                .foregroundColor(.white)
        }
        .padding(.top, self.text.isEmpty ? 0 : 18)
        //Hace el efecto más suave
        //Encontrar algo más actual por versión de iOS
        .animation(.default)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

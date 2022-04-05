//
//  LoginView.swift
//  SetApp
//
//  Created by Emilio Roman on 3/4/22.
//

import SwiftUI

struct LoginView: View {
    
    @State var emailTxt = ""
    @State var passwordTxt = ""
    
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
                
                Text("¡Bienvenido de nuevo!")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(x: 45)
                
                Spacer(minLength: 200)
                
                //TextField donde se introducen los datos, y el campo que voy a pasar
                CamposText(titulo : "Email", texto : emailTxt)
                CamposText(titulo : "Contraseña", texto : passwordTxt)
                       
                Spacer(minLength: 300)
                
                PrimaryButton(title: "Iniciar Sesión")
                
                Spacer()
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


//Estilo de las celdas donde se introducen los campos a rellenar
struct CamposText: View {
    
    var titulo = ""
    @State var texto = ""
    
    //Para el estilo del botón pulsado
    @State var isTapped = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            
            TextField("", text: $texto) { (status) in
                //Para saber cuando está pulsado
                if status{
                    withAnimation(.easeIn){
                        isTapped = true
                    }
                }
            } onCommit: {
                //Cuando el botón deja de ser presionado
                if texto == ""{
                    withAnimation(.easeOut){
                        isTapped = false
                    }
                }
            }
            .padding(.top, isTapped ? 15 : 0)
            .background(
                Text(titulo)
                    .scaleEffect(isTapped ? 0.8 : 1)
                    .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                    .foregroundColor(Color(red: 0.697, green: 0.468, blue: 0.825))
                
                , alignment: .leading
            )
            //Para el color de texto de lo que ponga el usuario
            .foregroundColor(.white)
            
            //Línea debajo del TextField
            Rectangle()
                .fill(isTapped ? Color.accentColor : Color(red: 0.697, green: 0.468, blue: 0.825))
                .opacity(isTapped ? 1 : 0.5)
                .frame(height: 2)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 50)
        .cornerRadius(5)
    }
}

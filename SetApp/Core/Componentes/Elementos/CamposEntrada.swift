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
            
            //LocalizedStringKey identificar la palabra clave para las traducciones
            Text(LocalizedStringKey(placeholder))
                .foregroundColor(.white)
                .offset(y: text.isEmpty ? 0 : -25)
                .scaleEffect(text.isEmpty ? 1 : 0.9, anchor: .leading)
            
            //Nos mostrará diferentes campos de entrada de texto dependiendo del campo
            if isSecureField ?? false{
                
                //Contraseña
                SecureField(LocalizedStringKey(placeholder), text: $text)
                    .foregroundColor(.white).keyboardType(.default)
                
            }else{
                
                //Email
                TextField(LocalizedStringKey(placeholder), text: $text)
                    .foregroundColor(.white)
                
            }
            
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

/* Solo mostrar no modificar datos en le campo */
struct CamposEntradaMostrar: View {
    
    //Los datos rellenados
    let placeholder: String
    //Nombre del dato que queremos que rellene
    let text: String
    
    let paddingLeading : CGFloat?
    let paddingHorizontal : CGFloat?
    //padding(.leading, -80).padding(.horizontal,80)
    
    var body: some View{
        
        //Dentro irán todos los elementos de la parte del login
        //Todo se coloca a la derecha de la pantalla
        ZStack (alignment: .leading) {
            
            //LocalizedStringKey(placeholder)
            Text(LocalizedStringKey(placeholder))
                .foregroundColor(.white)
                .offset(y: text.isEmpty ? 0 : -25)
                .scaleEffect(text.isEmpty ? 1 : 0.9, anchor: .leading).padding(.leading, paddingLeading).padding(.horizontal,paddingHorizontal)
            
            //Email
            Text(LocalizedStringKey(text)).foregroundColor(.white)
            
            
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

struct CamposEntradaMostrar_Previews: PreviewProvider {
    static var previews: some View {
        CamposEntradaMostrar(placeholder: "email", text: "algo", paddingLeading: 1, paddingHorizontal: 2)
    }
}

/* Solo mostrar no modificar datos en le campo */
struct ValidacionError: View {
    
    //Validador que no mostrar al principio
    let textStart:String
    //Tipo de error
    let textError: String
    
    var body: some View{
        //Validación al pincipio empty
        if !textStart.isEmpty {
            //Mostrar error validación
            Text(LocalizedStringKey(textError)).font(.caption).foregroundColor(.red).padding(.horizontal,40)
        }
    }
}

struct ValidacionError_Previews: PreviewProvider {
    static var previews: some View {
        ValidacionError(textStart: "textStart", textError: "textError")
    }
}

struct CamposPost: View {
    
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
            
            Text(LocalizedStringKey(placeholder))
                .foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423))
                .offset(y: text.isEmpty ? 0 : -25)
                .scaleEffect(text.isEmpty ? 1 : 0.9, anchor: .leading)
                
            //Nos mostrará diferentes campos de entrada de texto dependiendo del campo
            if isSecureField ?? false{
                
                //Contraseña
                SecureField(LocalizedStringKey(placeholder), text: $text)
                    .foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423))
                
            }else{
                
                //Email
                TextField(LocalizedStringKey(placeholder), text: $text)
                    .foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423))
                
            }
            
        }
        .padding(.top, self.text.isEmpty ? 0 : 18)
        //Hace el efecto más suave
        //Encontrar algo más actual por versión de iOS
        .padding()
        //Recuadro que enmarca el texto
        .background(
            RoundedRectangle(cornerRadius: 10)
                //Quitar el fondo del rectángulo con la opacidad del color
                .stroke(text.isEmpty ? Color(red: 0.331, green: 0.074, blue: 0.423) : Color(red: 0.331, green: 0.074, blue: 0.423), lineWidth: 2)
        )
        //Separación de los laterales de la vista
        .cornerRadius(10)
        .padding(35)
        //Para que sólo se mueva uno
        .frame(height: 70)
        .accentColor(Color(red: 0.331, green: 0.074, blue: 0.423))
    }
}

struct CamposPost_Previews: PreviewProvider {
    static var previews: some View {
        CamposPost(placeholder: "Email",isSecureField: false, text: .constant(""))
    }
}

//
//  CustomInputField.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 4/4/22.
//

import SwiftUI
 
struct CustomInputField: View {
    
    let imageName : String
    let placeHolderText : String
    //Para el campo contraseña
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {

        VStack{
            HStack{
                
                //Foto ícono
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                //Indicamos el tipo campo de texto de entrada
                if isSecureField ?? false{
                    //Contraseña
                    SecureField(placeHolderText, text: $text)
                }else{
                    //Texto indicativo campo
                    TextField(placeHolderText, text: $text)
                }
                
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeHolderText: "Email",isSecureField: false, text: .constant(""))
    }
}

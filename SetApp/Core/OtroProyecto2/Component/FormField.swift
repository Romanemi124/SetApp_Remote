//
//  FormField.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 4/5/22.
//

import SwiftUI

//Clase modelo de los campos de texto
struct FormField: View {
     
    @Binding var value: String
    var icon: String
    var placeholder: String
    var isSecure = false
    
    var body: some View {
        
        Group{
            
            HStack{
                
                //Imagen
                Image(systemName: icon).padding()
                
                //Campos de escritura
                Group{
                    
                    if isSecure{
                        
                        SecureField(placeholder, text: $value)
                        
                    }else{
                        
                        TextField(placeholder, text: $value)
                    }
                    
                }.font(Font.system(size: 20, design: .monospaced))
                    .foregroundColor(.black)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 4)).padding()
            
        }
    }
}

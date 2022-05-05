//
//  ButtonModifiers.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 4/5/22.
//

import SwiftUI

//Clase modelo para los botones
struct ButtonModifiers: ViewModifier {
    
    func body(content: Content) -> some View {
        content.frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 20)
            .padding()
            .foregroundColor(.white)
            .font(.system(size:14, weight: .bold))
            .background(Color.black)
            .cornerRadius(5.0)
        
    }
}

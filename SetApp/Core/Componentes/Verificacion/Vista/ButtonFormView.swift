//
//  ButtonFormView.swift
//  Validation
//
//  Created by Omar Bonilla Varela on 18/4/22.
//

import SwiftUI

/* Para el botón de registrarse */
struct ButtonFormView: View {
    
    //Escribimos un alias para no tener todo el código otra vez
    typealias ButtonFormAction = (_ id: CamposFormulario) -> Void
    
    //Obtenemos la configuración de nuestro modelo con esta variable
    let buttonComponent: ButtonFormItem
    
    private let handler: ButtonFormAction
    
    //Inicializamos
    init(buttonComponent: ButtonFormItem,
         handler: @escaping ButtonFormView.ButtonFormAction) {
        self.buttonComponent = buttonComponent
        self.handler = handler
    }
    
    var body: some View {
        
        //Creamos la vista del botón
        Button(buttonComponent.titulo) {
            handler(buttonComponent.idFormulario)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
               minHeight: 44,
               alignment: .center)
        .background(Color.blue)
        .foregroundColor(.white)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(8)
    }
}

struct ButtonFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ButtonFormView(buttonComponent: .init(id: .submit, titulo: "Confirm")) { _ in }.previewLayout(.sizeThatFits)
        
    }
}

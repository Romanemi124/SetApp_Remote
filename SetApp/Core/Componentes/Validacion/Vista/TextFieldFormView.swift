//
//  TextFieldFormView.swift
//  Validation
//
//  Created by Omar Bonilla Varela on 18/4/22.
//

import SwiftUI

/* Para el campo nombre, apellidos, nombre de usuario y correo electrónico */
struct TextFieldFormView: View {
    
    /* Variable de entorno que nos servirá para indicar al Bueno  */
    @EnvironmentObject var formularioContenido: ContenidoFormularioImpl
    //Mira lo está escrito
    @State private var text = ""
    //Escuha cada vez que se produce un error de validación
    @State private var validarError: ValidarError?
    //Obtenemos la configuración de nuestro modelo con esta variable
    let textComponent: TextFormComponent
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(textComponent.placeholder).font(.system(size: 16))
            
            TextField("", text: $text)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       minHeight: 44,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.leading, 5)
            //Indicamos que tipo de teclado se utilizará para añadir los datos
                .keyboardType(textComponent.keyboardType)
            //Mostraremos los bordes rojos si se produce un error y gris de forma predeterminada o si el campo cumple la validación
                .background(
                    RoundedRectangle(cornerRadius: 10,
                                     style: .continuous)
                    //Cambia mos el color si el color de los bordes a rojo si hay algún error
                        .stroke(validarError != nil ? Color.red : Color.gray.opacity(0.25), lineWidth: 1))
            //Cada vez que la variable de estado text se revisará si hay errores
                .onChange(of: text, perform: { value in
                    
                    /* Validamos si hay un error */
                    validarError = textComponent
                        .validaciones
                        .compactMap { $0.validar(text) }
                        .first
                    
                    /* Cambiamos el estado de la variable */
                    formularioContenido.actualizar(val: text, in: textComponent)
                    
                    print("Changed: \(text)")
                    print(validarError)
                })
            
            //Texto que muestra los errores
            /* validationError?.errorDescription ?? "" Si hay un error se mostrá sino se mostrará una cadena vacía */
            Text(validarError?.descripcionError ?? "")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color.red)
        }
    }
}

struct TextFieldFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        //Inicializamos el componente
        TextFieldFormView(textComponent: .init(id: .email,
                                               placeholder: ""))
        .environmentObject(ContenidoFormularioImpl())
        .padding(.horizontal, 8)
        .previewLayout(.sizeThatFits)
    }
}

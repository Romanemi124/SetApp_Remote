//
//  DateFormView.swift
//  Validation
//
//  Created by Omar Bonilla Varela on 18/4/22.
//

import SwiftUI

/* Para la fecha de nacimiento */
struct DateFormView: View {
    
        @EnvironmentObject var formularioContenido: ContenidoFormularioImpl
        //Variable para almacenar la fecha seleccionada
        @State private var selectedDate = Date()
        //Variable para almacenar los errores
        @State private var validarError: ValidarError?
        //Obtenemos la configuración de nuestro modelo con esta variable
        let dateComponent: DateFormComponent
        
        var body: some View {
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    DatePicker("",
                               selection: $selectedDate,
                           displayedComponents: [.date])
                    //.labelsHidden() de esta forma la posciocionamos en la parte izquierda
                        .labelsHidden()
                        .fixedSize()
                    //Cada que se cambie la fecha revisará los cambios y buscará errores
                        .onChange(of: selectedDate, perform: { value in
                            
                            /* Validamos si hay un error */
                            validarError = dateComponent
                                .validaciones
                                .compactMap { $0.validar(selectedDate) }
                                .first
                            
                            /* Cambiamos el estado de la variable con la fehca que alguien ha seleccionado */
                            formularioContenido.actualizar(val: selectedDate, in: dateComponent)
                        })
                    Spacer()
                }
                
                //Texto que muestra los errores
                Text(validarError != nil ? validarError!.descripcionError : "")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color.red)
            }
        }
}

struct DateFormView_Previews: PreviewProvider {
    static var previews: some View {
        
        DateFormView(dateComponent: .init(id: .dob, mode: .date))
                   .environmentObject(ContenidoFormularioImpl()).previewLayout(.sizeThatFits)
        
    }
}

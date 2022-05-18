//
//  AjustePerfilView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 18/5/22.
//

import SwiftUI

struct AjustePerfilView: View {
    
    @State private var poderEliminar = false
    
    var body: some View {
        
        ZStack {
            
            FondoPantallasApp()
            
            VStack{
                
                //Cambiar contraseña
                HStack {
                    
                    NavigationLink{
                        
                        CambiarPasswordView().navigationBarHidden(true)
                        
                    }label: {
                        Text("Cambiar contraseña").foregroundColor(.white)
                    }
                    
                }
                .padding()
                //Recuadro que enmarca el texto
                .background(
                    RoundedRectangle(cornerRadius: 10)
                    //Quitar el fondo del rectángulo con la opacidad del color
                        .stroke(.white, lineWidth: 2)
                )
                //Separación de los laterales de la vista
                .cornerRadius(10)
                .padding(35)
                //Para que sólo se mueva uno
                .frame(height: 70)
                
                
                //Eliminar cuenta
                HStack {
                    
                    NavigationLink{
                        
                        EliminarCuentaView(poderEliminar: $poderEliminar)
                        
                    }label: {
                        Text("Eliminar cuenta").foregroundColor(.white)
                    }
                    
                }
                .padding()
                //Recuadro que enmarca el texto
                .background(
                    RoundedRectangle(cornerRadius: 10)
                    //Quitar el fondo del rectángulo con la opacidad del color
                        .stroke(.white, lineWidth: 2)
                )
                //Separación de los laterales de la vista
                .cornerRadius(10)
                .padding(35)
                //Para que sólo se mueva uno
                .frame(height: 70)
                
            }
        }
    }
}

struct AjustePerfilView_Previews: PreviewProvider {
    static var previews: some View {
        AjustePerfilView()
    }
}

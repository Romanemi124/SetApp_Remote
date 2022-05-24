//
//  AjustePerfilView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 18/5/22.
//

import SwiftUI

struct AjustePerfilView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    @State private var poderEliminar = false
    
    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
        
            //Mostramos la vista deseada
            ZStack{
                
                //Imagen de fondo de la vista
                EstablecerFondoPrincipal()
                
                VStack {
                    
                    //Título
                    /*------------------------------------*/
                    CabeceraAutentificacionView(titulo1: "Ajustes", titulo2: "")
                    
                    Image("SetApp")
                        .resizable()
                        .frame(width: 120, height: 120)
                    
                    Spacer()
                 
                    VStack{
                        
                        //Cambiar contraseña
                        HStack {
                            
                            NavigationLink{
                                
                                CambiarPasswordView()
                                
                            }label: {
                                Text("ajustes-cambiar-pasword")
                                    .foregroundColor(.white)
                                    .scaleEffect(anchor: .leading)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 250)
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
                        
                        
                        //Eliminar cuenta
                        HStack {
                            
                            NavigationLink{
                                
                                EliminarCuentaView(poderEliminar: $poderEliminar)
                                
                            }label: {
                                Text("ajustes-eliminar-cuenta").foregroundColor(.white)
                            }
                            .frame(width: 250)
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
                        .frame(height: 100)
                        
                    }
                    Spacer(minLength: 50)
                }
            }
            
        }
    }
}

struct AjustePerfilView_Previews: PreviewProvider {
    static var previews: some View {
        AjustePerfilView()
    }
}


/*
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
 */

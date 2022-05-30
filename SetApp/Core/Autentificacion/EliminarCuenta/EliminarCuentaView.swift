//
//  BorrarCuentaView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 18/5/22.
//

import SwiftUI

struct EliminarCuentaView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var estadoUsuario: EstadoAutentificacionUsuario
    //Controlamos que se puda borrar o no la cuenta
    @Binding var poderEliminar: Bool
    //Provedores de autentificacion
    @State private var provedores: [Autentificacion.ProviderType] = []
    
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
                    CabeceraAutentificacionView(titulo1: "SetApp", titulo2: "eliminarCuenta-titulo")
                    
                    Image("SetApp")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.bottom, 60)
                    
                    Text(estadoUsuario.usuario.nombreCompleto)
                        .font(.title)
                        .padding(.bottom, 20)
                        .foregroundColor(.white)
                    
                    Text(poderEliminar ? LocalizedStringKey("eliminarCuenta-pregunta-seguridad") : LocalizedStringKey("eliminarCuenta-inicio"))
                        .padding(.bottom, 50)
                        .foregroundColor(.white)
                    
                    HStack {
                        //Cancelar
                        Button(LocalizedStringKey("reautentificacion-cancelar")) {
                            poderEliminar = false
                            presentationMode.wrappedValue.dismiss()
                        }
                        .padding(.vertical, 15)
                        .frame(width: 100)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .foregroundColor(Color(.label))
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        
                        Button(poderEliminar ? "eliminarCuenta-boton-eliminar" : "eliminarCuenta-boton-autentificarte") {
                            
                            if poderEliminar {
                                
                                StorageService.eliminarFotoPerfil(id: estadoUsuario.usuario.id!){ result in
                                    // Mostramos los resultados de la busqueda
                                    switch result {
                                        
                                        //En caso de error o que no haya encontrado
                                    case .failure(let error):
                                        //Mostraremos un alert indicando que ha habido alñgún error al borrar la foto
                                        print("Error: Al borrar foto de perfil \(error.localizedDescription)")
                                        //En caso de que se haya borrado correcatmente
                                    case .success(_):
                                        
                                        Store.borrarDatosUsuario(id: estadoUsuario.usuario.id!){ result in
                                            switch result {
                                            case .success:
                                                //Eliminamos el usuario
                                                Autentificacion.eliminarUsuario{ result in
                                                    if case let .failure(error) = result {
                                                        print("Debug Error: Error al eliminar el usuario \(error.localizedDescription)")
                                                    }
                                                }
                                            case .failure(let error):
                                                print(error.localizedDescription)
                                            }
                                            
                                        }
                                        
                                    }
                                }
                                
                            } else {
                                withAnimation {
                                    //Obtener los proveedores de autentificación
                                    provedores = Autentificacion.getProviders()
                                }
                            }
                        }
                        .padding(.vertical, 15)
                        .frame(width: 150)
                        .background(Color(red: 0.331, green: 0.074, blue: 0.423))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal,10)
                //Se dirigirá a la vista reautentificación si hay por lo menos algún proveedor de reautentificación
                if !provedores.isEmpty {
                    ReAutentificacionView(provedores: $provedores, poderEliminar: $poderEliminar)
                }
            }
        }
    }
}

struct EliminarCuentaView_Previews: PreviewProvider {
    static var previews: some View {
        EliminarCuentaView(poderEliminar: .constant(false))
    }
}

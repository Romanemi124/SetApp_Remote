//
//  BorrarCuentaView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 18/5/22.
//

import SwiftUI

struct EliminarCuentaView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var estadoUsuario: EstadoAutentificacionUsuario
    //Controlamos que se puda borrar o no la cuenta
    @Binding var poderEliminar: Bool
    //Provedores de autentificacion
    @State private var provedores: [Autentificacion.ProviderType] = []
    
    var body: some View {
        ZStack {
            VStack {
                Text(estadoUsuario.usuario.nombreCompleto)
                    .font(.title)
                Text(poderEliminar ? "¿Estás seguro que quieres eliminar tu cuenta?" : "Has iniciado sesión con \(estadoUsuario.usuario.email). Para eliminar tu cuenta antes tienes que reautentificarte. Al eliminar tu cuenta se borrara todas tus publicaciones e información personal")
                HStack {
                    //Cancelar
                    Button("Cancel") {
                        poderEliminar = false
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.vertical, 15)
                    .frame(width: 100)
                    .background(Color(.systemBackground))
                    .cornerRadius(8)
                    .foregroundColor(Color(.label))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    Button(poderEliminar ? "ELIMINAR CUENTA" : "Autentificarte") {
                        
                        if poderEliminar {
                            
                            print("DELETE ACCOUNT")
                            
                            StorageService.eliminarFotoPerfil(id: estadoUsuario.usuario.id!){ result in
                                // Mostramos los resultados de la busqueda
                                switch result {
                                    
                                    //En caso de error o que no haya encontrado
                                case .failure(let error):
                                    //Mostraremos un alert indicando que ha habido alñgún error al borrar la foto
                                    print("Error: Al borrar foto de perfil \(error.localizedDescription)")
                                    //En caso de que se haya borrado correcatmente
                                case .success(_):
                                    print("Se ha borrado la foto correctamente")
                                    
                                    Store.borrarDatosUsuario(id: estadoUsuario.usuario.id!){ result in
                                        switch result {
                                        case .success:
                                            Autentificacion.eliminarUsuario{ result in
                                                if case let .failure(error) = result {
                                                    print(error.localizedDescription)
                                                }
                                            }
                                        case .failure(let error):
                                            print(error.localizedDescription)
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                        } else {
                            print("Autenticando")
                            withAnimation {
                                provedores = Autentificacion.getProviders()
                            }
                        }
                    }
                    .padding(.vertical, 15)
                    .frame(width: 179)
                    .background(Color.red)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(.top, 40)
            .padding(.horizontal,10)
            if !provedores.isEmpty {
                ReAutentificacionView(provedores: $provedores, poderEliminar: $poderEliminar)
            }
        }
    }
}

struct EliminarCuentaView_Previews: PreviewProvider {
    static var previews: some View {
        EliminarCuentaView(poderEliminar: .constant(false))
    }
}

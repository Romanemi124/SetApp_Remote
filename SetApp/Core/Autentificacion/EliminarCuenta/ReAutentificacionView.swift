//
//  ReAuthenticateView.swift
//  Firebase Login
//
//  Created by Stewart Lynch on 2021-07-05.
//  Copyright © 2021 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct ReAutentificacionView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    @Binding var provedores: [Autentificacion.ProviderType]
    @Binding var poderEliminar: Bool
    @State private var password = ""
    @State private var textError = ""
    
    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
            
            //Mostramos la vista deseada
            ZStack {
                
                Color(.gray).opacity(0.4)
                    .ignoresSafeArea()
                
                VStack {
                    
                    if provedores.count == 1 {
                        Text("Autentificate")
                            .frame(height: 60)
                            .padding(.horizontal)
                    }
                    
                    ForEach(provedores, id: \.self) { provider in
                        
                        if provider == .password{
                            
                            VStack {
                                
                                SecureField("reautentificacion-password", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                Button(LocalizedStringKey("reautentificacion-terminar")) {
                                    Autentificacion.reautenticacionConPassword(password: password) { result in
                                        handleResult(result: result)
                                    }
                                    
                                }
                                .padding(.vertical, 15)
                                .frame(width: 200)
                                .background(Color(red: 0.331, green: 0.074, blue: 0.423))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .opacity(password.isEmpty ? 0.6 : 1)
                                .disabled(password.isEmpty)
                            }
                            
                        }
                    }
                    //Texto de error
                    Text(textError)
                        .foregroundColor(.red)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Button(LocalizedStringKey("reautentificacion-cancelar")) {
                        withAnimation {
                            provedores = []
                        }
                    }
                    .padding(8)
                    .foregroundColor(.primary)
                    .background(Color(.secondarySystemBackground))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    Spacer()
                }
                //height: providers.count == 2 ? 350 : 230 elegimos el ancho en función del número de porvedores de auntetificación
                .frame(width: 250, height: provedores.count == 2 ? 350 : 260)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
            }
        }
        
    }
    
    func handleResult(result: Result<Bool,Error>) {
        switch result {
        case .success:
            //Ya está reutentificado ya puede borrar la cuenta
            poderEliminar = true
            withAnimation {
                provedores = []
            }
        case .failure(let error):
            //Elegimos el texto de error a mostrar, controlamos el tipo de error
            switch error.localizedDescription{
                
            case ErroresString.ErroresReAutentificacion.passwordIncorrecta:
                self.textError = ErroresString.ErroresReAutentificacion.passwordIncorrectaTraduccion
                //Mostramos cualquier tipo de error sucedido
            default:
                self.textError = error.localizedDescription
            }
        }
    }
}

struct ReAutentificacionView_Previews: PreviewProvider {
    static var previews: some View {
        ReAutentificacionView(provedores: .constant([.password]), poderEliminar: .constant(false))
    }
}

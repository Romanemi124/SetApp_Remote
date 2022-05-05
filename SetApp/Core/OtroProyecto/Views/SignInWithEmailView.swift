//
//  SignInWithEmailView.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-19.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct SignInWithEmailView: View {
    
    //Alamacenar las credenciales del usuario
    @EnvironmentObject var userInfo: InformacionUsuario
    //Almacenar el estado de autentificación del modelo de la vista (Verficar si los datos están correctos)
    @State var user: UserViewModel = UserViewModel()
    
    //Lógica mostrar las vistas
    @Binding var showSheet: Bool
    @Binding var action:LoginView2.Action?
    
    //Mostrar los errores
    @State private var showAlert = false
    @State private var authError: EmailAuthError?
    
    var body: some View {
        
        //Email y contraseña
        VStack {
            
            //Email
            TextField("Email Address",
                      text: self.$user.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            //Contraseña
            SecureField("Password", text: $user.password)
            
            HStack {
                
                Spacer()
                Button(action: {
                    self.action = .resetPW
                    self.showSheet = true
                }) {
                    Text("Forgot Password")
                }
                
            }.padding(.bottom)
            
            /* Olvido de contraseña, botón de iniciar sesión y registrase */
            VStack(spacing: 10) {
                
                //Botón iniciar sesión
                Button(action: {
                    
                    FBAuth.authenticate(withEmail: self.user.email,
                                        password: self.user.password) { (result) in
                        
                                            //Gestión de los resultados
                                            switch result {
                                                
                                            //Caso de error
                                            case .failure(let error):
                                                
                                                self.authError = error
                                                self.showAlert = true
                                            //Caso de autentificación correcta
                                            case .success( _):
                                                print("Signed in")
                                                
                                            }
                    }
                }) {
                    Text("Login")
                        .padding(.vertical, 15)
                        .frame(width: 200)
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        //La opacidad se modifica según la validación de los campos
                        .opacity(user.isLogInComplete ? 1 : 0.75)
                //Desabilitaremos el botón si la validación no es correcta
                }.disabled(!user.isLogInComplete)
                
                //Botón registrarse
                Button(action: {
                    self.action = .signUp
                    self.showSheet = true
                }) {
                    Text("Sign Up")
                        .padding(.vertical, 15)
                        .frame(width: 200)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
            }
            
            //Mostrar los alert con los errores
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(self.authError?.localizedDescription ?? "Unknown error"), dismissButton: .default(Text("OK")) {
                    if self.authError == .incorrectPassword {
                        self.user.password = ""
                    } else {
                        self.user.password = ""
                        self.user.email = ""
                    }
                    })
            }
        }
        .padding(.top, 100)
        .frame(width: 300)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
    }
}

struct SignInWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithEmailView(showSheet: .constant(false), action: .constant(.signUp))
    }
}

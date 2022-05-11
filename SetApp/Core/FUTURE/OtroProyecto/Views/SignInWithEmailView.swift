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
    
    //Mostrar los errores
    @State private var showAlert = false
    @State private var authError: EmailAutentificacionError?
    
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
                
                //Link olvido de contraseña
                NavigationLink{
                    
                    ForgotPasswordView()
                        .navigationBarHidden(true)
                    
                }label: {
                    
                    HStack {
                        Text("Forgot Password")
                            .font(.footnote)
                            .foregroundColor(.blue)
                        
                    }
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(.systemBlue))
                
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
                
                Spacer()
                
                //Link Registrarse
                NavigationLink{
                    
                    RegistroView2()
                        .navigationBarHidden(true)
                    
                }label: {
                    
                    HStack {
                        Text("¿No tienes cuenta?")
                            .font(.footnote)
                            .foregroundColor(.white)
                        
                        Text("Registrate aquí")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(.systemBlue))
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
        SignInWithEmailView()
    }
}

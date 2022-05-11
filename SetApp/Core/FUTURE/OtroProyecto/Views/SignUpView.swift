//
//  SignUpView.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-19.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
    //Guardar información del estado de autentificación del usuario
    @EnvironmentObject var userInfo: InformacionUsuario
    //Acceder a validar los campos de entrada
    @State var user: UserViewModel = UserViewModel()
    
    //Irse
    @Environment(\.presentationMode) var presentationMode
    
    /* Manejo de errores */
    //Mostrar o no los errores
    @State private var showError = false
    //Cadena con el error a mostrar
    @State private var errorString = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                //Mostrar las compos de entrada con sus validaciones
                Group {
                    
                    //Nombre completo
                    VStack(alignment: .leading) {
                        TextField("Full Name", text: self.$user.fullname).autocapitalization(.words)
                        if !user.validNameText.isEmpty {
                            Text(user.validNameText).font(.caption).foregroundColor(.red)
                        }
                    }
                    //Email
                    VStack(alignment: .leading) {
                        TextField("Email Address", text: self.$user.email).autocapitalization(.none).keyboardType(.emailAddress)
                        if !user.validEmailAddressText.isEmpty {
                            Text(user.validEmailAddressText).font(.caption).foregroundColor(.red)
                        }
                    }
                    //Contraseña
                    VStack(alignment: .leading) {
                        SecureField("Password", text: self.$user.password)
                        if !user.validPasswordText.isEmpty {
                            Text(user.validPasswordText).font(.caption).foregroundColor(.red)
                        }
                    }
                    //Confirmar Contraseña
                    VStack(alignment: .leading) {
                        SecureField("Confirm Password", text: self.$user.confirmPassword)
                        if !user.passwordsMatch(_confirmPW: user.confirmPassword) {
                            Text(user.validConfirmPasswordText).font(.caption).foregroundColor(.red)
                        }
                    }
                    
                }.frame(width: 300)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                VStack(spacing: 20 ) {
                    
                    Button(action: {
                                                
                        //Crear el usuario
                        FBAuth.createUser(withEmail: self.user.email,
                                          name: self.user.fullname,
                                          password: self.user.password) { (restult) in
                            // Mostramos los resultados del registro
                            switch restult {
                                
                            //En caso de error
                            case .failure(let error):
                                
                                /* !!! Futuro elegir el tipo de error a mostrar aquí */
                                //Elegimos el texto de error a mostrar, controlamos el tipo de error
                                switch error.localizedDescription{
                                //En caso que el ya exista el email introducido
                                case  "The email address is already in use by another account.":
                                    self.errorString = "La dirección de correo electrónico introducida ya existe"
                                    break
                                //Mostramaos cualquier tipo de error sucedido
                                default:
                                    self.errorString = error.localizedDescription
                                    break
                                }
                                
                                //Mostramos el error
                                self.showError = true
                                
                            case .success( _):
                                
                                print("Account creation successful")
                            }
                        }
                        
                    }) {
                        Text("Register")
                            .frame(width: 200)
                            .padding(.vertical, 15)
                            .background(Color.green)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                        //La opacidad se modifica según la validación de los campos
                            .opacity(user.isSignInComplete ? 1 : 0.75)
                    }
                    //Desabilitaremos el botón si la validación no es correcta
                    .disabled(!user.isSignInComplete)
                    Spacer()
                }.padding()
                
            }.padding(.top)
            //El alert de la vista, servirá para mostrar errores
                .alert(isPresented: $showError) {
                    //El alert que se va mostrar
                    Alert(title: Text("Error al crear cuenta"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
                }
                .navigationBarTitle("Sign Up", displayMode: .inline)
                .navigationBarItems(trailing: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

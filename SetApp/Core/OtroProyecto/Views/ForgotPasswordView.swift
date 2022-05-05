//
//  ForgotPasswordView.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-19.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    //Validaciones de los usuarios 
    @State var user: UserViewModel = UserViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    @State private var errString: String?
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                TextField("Enter email address", text: $user.email).autocapitalization(.none).keyboardType(.emailAddress)
                
                Button(action: {
                    
                    FBAuth.resetPassword(email: self.user.email) { (result) in
                        switch result {
                        case .failure(let error):
                            self.errString = error.localizedDescription
                        case .success( _):
                            break
                        }
                        self.showAlert = true
                    }
                }) {
                    Text("Reset")
                        .frame(width: 200)
                        .padding(.vertical, 15)
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    //La opacidad se modifica según la validación de los campos
                        .opacity(user.isEmailValid(_email: user.email) ? 1 : 0.75)
                }
                //Desabilitaremos el botón si la validación no es correcta
                .disabled(!user.isEmailValid(_email: user.email))
                Spacer()
            }.padding(.top)
                .frame(width: 300)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            .navigationBarTitle("Request a password reset", displayMode: .inline)
                .navigationBarItems(trailing: Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Password Reset"),
                          message: Text(self.errString ?? "Success. Reset email sent successfully.  Check your email"),
                          dismissButton: .default(Text("OK")) {
                            self.presentationMode.wrappedValue.dismiss()
                        })
            }
        }
    }
}


struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}

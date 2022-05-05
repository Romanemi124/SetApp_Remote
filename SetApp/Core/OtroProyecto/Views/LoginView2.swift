//
//  LoginView.swift
//  Firebase Login
//
//  Created by Stewart Lynch on 2020-03-23.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

struct LoginView2: View {
    
    //Diferentes vistas posibles según la elección del usuario
    enum Action {
        case signUp, resetPW
    }
    //Variable para mostrar o no la nueva vista
    @State private var showSheet = false
    //Variable para elegir el tipo de vista
    @State private var action: Action?
    
    var body: some View {
        
        VStack {
            
            SignInWithEmailView(showSheet: $showSheet, action: $action)
           // SignInWithAppleButtonView()
            Spacer()
        }
            .sheet(isPresented: $showSheet) { [action] in
                //Elegimos el tipo de vista
                if action == .signUp {
                    SignUpView()
                } else {
                    ForgotPasswordView()
                }
        }
    }
}

struct LoginView2_Previews: PreviewProvider {
    static var previews: some View {
        LoginView2()
    }
}

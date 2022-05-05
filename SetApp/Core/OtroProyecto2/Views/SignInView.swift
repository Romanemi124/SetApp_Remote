//
//  SignInView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 4/5/22.
//

import SwiftUI

//Clase para iniciar sesión
struct SignInView: View {
    
    @State private var email : String = ""
    @State private var password : String = ""
    //Compronar errores
    @State private var error : String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Error"
    
    //Comprobar que todos los campos están rellenados
    func errorCheck()-> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty {
            return "Porfavor rellena todos los campos y elege una foto de perfil"
        }
        return nil
    }
    
    //Limpiar los campos
    func clear(){
        self.email = ""
        self.password = ""
    }
    
    func signIn(){
        
        if let error =  errorCheck(){
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signIn(email: email, password: password, onSuccess: {
            //En caso de uqe se haya registrado correctamente
            (user) in
            self.clear()
        }){
            //En caso de haya habido algún error
            (errorMessage) in
            print("Error\(errorMessage)")
            self.error = errorMessage
            //Mostrar el error en el Alert
            self.showingAlert = true
            return
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 20){
                
                //Imagen logo Aquí
                Image(systemName: "camera").font(.system(size: 60, weight: .black, design: .monospaced))
                
                VStack(alignment: .leading){
                    
                    //Titulo 1
                    Text("Bienvenido").font(.system(size: 32, weight: .heavy))
                    //Titulo 2
                    Text("Iniciar sesion para entrar").font(.system(size: 16, weight: .medium))
                }
                    //Email
                    FormField(value: $email, icon: "envelope.fill", placeholder: "Email", isSecure: false)
                    
                    //Password
                    FormField(value: $password, icon: "lock.fill", placeholder: "Contraseña", isSecure: true)
                    
                    //Boton iniciar sesión
                    Button(action: signIn) {
                      
                        Text("Iniciar Sesión").font(.title).modifier(ButtonModifiers())
                    }.alert(isPresented: $showingAlert){
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("Ok")))
                    }
                    
                //Dirgirse a crear cuenta
                HStack{
                    
                    Text("¿Eres nuevo?")
                    //Link
                    NavigationLink(destination: SignUpView2()) {
                        Text("Crear cuenta").font(.system(size: 20, weight: .semibold))
                    }
                }
                
                Spacer()
                
            }.padding()
            
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

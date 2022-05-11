//
//  SignUpView2.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 4/5/22.
//

import SwiftUI
import CoreMedia

//Clase para registrarse
struct SignUpView2: View {
    
    @State private var userName : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    //Elegir imagen de perfil
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType:UIImagePickerController.SourceType = .photoLibrary
    //Compronar errores
    @State private var error : String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Error"
    
    func loadImage(){
        
        guard let inputImage = pickedImage else {return}
        
        self.profileImage = inputImage
    }
    
    //Comprobar que todos los campos están rellenados
    func errorCheck()-> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty || userName.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
            return "Porfavor rellena todos los campos y elege una foto de perfil"
        }
        return nil
    }
    
    func signUp(){
        if let error =  errorCheck(){
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signUp(userName: userName, emial: email, password: password, imageData: imageData, onSuccess: {
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
    
    //Limpiar los campos
    func clear(){
        self.email = ""
        self.userName = ""
        self.password = ""
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20){
                
                //Imagen logo Aquí
                Image(systemName: "camera").font(.system(size: 60, weight: .black, design: .monospaced))
                
                VStack(alignment: .leading){
                    
                    //Titulo 1
                    Text("Bienvenido").font(.system(size: 32, weight: .heavy))
                    //Titulo 2
                    Text("Registrarte para entrar").font(.system(size: 16, weight: .medium))
                }
                
                VStack{
                    
                    Group{
                        
                        if profileImage != nil {
                            profileImage!.resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 190)
                                .padding(.top, 20)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }else{
                            
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 190)
                                .padding(.top, 20)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }
                    }
                }
                
                // Nombre de usuario, Email y Password
                Group{
                    
                    //Nombre de usuario
                    FormField(value: $userName, icon: "person.fill", placeholder: "Nombre de usuario", isSecure: false)
                    
                    //Email
                    FormField(value: $email, icon: "envelope.fill", placeholder: "Email", isSecure: false)
                    
                    //Password
                    FormField(value: $password, icon: "lock.fill", placeholder: "Contraseña", isSecure: true)
                }
                
                
                //Boton crear cuenta
                Button(action: signUp) {
                    Text("Crear cuenta").font(.title).modifier(ButtonModifiers())
                }.alert(isPresented: $showingAlert){
                    Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("Ok")))
                }
                
            }.padding()
            
        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            
            ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
            
        }.actionSheet(isPresented: $showingActionSheet){
            
            ActionSheet(title: Text("Notificación"),
                        buttons: [.default(Text("Seleccionar Imagen")){
                                    self.sourceType = .photoLibrary
                                    self.showingImagePicker = true
                                },.cancel()])
            
        }
        
    }
}

struct SignUpView2_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView2()
    }
}

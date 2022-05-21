//
//  IniciarSesionView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import SwiftUI

struct IniciarSesionView: View {
    
    //Almacenar las credenciales del usuario, escuchando cuando inicia sesión
    @EnvironmentObject var estadoUsuario: EstadoAutentificacionUsuario
    //Almacenar el estado de autentificación del modelo de la vista (Verficar si los datos están correctos)
    @State var usuarioValidacion: Validacion = Validacion()
    
    //Mostrar los errores
    @State private var showAlert = false
    //Tipos de errores personalizados de iniciar sesión
    @State private var authError: EmailAutentificacionError?
    
    var body: some View {
        
        ZStack{
            
            //Imagen de fondo de la vista
            EstablecerFondoPrincipal()
            
            VStack {
                
                //Título
                /*------------------------------------*/
                CabeceraAutentificacionView(titulo1: "SetApp", titulo2: "¡Bienvenido de nuevo!")
                    .padding(.top, 20)
                
                Image("SetApp")
                    .resizable()
                    .frame(width: 170, height: 170)
                    .padding(.bottom, 20)
                
                //Email y contraseña
                /*------------------------------------*/
                CamposEntrada(placeholder: "Email", isSecureField: false, text: self.$usuarioValidacion.email)
                CamposEntrada(placeholder: "Contraseña", isSecureField: true, text: $usuarioValidacion.password)
                
                //Página olvido de contraseña
                /*------------------------------------*/
                HStack{
                    
                    Spacer()
                    
                    NavigationLink{
                        CambiarPasswordView()
                            .navigationBarHidden(true)
                    }label: {
                        Text("¿Has olvidado la contraseña?")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.trailing, 30)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 30)
                
                /* Botón de iniciar sesión */
                /*------------------------------------*/
                Button(action: {
                    
                    Autentificacion.autenticar(withEmail: self.usuarioValidacion.email,
                                               password: self.usuarioValidacion.password) { (result) in
                        
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
                    PrimaryButton(title: "Iniciar Sesión")
                    //La opacidad se modifica según la validación de los campos
                        .opacity(usuarioValidacion.estaIniciarSesionCompletado ? 1 : 0.50)
                    //Desabilitaremos el botón si la validación no es correcta
                }.disabled(!usuarioValidacion.estaIniciarSesionCompletado)
                
                //Link Registrarse
                /*------------------------------------*/
                Spacer()
                
                NavigationLink{
                    
                    RegistroView()
                        .navigationBarHidden(true)
                    
                }label: {
                    
                    HStack {
                        Text("¿No tienes cuenta?")
                            .font(.footnote)
                            .foregroundColor(.white)
                        
                        Text("Registrate aquí")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(.systemBlue))
                
                //Mostrar los alert con los errores
                /*------------------------------------*/
                .alert(isPresented: $showAlert) {
                    /* self.authError?.localizedDescription ?? "Error desconocido" indicamos que nos muestre el error en el caso que no se encuentre entre los errores personalizados */
                    Alert(title: Text("Error inicio de sesión"), message: Text(self.authError?.localizedDescription ?? "Error desconocido"), dismissButton: .default(Text("OK")) {
                        //Si hay un error en la contraseña solo se borra el campo contraseña no el campo email introducido
                        if self.authError == .incorrectPassword {
                            self.usuarioValidacion.password = ""
                        } else {
                            //Si hay algún error se borra los campos
                            self.usuarioValidacion.password = ""
                            self.usuarioValidacion.email = ""
                        }
                    })
                }
            }
            
        }
    }
}

struct IniciarSesionView_Previews: PreviewProvider {
    static var previews: some View {
        IniciarSesionView()
    }
}

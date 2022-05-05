//
//  LoginView.swift
//  SetApp
//
//  Created by Emilio Roman on 3/4/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    //Variable para acceder a los datos para iniciar sesión
    @EnvironmentObject var vistaModelo: AutentificacionModelView
    @EnvironmentObject var informacionUsuario: InformacionUsuario
    
    var body: some View {
        
        ZStack {
            
            //Imagen de fondo de la vista
            EstablecerFondoPrincipal()
            
            VStack {
                
                //Título de la cabecerea
                CabeceraAutentificacionView(titulo1: "SetApp", titulo2: "¡Bienvenido de nuevo!")
                
                Spacer(minLength: 220)
                
                /*------------------------------------*/
                
                //TextField donde se introducen los datos y el campo que voy a pasar
                CamposEntrada(placeholder: "Email", isSecureField: false, text: $email)
                CamposEntrada(placeholder: "Contraseña", isSecureField: true, text: $password)
                
                //Página olvido de contraseña
                HStack{
                    
                    Spacer()
                    
                    NavigationLink{
                        
                        Text("Recuperar contraseña")
                        
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
                
                /*------------------------------------*/
                
                //Botón de Iniciar sesión
                Button{
                    
                    //Función para iniciar sesión
                    vistaModelo.iniciarSesion(withEmail: email, password: password)
                    
                    //Indicar que el usuario se ha autentificado
                    self.informacionUsuario.estaUsuarioAutentificado = .iniciarSesion
                    
                }label:{
                    
                    PrimaryButton(title: "Iniciar Sesión")

                }
               
                Spacer()
                
                //Link Registrarse
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
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 32)
                .foregroundColor(Color(.systemBlue))
            }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

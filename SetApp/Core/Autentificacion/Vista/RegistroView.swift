//
//  RegistroView.swift
//  SetApp
//
//  Created by Emilio Roman on 3/4/22.
//

import SwiftUI

enum Sexo: String, CaseIterable {
    
    case hombre  = "Hombre"
    case mujer = "Mujer"
    case otro = "Otro"
    
    var sexo: String{
        
        return rawValue.capitalized
    }
}


struct RegistroView: View {
    
    @State private var elegirSexo: Sexo = .hombre
    @State private var nombreCompleto: String = ""
    @State private var nombreUsuario: String = ""
    @State private var sexo: String = ""
    @State private var fechaNacimiento: Date  = Date()
    @State private var email: String = ""
    @State private var password: String = ""
    /* @Environment(\.presentationMode) Un enlace al modo de presentación de la vista actual asociada con el entorno*/
    //Para poner la vista en modo presentación, esto será util para descartar la vista actual
    @Environment(\.presentationMode) var presentationMode
    //Variable que guarda los datos para registrar
    @EnvironmentObject var vistaModelo: AutentificacionModelView
    
    var body: some View {
        
        //let fechaParseada:String = ParsearFecha.asString(fecha:fechaNacimiento)
        
        //Diseño de la vista principal de la app
        ZStack {
            
            //Imagen de fondo de la vista
            EstablecerFondoPrincipal()
            
            VStack {
                
                /* Tras seleccionar todos los datos llevarnos a la vista de elegir foto de perfil */
                NavigationLink(destination: SeleccionarFotoPefilView(),
                               isActive: $vistaModelo.usuarioAutentificado,
                               label: { })
                
                CabeceraAutentificacionView(titulo1: "SetApp", titulo2: "Únete ahora")
                
                // Grupo de los campos
                Group{
                    
                    CamposEntrada(placeholder: "Nombre completo", isSecureField: false,text: $nombreCompleto)
                    CamposEntrada(placeholder: "Nombre usuario", isSecureField: false,text: $nombreUsuario)
                    
                    //Elegir el sexo del usuario
                    HStack(spacing:150){
                        Text("Seleccionar sexo:").foregroundColor(Color.white)
                        //Elegir el sexo
                        Picker(selection: $elegirSexo, label: Text("")) {
                            ForEach(Sexo.allCases, id: \.self) { sexo in
                                Text(sexo.sexo)
                            }
                        }.labelsHidden()
                    }
    
                    //Edad
                    DatePicker(selection: $fechaNacimiento, displayedComponents: .date){
                    }
                    .padding(10)
                    .padding(.trailing, 28)
                    CamposEntrada(placeholder: "Correo electrónico",isSecureField: false, text: $email)
                    CamposEntrada(placeholder: "Contraseña", isSecureField: true,text: self.$password)
                    
                }
                Button{
                                        
                    //print("DEBUG: Usuario que ha iniciado sesión es \(self.fechaNacimiento)")
                                         
                    vistaModelo.registrarse(withEmial: email, password: password, nombreCompleto: nombreCompleto, nombreUsuario: nombreUsuario, sexo: elegirSexo.sexo, fechaNacimiento:ParsearFecha.asString(fecha:fechaNacimiento) )
                    
                }label:{
                    
                    PrimaryButton(title: "Registrarse")
                }
                
                //Link Registrarse
                Button{
                    
                    //Descartamos la vista actual, de esta forma se vuelva a la vista login
                    presentationMode.wrappedValue.dismiss()
                    
                }label: {
                    
                    HStack {
                        Text("¿Ya tienes cuenta?")
                            .font(.footnote)
                        
                        Text("Inicia sesión aquí")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.bottom, 32)
                .padding(.top, 40)
                .foregroundColor(Color(.white))
            }
        }
    }
    
}

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView()
    }
}

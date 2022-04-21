//
//  FormularioView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/4/22.
//

import SwiftUI
/* Esta pantilla se implemntará en el registro para validar el usuario que se va registrar */
struct FormularioView: View {
    
    /* Usuario que se va registrar */
    @EnvironmentObject var usuario: UsuarioFormulario
    @State private var elegirSexo: Sexo = .hombre
    @State private var nombreCompleto: String = ""
    @State private var nombreUsuario: String = ""
    @State private var fechaNacimiento: Date = Date()
    @State private var email: String = ""
    @State private var password: String = ""
    
    //Variable en la cual llamaremos a los componenentes para que se representen en la vista y además se pasarán los datos para hacer sus validaciones correspondientes
    @StateObject private var formularioContenidoImpl = ContenidoFormularioImpl()
    
    var body: some View {
        
        NavigationView{
            
            ScrollView {
                
                VStack(){
                    
                    /* Para irse a la vista seleccionar foto de perfil */
                   // NavigationLink(destination: SeleccionarFotoPefilView(),isActive: $usuario.usuarioValidado , label: {})
                    
                    //Utilizamos LazyVGrid porque da mayor flexibilidad a la hora de mostrar los componentes
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 88))],
                              spacing: 20) {
                        
                        //Recorremos el array con los componentes que forman el formulario
                        ForEach(formularioContenidoImpl.componenteFormulario) { component in
                            
                            //Seleccionamos los componentes del array
                            switch component {
                                
                                //Nombre, Apellidos y Email
                            case is TextFormComponent:
                                /* textComponent: component as! TextFormComponent indicamos la configuración del componente
                                 as! forzamos la conversión del componente al tipo de componente que deseamos mostrar
                                 .environmentObject(contentBuilder) pasamos la varible de entorno la cual se encargará de saber cuando cambiar la vista y mostra los textos de error */
                                TextFieldFormView(textComponent: component as! TextFormComponent)
                                    .environmentObject(formularioContenidoImpl)
                                
                                //Contraseña
                            case is SecureTextFormComponent:
                                /* textComponent: component as! TextFormComponent indicamos la configuración del componente
                                 as! forzamos la conversión del componente al tipo de componente que deseamos mostrar
                                 .environmentObject(contentBuilder) pasamos la varible de entorno la cual se encargará de saber cuando cambiar la vista y mostra los textos de error */
                                SecureFieldFormView(textComponent: component as! SecureTextFormComponent)
                                    .environmentObject(formularioContenidoImpl)
                                
                                //Fecha de nacimiento
                            case is DateFormComponent:
                                DateFormView(dateComponent: component as! DateFormComponent)
                                    .environmentObject(formularioContenidoImpl)
                                
                                /* !!! Mejorar implementar en FormContentBuilder */
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
                                //Botón
                            case is ButtonFormItem:
                                
                                ButtonFormView(buttonComponent: component as! ButtonFormItem) { id in
                                    
                                    /* La identificación es una enumeración */
                                    switch id {
                                    case .submit:
                                        //Validamos el formulario cuando se pulse el botón
                                        formularioContenidoImpl.validar()
                            
                                    default:
                                        
                                        //Mostrar mensaje que todavái faltar validar campos
                                        break
                                    }
                                }
                                //Sino encuentra ningún elemento mostrará una vista vacía
                            default:
                                EmptyView()
                            }
                            
                        }
                        
                    }
                              .padding(.top, 50)
                }
                .padding(.horizontal, 8)
                //Comprobamos si el estado del formulario ha cambiado, es decir, si es correcto o incorrecto
                .onChange(of: formularioContenidoImpl.estado,
                          perform: { value in
                    
                    switch value {
                        
                    case .validar(let usuario):
                        
                        //No hay errores se puede crear un usuario
                        print("Created new user: \(usuario)")
                        
                    case .error(let message):
                        
                        //Existe algún error
                        print("Failed: \(message)")
                        
                    case .none:
                        //significa que está comprobando
                        break
                    }
                })
                
            }
        }
        .navigationTitle("Registro")
        //Final
    }
    
}

struct FormularioView_Previews: PreviewProvider {
    static var previews: some View {
        FormularioView()
    }
}

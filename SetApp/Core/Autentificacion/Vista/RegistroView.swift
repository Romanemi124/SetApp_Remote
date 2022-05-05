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
    
    //Para elegir la foto de usuario
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State var image: UIImage?
    
    @State private var elegirSexo: Sexo = .hombre
    @State private var fechaNacimiento: Date  = Date()
    /* @Environment(\.presentationMode) Un enlace al modo de presentación de la vista actual asociada con el entorno*/
    //Para poner la vista en modo presentación, esto será util para descartar la vista actual
    @Environment(\.presentationMode) var presentationMode
    //Variable que guarda los datos para registrar
    @EnvironmentObject var vistaModelo: AutentificacionModelView
    
    /* Variable en la cual llamaremos a los componenentes para que se representen en la vista y además se pasarán los datos para hacer sus validaciones correspondientes */
    @StateObject private var formularioContenidoImpl = ContenidoFormularioImpl()
    
    /* Variables para la gestión de las alert */
    //Controla que se muestre o no el alert
    @State var showAlert: Bool =  false
    //Elegir el tipo de alert que se va a mostrar
    @State var alertType: TipoAlert? = nil
    //Seleccionamos el tipo de error si lo hay
    @State var tipoError: TipoError = .validaciones
    
    //Usuario resultado de la validación
    @State private var usuarioValidadoCorrectamente: UsuarioRegistro = UsuarioRegistro(nombreCompleto: "", nombreUsuario: "", sexo: "", fechaNacimiento: "", email: "", password: "")
    
    /* Variables que guardan si existe el usario o no a registrar */
    @State var noExisteEmail = false
    @State var noExisteNombreUsuario = false
    
    var body: some View {
        
        //Diseño de la vista principal de la app
        ZStack {
            
            //Imagen de fondo de la vista
            EstablecerFondoPrincipal()
            
            VStack{
                
                CabeceraAutentificacionView(titulo1: "Crear cuenta", titulo2:"Únete ahora")
                
                ScrollView {
                    
                    VStack{
                        
                        Image(uiImage: image ?? UIImage(named: "user")!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                            .padding(.top, 10)
                        
                        HStack {
                            
                            //En este caso se va a redirigir a la cámara para poder tomar una foto y publicarla
                            Button("Elegir foto") {
                                self.showSheet = true
                            }.padding()
                                .actionSheet(isPresented: $showSheet) {
                                    ActionSheet(title: Text("Selecciona una opción"),
                                        buttons: [
                                            .default(Text("Galería")) {
                                                self.showImagePicker = true
                                                self.sourceType = .photoLibrary
                                            },
                                            .cancel()
                                        ])
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(20)
                            
                        }
                        .padding(.bottom, 20)
                        .sheet(isPresented: $showImagePicker) {
                            SeleccionarFoto(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
                        }
                        
                        //Utilizamos LazyVGrid porque da mayor flexibilidad a la hora de mostrar los componentes
                        LazyVGrid(columns: [GridItem(.flexible(minimum: 50))],  spacing: 20) {
                            
                            //Recorremos el array con los componentes que forman el formulario
                            ForEach(formularioContenidoImpl.contenidoFormulario) { component in
                                
                                //Seleccionamos los componentes del array
                                switch component {
                                    
                                    //Nombre, Apellidos y Email
                                case is TextFormComponent:
                                    /* textComponent: component as! TextFormComponent indicamos la configuración del componente
                                     as! forzamos la conversión del componente al tipo de componente que deseamos mostrar
                                     .environmentObject(contentBuilder) pasamos la varible de entorno la cual se encargará de saber cuando cambiar la vista y mostra los textos de error */
                                    TextFieldFormView(textComponent: component as! TextFormComponent)
                                        .environmentObject(formularioContenidoImpl).foregroundColor(.white)
                                    
                                    //Contraseña
                                case is SecureTextFormComponent:
                                    /* textComponent: component as! TextFormComponent indicamos la configuración del componente
                                     as! forzamos la conversión del componente al tipo de componente que deseamos mostrar
                                     .environmentObject(contentBuilder) pasamos la varible de entorno la cual se encargará de saber cuando cambiar la vista y mostra los textos de error */
                                    SecureFieldFormView(textComponent: component as! SecureTextFormComponent)
                                        .environmentObject(formularioContenidoImpl).foregroundColor(.white)
                                    
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
                                            .padding(.leading,-43)
                                    }
                                    //Botón para registrarse
                                case is ButtonFormItem:
                                    
                                    ButtonFormView(buttonComponent: component as! ButtonFormItem) { id in
                                        
                                        /* La identificación es una enumeración */
                                        switch id {
                                            
                                        case .submit:
                                            
                                            //Validamos el formulario cuando se pulse el botón
                                            formularioContenidoImpl.validacion()
                                            
                                            print(".submit self.noExisteEmail \(self.noExisteEmail)")
                                            print(".submit self.noExisteNombreUsuario \(self.noExisteNombreUsuario)")
                                            print(".submit formularioContenidoImpl.esValido \(formularioContenidoImpl.esValido)")
                                            
                                            /* Validamos que no existe el mismo email ni el nombre de usuario */
                                            //Solo cuando el usuario esté validado
                                            if formularioContenidoImpl.esValido == true {
                                                
                                                if self.noExisteEmail && self.noExisteNombreUsuario{
                                                    
                                                    //Indicamos que el tipo de alert
                                                    alertType = .sucess
                                                    //Mostramos el alert
                                                    showAlert.toggle()
                                                    
                                                }else{
                                                    if !self.noExisteEmail && self.noExisteNombreUsuario{
                                                        tipoError = .mismoEmail
                                                        mostrarError ()
                                                    }
                                                    if self.noExisteEmail && !self.noExisteNombreUsuario{
                                                        tipoError = .mismoNombreUsuario
                                                        mostrarError ()
                                                    }
                                                    if !self.noExisteEmail && !self.noExisteNombreUsuario{
                                                        tipoError = .mismoEmailYNombreUsuario
                                                        mostrarError ()
                                                    }
                                                }
                                            }
                                            
                                        default:
                                            break
                                            
                                            //Fin switch id
                                        }
                                        //Fin ButtonFormView
                                    }
                                    
                                    //Sino encuentra ningún elemento mostrará una vista vacía
                                default:
                                    EmptyView()
                                    
                                }
                                
                                //Fin ForEach
                            }
                            .padding(.horizontal)
                            //Fin LazySatack
                        }
                        //.padding(.top, -530)
                        
                        //Fin Vstack 2
                    }
                    .padding(.horizontal, 8)
                    /* SOLO CUANDO HAY CAMBIOS */
                    //Comprobamos si el estado del formulario ha cambiado, es decir, si es correcto o incorrecto
                    .onChange(of: formularioContenidoImpl.estado,
                              perform: { value in
                        
                        switch value {
                            
                        case .validar(let usuarioValidado):
                            
                            //No hay errores se puede crear un usuario
                            print("Usuario creado:  \(usuarioValidado)")
                            
                            //Igualamos los datos del usuario que se ha validado correctamente
                            usuarioValidadoCorrectamente = usuarioValidado
                            
                            print("Email\(usuarioValidadoCorrectamente.email)")
                            print("Nombre de usuario\(usuarioValidadoCorrectamente.nombreUsuario)")
                            
                            //Cuando el usuario aha validado correctamente los datos del registro buscará en la base de datos si el nombre de usiario y el email están repetidos
                            formularioContenidoImpl.esValido = true
                            
                            //1º. Buscar email
                            vistaModelo.buscarEmail(withEmail: usuarioValidadoCorrectamente.email){ resultado in
                                
                                if(resultado == true){
                                    print("Ya existe ese email")
                                    self.noExisteEmail = false
                                }else{
                                    print("No existe ese nombreUsuario")
                                    self.noExisteEmail = true
                                }
                            }
                            
                            //2º Buscar nombre usuario
                            vistaModelo.buscarNombreUsuario(withNombreUsuario: usuarioValidadoCorrectamente.nombreUsuario){ resultado in
                                if(resultado == true){
                                    print("Ya existe ese nombreUsuario")
                                    self.noExisteNombreUsuario = false
                                }else{
                                    print("No existe ese nombreUsuario")
                                    self.noExisteNombreUsuario = true
                                }
                            }
                            
                            break
                            
                        case .error(let message):
                            //Existe algún error
                            print("Failed: \(message)")
                            //En el caso que haya error con las validaciones
                            tipoError = .validaciones
                            mostrarError ()
                            //Cuando ocuura errores del tipo vlaidación de dato no se mostrá alert de busqueda en la base de datos
                            formularioContenidoImpl.esValido = false
                            break
                            
                        case .none:
                            break
                        }
                })
                }
                
                //Link para ir a la vista iniciar sesión
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
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 32)
                .padding(.top, 40)
                .foregroundColor(Color(.white))
                //Fin Vstack 1
            }
            
            // Fin ZStack
        }
        .alert (isPresented: $showAlert, content: {
            getAlert(tipoError: tipoError)
        })
        
        //Fin RegistroView
    }
    
    /* --- Funciones Alert --- */
    
    /* Mostrar alert */
    func getAlert(tipoError:TipoError)-> Alert{
        
        /* Devolverá el alert personlizado con el valor de las variables */
        /* Con este swith personalizamos los mensajes de alrt que nos mostrará */
        switch alertType{
            
        case .error:
            
            switch tipoError {
                
            case .validaciones:
                return Alert(title: Text("Error en las validaciones, revisa los campos"))
                
            case .mismoNombreUsuario:
                return Alert(title: Text("Error ya existe un usuario con ese nombre de usuario, introduce uno distinto"))
                
            case .mismoEmail:
                return Alert(title: Text("Error ya existe un usuario con ese email, introduce uno distinto"))
                
            case .mismoEmailYNombreUsuario:
                return Alert(title: Text("Error ya existe un usuario con ese nombre de usuario y email, introduce unos distintos"))
                
            }
            
        case .sucess:
            
            return Alert(title: Text("Usuario registrado correctamente"), message: nil, dismissButton: .default(Text("Ok"), action: {
                
                /* Guardamos los datos del usuario validado para que en la siguiente vista al finalizar el registro se guarde esos datos, depués de pulsar en el botón nos dirige a seleccionar la imagen de perfil*/
                vistaModelo.guardarDatosPersonales(withUsuarioRegistro: usuarioValidadoCorrectamente.nombreCompleto, nombreUsuario: usuarioValidadoCorrectamente.nombreUsuario, sexo: elegirSexo.sexo, fechaNacimiento: ParsearFecha.asString(fecha: fechaNacimiento), email: usuarioValidadoCorrectamente.email, password: usuarioValidadoCorrectamente.password)
                
            }))
            
            //Cuando no inicializamos el alert nos mostrrá este por defecto
        default:
            return Alert(title: Text("Error"))
        }
        
    }
    
    /* Mostramos el alert de error */
    func mostrarError ()-> Void{
        //Seleccionar el tipo de alert
        alertType = .error
        //Mostrar el alert
        showAlert.toggle()
    }
    
    // Fin RegistroView
}

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView()
    }
}

//
//  RegistroView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
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
    
    @State private var userName : String = ""
    @State private var elegirSexo: Sexo = .hombre
    @State private var fechaNacimiento: Date  = Date()
    @State private var email : String = ""
    @State private var password : String = ""
    //Elegir imagen de perfil
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType:UIImagePickerController.SourceType = .photoLibrary
    
    //Guardar información del estado de autentificación del usuario
    @EnvironmentObject var estadoUsuario: EstadoAutentificacionUsuario
    //Acceder a validar los campos de entrada
    @State var usuarioValidacion: Validacion = Validacion()
    
    /* Manejo de errores */
    //Mostrar o no los errores
    @State private var showError = false
    //Cadena con el error a mostrar
    @State private var errorString = ""
    
    //Para irse a la vista iniciar sesión
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            
            //Imagen de fondo de la vista
            EstablecerFondoPrincipal()
            
            ScrollView{
                
                VStack {
                    
                    //Imagen
                    /*------------------------------------*/
                    VStack{
                        
                        Text("Crear cuenta")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(10)
                        
                        if profileImage != nil {
                            profileImage!.resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 190)
                                .padding(.top, 10)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }else{
                            
                            Image("FotoPerfil")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(.white))
                                .clipShape(Circle())
                                .frame(width: 200, height: 190)
                                .padding(.top, 10)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }
                        //Errores imagen foto de perfil
                        Text(usuarioValidacion.validaFotoPerfil).font(.caption).foregroundColor(.red).padding(.horizontal,40)
                        
                    }.padding(.bottom, 10)
                    
                    // Nombre completo y Nombre de usuario
                    /*------------------------------------*/
                    Group{
                        
                        //Nombre completo
                        VStack(alignment: .leading) {
                            
                            CamposEntrada(placeholder: "Nombre completo", isSecureField: false, text: self.$usuarioValidacion.nombreCompleto)
                            
                            //Validación
                            if !usuarioValidacion.nombreCompleto.isEmpty {
                                Text(usuarioValidacion.validoTextoNombreCompleto).font(.caption).foregroundColor(.red).padding(.horizontal,40)
                            }
                        }
                        
                        //Nombre de usuario
                        VStack(alignment: .leading) {
                            
                            CamposEntrada(placeholder: "Nombre de usuario", isSecureField: false, text: self.$usuarioValidacion.nombreUsuario)
                            
                            if !usuarioValidacion.nombreUsuario.isEmpty {
                                Text(usuarioValidacion.validoTextoNombreUsuario).font(.caption).foregroundColor(.red).padding(.horizontal,40)
                            }
                        }
                    }
                    
                    //Email, contraseña y confirmar Contraseña
                    /*------------------------------------*/
                    Group{
                        //Email
                        VStack(alignment: .leading) {
                            
                            CamposEntrada(placeholder: "Email", isSecureField: false, text: self.$usuarioValidacion.email)
                            
                            if !usuarioValidacion.email.isEmpty {
                                Text(usuarioValidacion.validoTextoEmail).font(.caption).foregroundColor(.red).padding(.horizontal,40)
                            }
                            
                        }
                        //Contraseña
                        VStack(alignment: .leading) {
                            
                            CamposEntrada(placeholder: "Contraseña", isSecureField: true, text: self.$usuarioValidacion.password)
                            
                            if !usuarioValidacion.password.isEmpty {
                                Text(usuarioValidacion.validoTextoPassword).font(.caption).foregroundColor(.red).padding(.horizontal,40)
                            }
                            
                        }
                        //Confirmar Contraseña
                        VStack(alignment: .leading) {
                            
                            CamposEntrada(placeholder: "Confirmar contraseña", isSecureField: true, text: self.$usuarioValidacion.confirmarPassword)
                            
                            if !usuarioValidacion.passwordsCoinciden(_coincidenPw: usuarioValidacion.confirmarPassword) {
                                Text(usuarioValidacion.validoTextoConfirmarPassword).font(.caption).foregroundColor(.red).padding(.horizontal,40)
                            }
                        }
                    }
                    
                    //Sexo y Fecha de nacimiento
                    /*------------------------------------*/
                    Group{
                        //Sexo
                        VStack(alignment: .leading) {
                            
                            HStack(spacing:160){
                                
                                Text("Seleccionar tu sexo:").foregroundColor(Color.white)
                                
                                //Elegir el sexo
                                Picker(selection: $elegirSexo, label: Text("")) {
                                    ForEach(Sexo.allCases, id: \.self) { sexo in
                                        Text(sexo.sexo)
                                    }
                                }.labelsHidden()
                                    .padding(.leading,-100)
                            }
                        }
                        //Fecha de nacimiento
                        VStack(alignment: .leading){
                            
                            HStack{
                                Text("Introduce tu edad:").foregroundColor(.white)
                                
                                //Edad
                                DatePicker(selection: self.$usuarioValidacion.fechaNacimiento, displayedComponents: .date){
                                }
                                .padding(10)
                                .padding(.trailing, 28)
                                .colorInvert()
                                .colorMultiply(Color.blue)
                            }
                            //Texto que muestra los errores
                            Text(usuarioValidacion.validaEdad).font(.caption).foregroundColor(.red)
                            
                        }.padding(.horizontal,50)
                    }
                    
                    /* Botón de registrarse */
                    /*------------------------------------*/
                    Button(action: {
                        
                        /* Buscamos si el nombre de usuario introducido ya existe */
                        Autentificacion.buscarNombreUsuario(withNombreUsuario:  self.usuarioValidacion.nombreUsuario){ (restult) in
                            
                            // Mostramos los resultados de la busqueda
                            switch restult {
                                
                                //En caso de error o que no haya encontrado
                            case .failure(let error):
                                //Mostramos el error
                                self.errorString = error.localizedDescription
                                self.showError = true
                                
                                //En caso de que se no lo haya encontrado
                            case .success(true):
                                self.errorString = "El nombre de usuario introducido ya existe, añade otro"
                                //Mostramos el error
                                self.showError = true
                                
                                //En caso de que lo haya encontrado
                            case .success(false):
                                
                                /* Crear el usuario, junto con el tratamiento de los posibles errores */
                                Autentificacion.crearUsuario(nombreCompleto: self.usuarioValidacion.nombreCompleto, nombreUsuario: self.usuarioValidacion.nombreUsuario, email: self.usuarioValidacion.email, password: self.usuarioValidacion.password, sexo: elegirSexo.sexo, fechaNacimiento: ParsearFecha.asString(fecha: self.usuarioValidacion.fechaNacimiento), imageData: self.usuarioValidacion.fotoPerfil){ (restult) in
                                    
                                    // Mostramos los resultados del registro
                                    switch restult {
                                        
                                        //En caso de error
                                    case .failure(let error):
                                        
                                        /* !!! Futuro personalizar los errores */
                                        //Elegimos el texto de error a mostrar, controlamos el tipo de error
                                        switch error.localizedDescription{
                                            //En caso que el ya exista el email introducido
                                        case  "The email address is already in use by another account.":
                                            self.errorString = "La dirección de correo electrónico introducida ya existe"
                                            break
                                            //Mostramos cualquier tipo de error sucedido
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
                            }
                        }
                        
                    }) {
                        PrimaryButton(title: "Registrarse")
                        //La opacidad se modifica según la validación de los campos
                            .opacity(usuarioValidacion.estaRegistrarseCompletado ? 1 : 0.50)
                    }
                    //Desabilitaremos el botón si la validación no es correcta
                    .disabled(!usuarioValidacion.estaRegistrarseCompletado)
                    .padding(.top, 30)
                    
                    //Regresar vista IniciarSesion
                    /*------------------------------------*/
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
                    
                }
                .padding(.top)
                .accentColor(.white)
                
                //El alert de la vista, servirá para mostrar errores
                /*------------------------------------*/
                    .alert(isPresented: $showError) {
                        //El alert que se va mostrar
                        Alert(title: Text("Error al crear cuenta"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
                    }
                    .navigationBarTitle("Registrar", displayMode: .inline)
                
                /* Para cargar la imagen */
                /*------------------------------------*/
            }.sheet(isPresented: $showingImagePicker, onDismiss: cargarImagen){
                
                //Selección de la foto
                ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$usuarioValidacion.fotoPerfil)
                
            }.actionSheet(isPresented: $showingActionSheet){
                //Menu elegir la foto de perfil
                ActionSheet(title: Text("Notificación"),
                            buttons: [.default(Text("Seleccionar Imagen")){
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },.cancel()])
                
            }
        }
        .accentColor(.white)
    }
    
    //Cargar Imagen
    func cargarImagen(){
        guard let inputImage = pickedImage else {return}
        self.profileImage = inputImage
    }
    
}

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView()
    }
}

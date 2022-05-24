//
//  EditarPerfilView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 14/5/22.
//

import SwiftUI
import Kingfisher

struct EditarPerfilView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    //Guardar información del estado de autentificación del usuario
    @EnvironmentObject var estadoUsuario: EstadoAutentificacionUsuario
    
    //Elegir imagen de perfil
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType:UIImagePickerController.SourceType = .photoLibrary
    
    /* Manejo de errores */
    //Mostrar o no los errores
    @State private var showError = false
    //Cadena con el error a mostrar
    @State private var errorString = ""
    
    //Para irse a la vista iniciar sesión
    @Environment(\.presentationMode) var presentationMode
    
    /* Validaciones de los campos a modificar */
    @State private var nombreCompleto: String = ""
    @State private var fechaNacimiento: Date  = Date()
    //Guardar el sexo del usuario que ha iniciado sesión
    @State private var sexoUsuario: String = ""
    @State private var fotoPerfil: Data = Data()
    //Objecto validador
    @State var validacionEditarPerfil: ValidacionEditarPerfil = ValidacionEditarPerfil()
    
    //Array de las opciones para elegir el sexo
    @State var sexoOrden = [""]
    //Iterador del array
    @State private var seleccionarSexo = 0
    
    //Inicilizamos la clase con el objeto usuario que pasamos por parámetro
    init(user: UsuarioFireBase?) {
        //Inicializamos los valores de las variables de la clase según el usuario que ha iniciado sesión
        _nombreCompleto = State(initialValue: user?.nombreCompleto ?? "")
        /* ParsearFecha.asDate(fecha: user!.fechaNacimiento) pasamos de String a Date para mostrar la fecha en el DatePicker */
        _fechaNacimiento = State(initialValue: ParsearFecha.asDate(fecha: user!.fechaNacimiento)!)
        _sexoUsuario = State(initialValue: user?.sexo ?? "")
        /* validacionEditarPerfil.sexoPredeterminado(sexoUsuario: sexoUsuario) nos devuelve un array poniendo como opción predeterminada el sexo del usuario que ha iniciado sesión, para mostrarlo en el Picker */
        _sexoOrden = State(initialValue: validacionEditarPerfil.sexoPredeterminado(sexoUsuario: sexoUsuario))
    }
    
    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
            
            //Mostramos la vista deseada
            ZStack {
                
                //Imagen de fondo de la vista
                EstablecerFondoPrincipal()
                
                VStack {
                  
                    //Título
                    /*------------------------------------*/
                    Text("editar-titulo")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(x: 35).padding(.top,-30).padding(.horizontal, 100)
                    
                    //Imagen
                    /*------------------------------------*/
                    VStack{
                        
                        if profileImage != nil {
                            
                            profileImage!.resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 190)
                                .padding(.top, 20)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }else{
                            
                            //Imagen del usuario que ha iniciado sesión
                            KFImage(URL(string: estadoUsuario.usuario.urlImagenPerfil))
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 200, height: 190)
                                .padding(.top, 20)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }
                        
                    }.padding(.bottom, 10)
                    
                    // Nombre completo y Nombre de usuario
                    /*------------------------------------*/
                    Group{
                        
                        //Nombre completo
                        VStack(alignment: .leading) {
                            
                            CamposEntrada(placeholder: "editar-nombreCompleto", text: self.$nombreCompleto)
                            //Validacion de errores
                            ValidacionError(textStart: nombreCompleto, textError: validacionEditarPerfil.validarTextoNombreCompleto(nombreCompleto2: nombreCompleto))
                        }
                        
                        //Nombre de usuario
                        VStack(alignment: .leading){
                            CamposEntradaMostrar(placeholder: "editar-nombreUsuario", text: estadoUsuario.usuario.nombreUsuario, paddingLeading: -170, paddingHorizontal: 170)
                        }
                    }
                    
                    //Email
                    /*------------------------------------*/
                    Group{
                        //Email
                        VStack{
                            CamposEntradaMostrar(placeholder: "Email:", text: estadoUsuario.usuario.email,paddingLeading: -170,paddingHorizontal: 170)
                        }
                    }.padding(.bottom, 10)
                    
                    //Sexo y Fecha de nacimiento
                    /*------------------------------------*/
                    Group{
                        
                        //Sexo
                        VStack(alignment: .leading) {
                            HStack(spacing:180){
                                Text("editar-sexo-elegir").foregroundColor(Color.white)
                                Picker("", selection: $seleccionarSexo, content: {
                                    ForEach(0..<sexoOrden.count, content: { index in
                                        
                                        //Evaluamos las opciones del sexo y mostramos el sexo elegido con LocalizedStringKey para luego su posible traducción
                                        if sexoOrden[index] == "Hombre"{
                                            
                                            Text(LocalizedStringKey("registrarCuenta-sexo_hombre"))
                                            
                                        }else if(sexoOrden[index] == "Mujer"){
                                            
                                            Text(LocalizedStringKey("registrarCuenta-sexo_mujer"))
                                            
                                        }else if(sexoOrden[index] == "Otro"){
                                            
                                            Text(LocalizedStringKey("registrarCuenta-sexo_otro"))
                                        }
                                        
                                    })
                                }) .padding(.leading,-100)
                            }
                        }.padding(.horizontal,40)
                       
                        
                        //Fecha de nacimiento
                        VStack(alignment: .leading){
                            
                            HStack{
                                Text("editar-edad-elegir").foregroundColor(.white)
                                //Edad
                                DatePicker(selection: self.$fechaNacimiento, displayedComponents: .date){
                                }
                                .padding(10)
                                .padding(.trailing, 28)
                                .colorInvert()
                                .colorMultiply(Color.blue)
                            }
                            //Texto que muestra los errores
                            Text(validacionEditarPerfil.validarTextoFechaNacimiento(fechaNacimiento2: fechaNacimiento)).font(.caption).foregroundColor(.red)
                            
                        }.padding(.horizontal,70)
                    }
                    
                    /* Botón de registrarse */
                    /*------------------------------------*/
                    Button(action: {
                        
                        print("Actualizando datos ...")
                        
                        //En el caso que haya cambiado de foto de perfil
                        if profileImage != nil{
                            
                            //sexoOrden[seleccionarSexo] guardamos el sexo que ha elegido el usuario
                            Autentificacion.modificarUsuario(id: estadoUsuario.usuario.id!, nombreCompleto: nombreCompleto, sexo: sexoOrden[seleccionarSexo], fechaNacimiento: ParsearFecha.asString(fecha: fechaNacimiento), imageData: fotoPerfil){ (restult) in
                                
                                switch restult {
                                    //En caso de error
                                case .failure(let error):
                                    self.errorString = error.localizedDescription
                                    //Mostramos el error
                                    self.showError = true
                                case .success( _):
                                    
                                    print("modificarUsuario con imagen")
                                    //Vista de cargar, para que se cargue los datos actualizados
                                    //Cambiamos el valor de la variable para que vuelva a la anterior vista
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                            
                        }else{
                            
                            //Sino ha cambiado de foto de perfil
                            Autentificacion.modificarUsuarioSinImagen(id: estadoUsuario.usuario.id!, nombreCompleto: nombreCompleto, sexo: sexoOrden[seleccionarSexo], fechaNacimiento: ParsearFecha.asString(fecha: fechaNacimiento)){ (restult) in
                                switch restult {
                                    //En caso de error
                                case .failure(let error):
                                    self.errorString = error.localizedDescription
                                    //Mostramos el error
                                    self.showError = true
                                case .success( _):
                                    print("modificarUsuario sin imagen")
                                    //Vista de cargar, para que se cargue los datos actualizados
                                    //Cambiamos el valor de la variable para que vuelva a la anterior vista
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                            
                        }
                        
                    }) {
                        PrimaryButton(title: "editar-boton")
                        //La opacidad se modifica según la validación de los campos
                            .opacity(validacionEditarPerfil.actualizarPerfil(nombreCompleto2: nombreCompleto, fechaNacimiento2: fechaNacimiento) ? 1 : 0.50)
                    }
                    //Desabilitaremos el botón si la validación no es correcta
                    .disabled(!validacionEditarPerfil.actualizarPerfil(nombreCompleto2: nombreCompleto, fechaNacimiento2: fechaNacimiento))
                    .padding(.top, 30)
                    
                }
                .padding(.top)
                .accentColor(.white)
                
                //El alert de la vista, servirá para mostrar errores
                /*------------------------------------*/
                .alert(isPresented: $showError) {
                    //El alert que se va mostrar
                    Alert(title: Text("Error al crear cuenta"), message: Text(self.errorString), dismissButton: .default(Text("OK")))
                }
                
                /* Para cargar la imagen */
                /*------------------------------------*/
            }.sheet(isPresented: $showingImagePicker, onDismiss: cargarImagen){
                
                //Selección de la foto
                ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$fotoPerfil)
                
            }.actionSheet(isPresented: $showingActionSheet){
                //Menu elegir la foto de perfil
                ActionSheet(title: Text(LocalizedStringKey("registrarCuenta-notificacion")),
                            buttons: [.default(Text(LocalizedStringKey("registrarCuenta-notificacion-camara"))){
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },.cancel()])
                
            }.accentColor(.white)
            
        }
        
    }
    
    //Cargar Imagen
    func cargarImagen(){
        guard let inputImage = pickedImage else {return}
        self.profileImage = inputImage
    }
    
}

struct EditarPerfilView_Previews: PreviewProvider {
    static var previews: some View {
        EditarPerfilView(user: UsuarioFireBase(id: NSUUID().uuidString, nombreCompleto: "j", nombreUsuario: "j", email: "j", sexo: "j", fechaNacimiento: "j", urlImagenPerfil: "j"))
    }
}

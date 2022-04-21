//
//  EditPerfilView.swift
//  SetApp
//
//  Created by Emilio Roman on 15/4/22.
//

import SwiftUI
import Kingfisher

struct EditPerfilView: View {
    
    //Para la modificación de los datos del usuario
    @State private var elegirSexo: Sexo = .hombre
    @State private var nombreCompleto: String = ""
    @State private var nombreUsuario: String = ""
    @State private var sexo: String = ""
    @State private var fechaNacimiento: Date  = Date()
    @State private var email: String = ""
    @State private var password: String = ""
    
    //Varibale necesario para la animación
    @Namespace var animation
    @Environment(\.presentationMode) var mode
    //Creamos el objeto usuario que luego se va mostrar sus datos
    private let usuario:Usuario
    
    //Inicializamos el usuario
    init(usuario: Usuario){
        self.usuario = usuario
    }
    
    var body: some View {
        
        ZStack {
            
            Color(red: 0.113, green: 0.031, blue: 0.16)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                
                //Parte superior de la vista
                /* Al llamar a esta variable mostramos la parte de la vista guarda en ella */
                headerView
                    .padding(.bottom, 10)
                
                //Información del usuario
                editAccount
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct EditPerfilView_Previews: PreviewProvider {
    static var previews: some View {
        EditPerfilView(usuario: Usuario(id: NSUUID().uuidString, nombreUsuario: "", nombreCompleto: "", email: "", sexo: "", fechaNacimiento: "", UrlImagenPerfil: ""))
    }
}

extension EditPerfilView {
    
    //Variable guardará a la parte superior de la vista
    var headerView: some View{
        
        /* ZStack El componente ZStack permite apilar vistas en el eje Z, lo que da resultado que las vistas se solapen una sobre otra
         bottomLeading orientar los elementos abajo y hacia la derecha */
        ZStack(alignment: .bottomLeading){
            //Color de fondo
            Color(red: 0.113, green: 0.031, blue: 0.16)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            HStack(spacing:260) {
                
                Button{
                    //Cambiamos el valor de la variable para que vuelva a la anterior vista
                    mode.wrappedValue.dismiss()
                }label: {
                    
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 25, height: 20)
                        .foregroundColor(.white)
                        .padding(15)
                }
                HStack {
                    
                    //Cuando se pulsa este botón se guardarán todos los datos modificados en la base de datos
                    Button{
                        
                        //función que permitirá hacer la conexión con la base de datos y los cambios se reflejarán
                        saveUser()
                    }label: {
                        
                        Image(systemName: "icloud.and.arrow.up.fill")
                            .resizable()
                            .frame(width: 35, height: 30)
                            .foregroundColor(.white)
                            .padding(15)
                    }
                }
            }
            .padding(.leading)
            .padding(.bottom, 12)
            .padding(.top, 12)

        }
        .frame(height: 30)
    }
    
    var editAccount: some View{
            
        ZStack(alignment: .topLeading) {
            
            Color(red: 0.113, green: 0.031, blue: 0.16)
            //ignoresSafeArea() permite añadir el fondo en la parte superior
                .ignoresSafeArea()
            
            VStack {
                
                //Cabezera principal de la vista de editar perfil
                Text("Editar perfil")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(.bottom, 15)
                    .padding(.top, 25)
                
                //Se carga la imagen que tiene actualmente el usuario, en caso de cambiarlo se muestra en esta parte
                KFImage(URL(string: usuario.UrlImagenPerfil))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                
                //Botón para cambiar la foto de perfil
                Button{
                    //Activar selector de imágenes del dispositivo
                }label: {
                    
                    Text("Cambiar foto del perfil")
                        .foregroundColor(.white)
                }
                .padding(.bottom, 15)
                
                //En este grupo se cargan todos los datos que están guardados en la base de datos, una vez cargados el usuario puede cambiarlos
                Group{
                    
                    CamposEntrada(placeholder: "Nombre", isSecureField: false,text: $nombreCompleto)
                    
                    CamposEntrada(placeholder: "Nombre usuario", isSecureField: false,text: $nombreUsuario)
                    
                    CamposEntrada(placeholder: "Correo electrónico",isSecureField: false, text: $email)
                    
                    //Elegir el sexo del usuario
                    HStack(spacing:150){
                        Text("Seleccionar sexo:").foregroundColor(Color.white)
                        //Elegir el sexo
                        Picker(selection: $elegirSexo, label: Text("")) {
                            ForEach(Sexo.allCases, id: \.self) {
                                sexo in
                                Text(sexo.sexo)
                            }
                        }
                        .labelsHidden()
                    }
    
                    //Se despliega el calendario para modificar la fecha de nacimiento
                    DatePicker(selection: $fechaNacimiento, displayedComponents: .date){
                        
                        Text("Fecha de nacimiento").foregroundColor(Color.white)
                    }
                    .padding(10)
                    .padding(.trailing, 28)
                    .padding(.leading, 28)
                }
            }
        }
    }
    
    func saveUser(){
        print("Usuario Guardado")
    }
}

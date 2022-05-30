//
//  CambiarPasswordView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 10/5/22.
//
import SwiftUI

struct CambiarPasswordView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    @EnvironmentObject var estadoUsuario: EstadoAutentificacionUsuario
    @State var usuarioValidacion: Validacion = Validacion()
    @Environment(\.presentationMode) var presentationMode
    
    /* Variables para la gestión de las alert */
    //Controla que se muestre o no el alert
    @State var showAlert: Bool =  false
    //Elegir el tipo de alert que se va a mostrar
    @State var alertType: TipoAlert? = nil
    //El mesnaje que mostrará en los alert de error
    @State private var errorString: String?
    
    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
        
            //Mostramos la vista deseada
            ZStack{
                
                //Imagen de fondo de la vista
                EstablecerFondoPrincipal()
                
                VStack {
                    
                    //Título
                    /*------------------------------------*/
                    CabeceraAutentificacionView(titulo1: "SetApp", titulo2: "cambiar-password-titulo")
                    
                    Image("SetApp")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.bottom, 60)
                    
                    Spacer()
                    
                    VStack {
                        
                        TextField("cambiar-password", text: $usuarioValidacion.email).autocapitalization(.none).keyboardType(.emailAddress)
                        
                        Button(action: {
                            
                            Autentificacion.cambiarPassword(email:  self.usuarioValidacion.email){ (result) in
                                switch result {
                                case .failure(let error):
                                    //Elegimos el texto de error a mostrar, controlamos el tipo de error
                                    switch error.localizedDescription{
                                        //En caso que el ya exista el email introducido
                                    case ErroresString.ErroresCambiarContraseña.noExisteUsuario:
                                        self.errorString = ErroresString.ErroresCambiarContraseña.noExisteUsuarioTraduccion
                                        //Mostramos cualquier tipo de error sucedido
                                    default:
                                        self.errorString = error.localizedDescription
                                    }
                                    //Seleccionamos el tipo de alert a mostrar
                                    alertType = .error
                                case .success( _):
                                    //Cuando haya cambiado de contraseña se cerrará la sesión
                                    print("Debug: CambiarPassword éxito")
                                    alertType = .sucess
                                }
                                self.showAlert = true
                            }
                        }) {
                            Text("editar-boton")
                                .frame(width: 180)
                                .padding(.vertical, 15)
                                .background(Color(red: 0.331, green: 0.074, blue: 0.423))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                            //.opacity(user.isEmailValid(_email: user.email) ? 1 : 0.75)
                                .opacity(usuarioValidacion.estaValidoEmail(_email: usuarioValidacion.email) ? 1 : 0.75)
                        }
                        .disabled(!usuarioValidacion.estaValidoEmail(_email: usuarioValidacion.email))
                        .padding(.top, 50)
                        Spacer(minLength: 50)
                    }
                        .frame(width: 300)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        //.navigationBarTitle("Volver", displayMode: .inline)
                        .alert(isPresented: $showAlert, content: {
                            getAlert()
                        })
                }
            }
            
        }
        
    }
    
    /* Mostrar alert */
    func getAlert()-> Alert{
        
        /* Devolverá el alert personalizado con el valor de las variables */
        switch alertType{
            
        case .error:
            return Alert(title: Text(LocalizedStringKey("alert-notificacion")), message: Text(LocalizedStringKey(self.errorString!)), dismissButton: .default(Text("Ok"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        case .sucess:
            return Alert(title: Text(LocalizedStringKey("alert-notificacion")), message: Text(LocalizedStringKey("cambiar-password-aceptado")), dismissButton: .default(Text("Ok"), action: {
                Autentificacion.cerrarSesion{ result in
                    print("Cerrando sesión...")
                }
            }))
        default:
            return Alert(title: Text("Error"))
        }
        
    }
}


struct CambiarPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CambiarPasswordView()
    }
}

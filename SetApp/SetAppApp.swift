//
//  SetAppApp.swift
//  SetApp
//
//  Created by Emilio Roman on 3/4/22.
//

import SwiftUI
import Firebase

@main
struct SetAppApp: App {
    
    //Variable de sesión de usuario, la cual será nuestra variable de entorno
    @StateObject var vistaModelo = AutentificacionModelView()

    //Variable para saber el estado de autentificación del usuario
    @StateObject var estadoAutentificacionUsuario = InformacionUsuario()
    
    
    //Cada vez que se cargue la app realizará este método
    /* Realizamos la configuración directamente con este método porque no tenemos otras clases "main" */
    init(){
        
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                //Instanciamos la variable de sesión de usuario
                ContentView().environmentObject(SessionStore())
            }
            //Para que el objeto puede ser leído por cualquier clase inferior
            .environmentObject(vistaModelo)
            .environmentObject(estadoAutentificacionUsuario)
        }
    }
}

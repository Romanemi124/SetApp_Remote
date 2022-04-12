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
    
    //Cada vez que se cargue la app realizará este método
    /* Realizamos la configuración directamente con este método porque no tenemos otras clases "main" */
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                //Instanciamos la variable de sesión de usuario
                ContentView()
            }
            //Para que el objeto puede ser leído por cualquier clase inferior
            .environmentObject(vistaModelo)
        }
    }
}

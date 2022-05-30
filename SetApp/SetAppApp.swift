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

    //Variable para saber el estado de autentificación del usuario
    @StateObject var estadoUsuario = EstadoAutentificacionUsuario()

    //Cada vez que se cargue la app realizará este método
    /* Realizamos la configuración directamente con este método porque no tenemos otras clases "main" */
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            //Para que el objeto puede ser leído por cualquier clase inferior
            .environmentObject(estadoUsuario)
            //.environmentObject(estadoAutentificacionUsuario)
        }
    }
}

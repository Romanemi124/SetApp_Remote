//
//  MainTabView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import SwiftUI

//Esta clase nos servirá de navegador entre clases
struct MainTabView: View {
    
    /* Variable de estado que nos va servir como índice para las vistas en la que se navegue, es decir, que su valor cambiará dependiendo de la vista que se eliga */
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        
        /* TabView es una vista que nos permite tener una barra inferior en nuestra app para poder seleccionar distintas vistas secundarias y así poder navegar entre ellas */
        TabView(selection: $selectedIndex){
            
            //Casa
            FeedView()
            //onTapGesture Agrega una acción para realizar cuando pulsamos en la vista
                .onTapGesture {
                    //
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                    /* .tag Establece un valor único al element, esto nos servirá para poder diferenciar entre ciertas vistas seleccionables */
                }.tag(0)
            
            //Casa
            BuscadorView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            
            //Casa
            NotificacionesView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "bell")
                }.tag(2)
            
            //Casa
            MensajesView()
                .onTapGesture {
                    self.selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "envelope")
                }.tag(3)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

//
//  HomeView2.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import SwiftUI

//Clase principal
struct HomeView2: View {

    @EnvironmentObject var session: SessionStore
    var body: some View {
    
        
        VStack{
            Text("HomeView2")
            Button(action: session.logout) {
                Text("Cerrar sesión").font(.title).modifier(ButtonModifiers())
            }
        }
    }
}

struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2()
    }
}

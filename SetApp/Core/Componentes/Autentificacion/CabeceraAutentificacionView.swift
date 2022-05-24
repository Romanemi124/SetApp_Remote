//
//  AuthenticationHeaderView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 4/4/22.
//

import SwiftUI

struct CabeceraAutentificacionView: View {
    
    let titulo1: String
    let titulo2: String
    
    var body: some View {
        
        Text(LocalizedStringKey(titulo1))
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(x: 35)
        
        Text(LocalizedStringKey(titulo2))
            .font(.title2)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(x: 45)
    }
}

struct CabeceraAutentificacionView_Previews: PreviewProvider {
    static var previews: some View {
        CabeceraAutentificacionView(titulo1: "Hello", titulo2: "Welcome Back")
    }
}

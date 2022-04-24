//
//  SlideMenuItemRowView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 3/4/22.
//

import SwiftUI

struct MenuDeslizanteFilaElementoView: View {
    
    let vistaModelo : MenuDeslizanteModeloView
    
    var body: some View {
            
        HStack(spacing: 16){
            
            //Mostramos la imagen de perfil
            Image(systemName: vistaModelo.imagenNombre)
                .font(.headline)
                .foregroundColor(.white)
            
            //Mostramos las opciones de navegación
            Text(vistaModelo.titulo)
                .foregroundColor(.white)
                .font(.subheadline)
            
            Spacer()
        }
        //Espacio entre elementos
        .frame( height: 40)
        .padding(.horizontal)
    }
    
}

struct MenuDeslizanteFilaElementoView_Previews: PreviewProvider {
    static var previews: some View {
        MenuDeslizanteFilaElementoView(vistaModelo: .perfil)
    }
}

//
//  SearchBar.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 12/5/22.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var value: String
    @State var isSearching = false
    
    var body: some View {
        
        HStack{
            //Campo donde buscaremos los usuarios
            TextField("Buscar usuarios ...", text: $value).padding(.leading, 24)
        }.padding()
            .background(Color(.systemGray5))
            .cornerRadius(6.0)
            .padding(.horizontal)
            //Se activa cuando se pulse en la barra
            .onTapGesture (perform:{
                isSearching = true
            })
            //Fondo barra de navegación
            .overlay(HStack{
                Image(systemName: "magnifyingglass")
                Spacer()
                //Cuando se pulse en la X se borrará el texto escrito
                Button(action: {value = ""}){
                    Image(systemName: "xmark.circle.fill")
                }
              
            }.padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
        
    }
}

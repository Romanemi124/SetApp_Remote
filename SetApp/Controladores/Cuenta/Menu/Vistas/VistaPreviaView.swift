//
//  VistaPreviaView.swift
//  SetApp
//
//  Created by Emilio Roman on 7/4/22.
//

import SwiftUI

 struct VistaPreviaView: View {
    
    @Binding var currentTab: String
    @Binding var showMenu: Bool
     
    var body: some View {
        
        VStack {
            
            //Parte principal de todas las ventanas
            HStack {
                
                //Botón del menú
                Button {
                    
                    withAnimation(.spring()) {
                        showMenu = true
                    }
                } label: {
                    
                    //Iamgen del icono del menú para mostrarlo
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
                //Escondiendo el menú cuando es visible
                .opacity(showMenu ? 0 : 1)
                
                Spacer()
            }
            //Título de la vista
            .overlay(
                
                Text(currentTab)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .opacity(showMenu ? 0 : 1)
            )
            .padding([.horizontal, .top])
            .padding(.bottom, 8)
            .padding(.top, getSafeArea().top)
            
            TabView(selection: $currentTab) {
                
                PerfilView()
                    .tag("Perfil")
                
                Text("Ajustes")
                    .tag("Ajustes")
                
                Text("Código QR")
                    .tag("Código QR")
                
                Text("Pagos")
                    .tag("Pagos")
            }
        }
        .disabled(showMenu)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
        
            //Botón del menú para cerrar el menú
            Button {
                
                withAnimation(.spring()) {
                    showMenu = false
                }
            } label: {
                
                //Iamgen del icono del menú para mostrarlo
                Image(systemName: "xmark")
                    .font(.title.bold())
                    .foregroundColor(.white)
            }
            //Escondiendo el menú cuando es visible
            .opacity(showMenu ? 1 : 0)
            .padding()
            .padding(.top)
            
            ,alignment: .topLeading
        )
        .background(
        
            Color(red: 0.113, green: 0.031, blue: 0.16)
        )
    }
}

struct VistaPreviaView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView()
    }
}

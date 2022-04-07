//
//  MenuCompletoView.swift
//  SetApp
//
//  Created by Emilio Roman on 7/4/22.
//

import SwiftUI

struct MenuCompletoView: View {
    
    @State var currentTab: String = "SetApp"
    @State var showMenu: Bool = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            //Customizar el menú del perfil
            MenuDesplegableView(currentTab: $currentTab)
            
            //Vista previa de las pantallas del menú
            VistaPreviaView(currentTab: $currentTab, showMenu: $showMenu)
                //Borde redondeado
                .cornerRadius(showMenu ? 25 : 0)
                //Movimiento 3D
                .rotation3DEffect(.init(degrees: showMenu ? -15 : 0), axis: (x: 0, y: 1, z: 0), anchor: .trailing)
                //Movimiento menú aparte
                .offset(x: showMenu ? getRect().width / 2 : 0)
                .ignoresSafeArea()
        }
        //Siempre en modo oscuro
        .preferredColorScheme(.dark)
    }
}

//Para mostrar la pantalla seleccionada del menú
extension View {
    
    func getSafeArea()->UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as?
                UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets
        else {
            return .zero
        }

        return safeArea
    }
}

struct MenuCompletoView_Previews: PreviewProvider {
    static var previews: some View {
        MenuCompletoView()
    }
}

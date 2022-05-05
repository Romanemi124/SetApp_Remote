//
//  BuscadorView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 11/4/22.
//

import SwiftUI

struct BuscadorView: View {
    
    /* Variable de entorno para acceder a todos los usarios  */
    @ObservedObject var vistaModelo = BuscadorModeloView()
    
    var body: some View {

        VStack{
            
            //Mostramos el buscador
            BuscadorBar(texto: $vistaModelo.textoBuscar)
                .padding()
            
            ScrollView{
                LazyVStack{
                    ForEach(vistaModelo.searchableUsers){ user in
                        
                        NavigationLink{
                            
                         //ProfileView(user: user)
                            
                        }label: {
                            //UserRowView(user: user)
                        }
                     
                    }
                }
            }
        }
        .navigationTitle("Buscador")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

struct BuscadorView_Previews: PreviewProvider {
    static var previews: some View {
        BuscadorView()
    }
}

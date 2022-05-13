//
//  BuscadorPersona2View.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 13/5/22.
//

import SwiftUI

struct BuscadorPersonaView: View {
    
    /* Variable de entorno para acceder a todos los usarios  */
    @ObservedObject var viewModel = BuscadorModeloView()
    
    
    var body: some View {
        VStack{
            
            //Mostramos el buscador
            SearchBar(value: $viewModel.textoBuscar).padding()
            
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.searchableUsers){ user in
                        
                        NavigationLink{
                            
                        //PerfilView(user: user)
                            
                        }label: {
                            UserRowView(user: user)
                        }
                     
                    }
                }
            }
        }
        .navigationTitle("Buscador")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BuscadorPersonaView_Previews: PreviewProvider {
    static var previews: some View {
        BuscadorPersonaView()
    }
}

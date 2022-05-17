//
//  SearchView.swift
//  SetApp
//
//  Created by Emilio Roman on 15/5/22.
//

import SwiftUI

struct SearchView: View {
    
    var animation: Namespace.ID
    @EnvironmentObject var viewModel: BuscadorModeloView
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack(spacing: 20) {
                
                Button {
                    
                    withAnimation {
                        viewModel.searchActivated = false
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
                HStack(spacing: 15) {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $viewModel.textoBuscar)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                    
                    Button(action: {viewModel.textoBuscar = ""}){
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.05))
                .cornerRadius(15)
                .padding(.horizontal)
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal, .top])
            .padding(.top)
            
            
            //Parte donde se van a mostrar los resultados de búsqueda
            ScrollView{
                
                LazyVStack{
                    
                    ForEach(viewModel.searchableUsers){ user in
                        
                        NavigationLink{
                            
                            //.navigationBarHidden(true) quitamos el link de navegación
                            PerfilUserView(user: user).navigationBarHidden(true)
                            
                        }label: {
                            UserRowView(user: user)
                        }
                     
                    }
                }
            }
            .padding(.top, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
        
            Color(.white)
                .ignoresSafeArea()
        )
    }
}

/*
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
 */

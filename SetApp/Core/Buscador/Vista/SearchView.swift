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
    @State private var followCheck: Bool = false
    
    //de prueba para mostrar la vista del usuario: PROBLEMA
    @State private var showlink = false
    @Environment(\.presentationMode) private var presentation
    
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
                        
                        // PROBLEMA
                        /*
                        Button(action:{
                            self.followPrueba(userid: user.id!)
                            //self.presentation.wrappedValue.dismiss()
                            self.showlink = true
                        }) {
                            UserRowView(user: user)
                                               
                        }
                        .background(NavigationLink("", destination: PerfilUserView(user: user, boolCheck: followCheck).navigationBarHidden(true), isActive: $showlink))
                        */
                        /*
                        NavigationLink(destination: PerfilUserView(user: user, boolCheck: followCheck).onAppear {
                            self.followPrueba(userid: user.id!)
                                    }) {
                                        UserRowView(user: user)
                                    }
                        */
                        NavigationLink{
                            
                            //.navigationBarHidden(true) quitamos el link de navegación
                            PerfilUserView(user: user, boolCheck: followCheck).navigationBarHidden(true)
                            
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
    
    func followPrueba(userid: String) {
        
        PerfilViewModel.followingId(userId: userid).getDocument { (document, error) in
            
            if let doc = document, doc.exists {
                self.followCheck = true
                print("Valor del followCheck en search si existe en switch = \(followCheck)")
                
            } else {
                self.followCheck = false
                print("Valor del followCheck en search si no existe en switch = \(followCheck)")
            }
        }
    }
}

/*
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
 */

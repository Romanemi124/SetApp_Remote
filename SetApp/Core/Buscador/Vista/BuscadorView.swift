//
//  BuscadorView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import SwiftUI
import Foundation

struct BuscadorView: View {
    
    //Para mostrar la barra de búsqueda
    @Namespace var animation
    
    @State var currentIndex: Int = 0
    @State var currentTab: String = "Categorias"
    
    @State var detailCategoria: CategoriasBuscador?
    @State var showDetailView: Bool = false
    @State var currentCardSize: CGSize = .zero
    
    @Environment(\.colorScheme) var scheme
    
    @State var txt = ""
    
    /* Variable de entorno para acceder a todos los usarios  */
    @ObservedObject var viewModel = BuscadorModeloView()
    
    var body: some View {
        
        ZStack {
            
            //Parte donde se establece el fondo de las categorías
            BGView()
            
            VStack {
                
                //Parte donde se encuentra el buscador de las personas
                ZStack {
                    
                    if viewModel.searchActivated {
                        SearchBar()
                    } else {
                        
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                //.frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.searchActivated = true
                    }
                }
                .padding(.top, 20)
                
                //Efecto del carrusel para saleccionar el tipo de categoría
                PostCarrusel(spacing: 20, trailingSpace: 110, index: $currentIndex, items: categorias) { categoria in
                    
                    /*
                     Image(categoria.artwork)
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: 300, height: 500)
                     .cornerRadius(15)
                     */
                    
                    GeometryReader { proxy in
                        
                        let size = proxy.size
                        
                        Image(categoria.artwork)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 290, height: 390)
                            .cornerRadius(15)
                            .onTapGesture {
                                currentCardSize = size
                                detailCategoria = categoria
                                
                                withAnimation(.easeOut) {
                                    showDetailView = true
                                }
                            }
                    }
                    
                }
                .padding(.top, 80)
                .padding(.bottom, 20)
                
                CustomIndicator()
                
                //Parte donde aparecerán algunas de las marcas más famosas
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 15) {
                        
                        ForEach(marcas) { marca in
                            
                            Image(marca.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 120)
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 50)
                
            }
            .overlay {
                
                if let categoria = detailCategoria, showDetailView {
                    
                    CategoriaView()
                }
                
            }
        }
        .overlay(
        
            ZStack {
                
                if viewModel.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(viewModel)
                }
            }
        )
    }
    
    //La barra de búsqueda
    @ViewBuilder
    func SearchBar() -> some View {
        
        HStack(spacing: 15) {
            
            Image(systemName: "magnifyingglass")
                .font(.system(size: 23, weight: .bold))
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color.primary.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal)
    }
    
    //Para saber cuántas categorías hay, cuando se va pasando de una categoría a otra, los círculos de abajo cambian
    @ViewBuilder
    func CustomIndicator() -> some View {
        
        HStack(spacing: 5) {
            
            ForEach(categorias.indices, id: \.self) { index in
                
                Circle()
                    .fill(currentIndex == index ? .blue : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
    
    //Efectos del fondo de la vista con un fondo difuminado y oscuro
    @ViewBuilder
    func BGView() -> some View {
        
        GeometryReader { proxy in
            
            let size = proxy.size
            
            TabView(selection: $currentIndex) {
                
                ForEach(categorias.indices, id: \.self) { index in
                    Image(categorias[index].fondo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            let color: Color = (scheme == .dark ? .black : .white)
            
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
            ], startPoint: .top, endPoint: .bottom)
            
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct BuscadorView_Previews: PreviewProvider {
    static var previews: some View {
        BuscadorView()
    }
}

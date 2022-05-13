//
//  BuscadorView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import SwiftUI

//
//  BuscadorView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 11/4/22.
//

import SwiftUI

struct BuscadorView: View {
    
    @State var currentIndex: Int = 0
    @State var currentTab: String = "Categorias"
    
    @State var detailCategoria: CategoriasBuscador?
    @State var showDetailView: Bool = false
    @State var currentCardSize: CGSize = .zero
    
    @Environment(\.colorScheme) var scheme
    
    /* Variable de entorno para acceder a todos los usarios  */
    @ObservedObject var viewModel = BuscadorModeloView()
    
    var body: some View {
        
        ZStack {
            
            //Parte donde se establece el fondo de las categorías
            BGView()

            VStack {
                
//                VStack{
//
//                    //Mostramos el buscador
//                    BuscadorBar(texto: $viewModel.textoBuscar)
//                        .padding()
//
//                    ScrollView{
//                        LazyVStack{
//                            ForEach(viewModel.searchableUsers){ user in
//
//                                NavigationLink{
//
//
//
//                                }label: {
//                                    UserRowView(user: user)
//                                }
//
//                            }
//                        }
//                    }
//                }
                
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
                            .frame(width: size.width, height: size.height)
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
                .padding(.top, 100)
                
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

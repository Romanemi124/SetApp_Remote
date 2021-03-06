//
//  BuscadorView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import SwiftUI
import Foundation

struct BuscadorView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    //Para mostrar la barra de búsqueda
    @Namespace var animation
    
    @State var currentIndex: Int = 0
    @State var currentTab: String = "Categorias"
    
    @State var detailCategoria: CategoriasBuscador?
    @State var showDetailView: Bool = false
    @State var currentCardSize: CGSize = .zero
    
    @State var detailMarca: MarcasBuscador?
    @State var showMarcaView: Bool = false
    
    @Environment(\.colorScheme) var scheme
    
    @State var txt = "Raton"
    
    /* Variable de entorno para acceder a todos los usarios  */
    @ObservedObject var viewModel = BuscadorModeloView()
    
    //Usuario que a iniciado sesion
    @State var usuario = UsuarioFireBase(id: NSUUID().uuidString, nombreCompleto: "j", nombreUsuario: "j", email: "j", sexo: "j", fechaNacimiento: "j", urlImagenPerfil: "j")
        
    init(usuariofb: UsuarioFireBase){
        _usuario = State(initialValue: usuariofb)
    }

    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
            
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
                           
                            //Borramos el usuario que ha iniciado sesión del buscador para no poder buscar su propia cuenta
                            self.viewModel.usuarios.remove(at: self.viewModel.posicionUsuario(usuario:  self.usuario, arrayUsuarioFireBase: self.viewModel.usuarios)!)
                        }
                    }
                    .padding(.top, 20)
                    
                    //Efecto del carrusel para saleccionar el tipo de categoría
                    PostCarrusel(spacing: 20, trailingSpace: 110, index: $currentIndex, items: categorias) { categoria in
                        
                        //2º opción
                        GeometryReader { proxy in
                            
                            let size = proxy.size
                            
                            Image(categoria.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 270, height: 330)
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
                            
                            NavigationLink {
                                
                                AllCategoriasView()
                            } label: {
                                
                                Image("masCategorias")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 120)
                                    .cornerRadius(15)
                            }
                            
                            ForEach(marcas) { marca in
                                
                                //2º opción
                                Image(marca.artwork)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 120)
                                    .cornerRadius(15)
                                    .onTapGesture {
                                        //currentCardSize = size
                                        detailMarca = marca
                                        
                                        withAnimation(.easeOut) {
                                            showMarcaView = true
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                    .padding(.bottom, 50)
                    
                }
                
                .overlay {
                    
                    if let categoria = detailCategoria, showDetailView {
                        CategoriaView(categoria: categoria.nombreCategoria, categoriaTxt: categoria.nombreCategoria)
                    }
                    
                    if let marca = detailMarca, showMarcaView {
                        MarcaView(marca: marca.nombreMarca, marcaTxt: marca.nombreMarca)
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
            
            Image("fondoBuscador")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .cornerRadius(0)
        }
        .overlay(.ultraThinMaterial)
        .ignoresSafeArea()
    }
}

struct BuscadorView_Previews: PreviewProvider {
    static var previews: some View {
        BuscadorView(usuariofb: UsuarioFireBase(id: NSUUID().uuidString, nombreCompleto: "j", nombreUsuario: "j", email: "j", sexo: "j", fechaNacimiento: "j", urlImagenPerfil: "j") )
        
    }
}

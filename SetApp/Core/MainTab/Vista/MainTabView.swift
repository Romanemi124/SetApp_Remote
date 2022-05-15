//
//  MainTabView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import SwiftUI

//Esta clase nos servirá de navegador entre clases
struct MainTabView: View {
    
    @State var selectedTab: Tab = .home
    @State var color: Color = Color(red: 0.721, green: 0.491, blue: 0.849)
    
    //Para el feed view
    @Namespace var animation
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            //Grupo donde se encuntran las distintas vistas a las que se quiere acceder cuando se selecciona otra opción en la barra de menú
            Group {
                switch selectedTab {
                    
                    //Dependiendo del nombre de la opción accede a una vista u otra
                case .home:
                    FeedView()
                case .buscador:
    
                    BuscadorView()
                case .mensajes:
                    MensajesView()
                case .newPublicacion:
                    PublicacionView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            //Parte donde se pondrán los estilos de la barra de menú
            HStack {
                
                //Recorre la parte donde se encuentran los datos de las opción de la barra
                ForEach(tabItems) { item in

                    //Estilo de los botones donde se encontrarán las opciones
                    Button {
                        
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = item.tab
                            color = item.color
                        }
                    } label: {
                        
                        //Se coloca el icono respectivo a cada opción junto con el estilo
                        VStack(spacing: 0) {
                            Image(systemName: item.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    //En el caso de que la opción haya sido seleccionada tendrá un color diferente al de los que no estén seleccionados
                    .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
                    .blendMode(selectedTab == item.tab ? .overlay : .normal)
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: 70, alignment: .top)
            //Rectángulo donde se agurpan las cuatro opciones de la barra de menú
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34, style: .continuous))
            .background(
                //Fondo del RoundedRectangle
                HStack {
                    if selectedTab == .newPublicacion { Spacer() }
                    if selectedTab == .buscador { Spacer() }
                    if selectedTab == .mensajes {
                        Spacer()
                        Spacer()
                    }
                    
                    //Forma que se muestra para que se vea un círculo a la hora de que alguna opción sea seleccionada
                    Circle().fill(color).frame(width: 80)
                    if selectedTab == .home { Spacer() }
                    if selectedTab == .buscador {
                        Spacer()
                        Spacer()
                    }
                    if selectedTab == .mensajes { Spacer() }
                }
                .padding(.horizontal, 15)
            )
            .overlay(
                
                //Parte de cada una de  las opciones donde se pondrán los estilos
                HStack {
                    if selectedTab == .newPublicacion { Spacer() }
                    if selectedTab == .buscador { Spacer() }
                    if selectedTab == .mensajes {
                        Spacer()
                        Spacer()
                    }
                    //Rectángulo donde están cada una de las opciones para darle el color y tamaño deseado
                    Rectangle()
                        .fill(color)
                        .frame(width: 50, height: 5)
                        .cornerRadius(3)
                        .frame(width: 88)
                        .frame(maxHeight: .infinity, alignment: .top)
                    if selectedTab == .home { Spacer() }
                    if selectedTab == .buscador {
                        Spacer()
                        Spacer()
                    }
                    if selectedTab == .mensajes { Spacer() }
                }
                .padding(.horizontal, 8)
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

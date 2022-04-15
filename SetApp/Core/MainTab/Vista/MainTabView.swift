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
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Group {
                switch selectedTab {
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
            
            HStack {
                
                ForEach(tabItems) { item in

                    Button {
                        
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = item.tab
                            color = item.color
                        }
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: item.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
                    .blendMode(selectedTab == item.tab ? .overlay : .normal)
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: 88, alignment: .top)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34, style: .continuous))
            .background(
                HStack {
                    if selectedTab == .newPublicacion { Spacer() }
                    if selectedTab == .buscador { Spacer() }
                    if selectedTab == .mensajes {
                        Spacer()
                        Spacer()
                    }
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
                HStack {
                    if selectedTab == .newPublicacion { Spacer() }
                    if selectedTab == .buscador { Spacer() }
                    if selectedTab == .mensajes {
                        Spacer()
                        Spacer()
                    }
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

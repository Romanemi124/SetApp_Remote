//
//  Tab.swift
//  SetApp
//
//  Created by Emilio Roman on 15/4/22.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(icon: "house", tab: .home, color: Color(red: 0.721, green: 0.491, blue: 0.849)),
    TabItem(icon: "magnifyingglass", tab: .buscador, color: Color(red: 0.721, green: 0.491, blue: 0.849)),
    TabItem(icon: "captions.bubble", tab: .mensajes, color: Color(red: 0.721, green: 0.491, blue: 0.849)),
    TabItem(icon: "plus.square", tab: .newPublicacion, color: Color(red: 0.721, green: 0.491, blue: 0.849))
]

enum Tab: String {
    case home
    case buscador
    case mensajes
    case newPublicacion
}

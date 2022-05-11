//
//  ArrayPost.swift
//  SetApp
//
//  Created by Emilio Roman on 5/5/22.
//

import Foundation
import SwiftUI

//Array de prueba para ver las publicaciones reflejadas en el feedView
struct ArrayPost: Identifiable {
    
    var id = UUID().uuidString
    var title: String
    var category: String
    var overlay: String
    var contentImage: String
    var logo: String
}

var items = [
    
    ArrayPost(title: "LG UltraGear", category: "monitor", overlay: "LG", contentImage: "monitor", logo: "publi"),
    
    ArrayPost(title: "Razer Iksur", category: "teclado", overlay: "LG", contentImage: "teclado", logo: "publi")
]

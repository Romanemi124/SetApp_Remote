//
//  PublicacionItem.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import Foundation
import SwiftUI
import Kingfisher
 
//Esta es la estructura que va a tener la publicación y se cargará en la vista FeedView para ver todas las publicaciones de las personas que sigue
struct PublicationItem: View {
    
    var body: some View {
        
        ZStack {
            
            FondoPantallasApp()
        }
    }
}
 
struct PublicationItem_Previews: PreviewProvider {
    static var previews: some View {
        PublicationItem()
    }
}


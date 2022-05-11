//
//  PublicationCategoria.swift
//  SetApp
//
//  Created by Emilio Roman on 9/5/22.
//

import Foundation
import SwiftUI

struct PublicationCategoria: View {
    
    var post: PostPrueba
    
    var body: some View {
        
        Image(post.imageURL)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}

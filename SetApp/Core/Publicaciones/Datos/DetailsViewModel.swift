//
//  DetailsViewModel.swift
//  SetApp
//
//  Created by Emilio Roman on 6/5/22.
//

import SwiftUI


//Clase necesaria para pasar los datos de una publicación de una vista a otra
class DetailsViewModel: ObservableObject {
    
    //Se especifican todas las características que tiene una publicación para poder usar todos sus atributos en la otra vista
    @Published var selectedPost = ArrayPost(title: "", category: "", overlay: "", contentImage: "", logo: "")
    
    @Published var show = false
}

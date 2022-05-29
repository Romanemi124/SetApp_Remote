//
//  CategoriaView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//

import SwiftUI
import Kingfisher

struct CategoriaView: View {
    
    let categoriaTxt: String
    
    @ObservedObject var viewModel: CategoriaViewModel
    let threeColumn = [GridItem(), GridItem(), GridItem()]
    
    //private let categoria: String
    
    /*Inicializamos la categoria para pasar por parámetro la que se busca*/
    init(categoria: String, categoriaTxt: String) {
        self.viewModel = CategoriaViewModel(categoria: categoria)
        self.categoriaTxt = categoriaTxt
    }
    
    //Para volver la vista hacia atrás
    @Environment(\.presentationMode) var mode
    
   var body: some View {
       
       ZStack {
           
           FondoPantallasApp()
           
           ScrollView {
               
               VStack {
                   
                   Text(categoriaTxt)
                       .font(.title)
                       .fontWeight(.heavy)
                       .foregroundColor(.white)
                       .fontWeight(.bold)
                       .foregroundColor(.white)
                       .padding(.top, 15)
                   
                   LazyVGrid(columns: threeColumn) {
                       
                       /*Recorre el array de todas las publicaciones que se han almacenado en el array*/
                       ForEach(viewModel.posts) { post in
                           
                           NavigationLink{
                               //Mostramos el usuario gracias el usuario que hemos guardado de la sesión
                               CoursePostView(post: post)
                                   .navigationBarHidden(true)
                           }label: {
                               PostCategoria(post: post)
                           }
                       }
                   }
                   .padding()
                   .padding(.bottom, 150)
               }
           }
       }
   }
}

struct CategoriaView_Previews: PreviewProvider {
   static var previews: some View {
       CategoriaView(categoria: "", categoriaTxt: "")
   }
}

struct PostCategoria: View {
    
    let post: PostCateg
    
    var body: some View {
        
        KFImage(URL(string: post.mediaUrl))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}


//
//  CategoriaMarcaView.swift
//  SetApp
//
//  Created by Emilio Roman on 18/5/22.
//

import SwiftUI
import Kingfisher

struct MarcaView: View {
    
    let marcaTxt: String
    
    @ObservedObject var viewModel: MarcaViewModel
    let threeColumn = [GridItem(), GridItem(), GridItem()]
    
    //private let categoria: String
    
    init(marca: String, marcaTxt: String) {
        self.viewModel = MarcaViewModel(marca: marca)
        self.marcaTxt = marcaTxt
    }
    
    //Para volver la vista hacia atrás
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        
        ZStack {
            
            FondoPantallasApp()
            
            ScrollView {
                
                VStack {
                    
                    Text(marcaTxt)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    
                    LazyVGrid(columns: threeColumn) {
                        
                        ForEach(viewModel.posts) { post in
                            
                            /*Recorre el array de todas las publicaciones que se han almacenado en el array*/
                            NavigationLink{
                                //Mostramos el usuario gracias el usuario que hemos guardado de la sesión
                                CoursePostView(post: post)
                                    .navigationBarHidden(true)
                            }label: {
                                PostMarca(post: post)
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

struct MarcaView_Previews: PreviewProvider {
    static var previews: some View {
        MarcaView(marca: "", marcaTxt: "")
    }
}

struct PostMarca: View {
    
    let post: PostCateg
    
    var body: some View {
        
        KFImage(URL(string: post.mediaUrl))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}

//
//  ScrollPostView.swift
//  SetApp
//
//  Created by Emilio Roman on 6/5/22.
//

import SwiftUI

struct ScrollPostView: View {
    
    //var animation: Namespace.ID
    @EnvironmentObject var detail : DetailsViewModel
    
    //Clase donde se recorre el array con las publicaciones y se muestra la pantalla con las especificaciones de cada publicación
    var body: some View {
        
        ZStack {
            
            FondoPantallasApp()
            
            //https://www.youtube.com/watch?v=GGYf8KrOQms&t=137s min 11 para amplicar caracteristicas de las publicaciones
            
            //Para mostrar las publicaciones
            ScrollView {
                
                VStack {
                    
                    ForEach(items) { post in
                        
                        //PostItem
                        PostItem(post: post/*, animation: animation*/)
                            .onTapGesture {
                                
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                                    detail.selectedPost = post
                                    detail.show.toggle()
                                }
                            }
                         
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}

/*
struct ScrollPostView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPostView()
    }
}
*/

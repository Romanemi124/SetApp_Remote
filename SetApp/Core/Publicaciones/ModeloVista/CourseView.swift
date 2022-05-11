//
//  CourseView.swift
//  SetApp
//
//  Created by Emilio Roman on 6/5/22.
//

import Foundation
import SwiftUI


//Vista usada  en todas las publicaciones de la app donde aparecerán las distintas especificaciones de cada publicación, como los comentarios, likes y atributos de la publicación
struct CourseView: View {
    
    @ObservedObject var detail : DetailsViewModel
    //var animation: Namespace.ID
    
    //@State var scale : CGFloat = 1
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    
                    Image(detail.selectedPost.contentImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        //.matchedGeometryEffect(id: detail.selectedPost.contentImage, in: animation)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                                detail.show.toggle()
                            }
                        } ) {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(Color.black.opacity(0.7))
                                .padding()
                                .background(Color.gray.opacity(0.8))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 300)
                }
                //.gesture(DragGesture(minimumDistance: 0).onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                
                HStack {
                    
                    Image(detail.selectedPost.logo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .cornerRadius(15)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(detail.selectedPost.title)
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(detail.selectedPost.category)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(detail.selectedPost.overlay)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 15)
                    
                    Spacer(minLength: 0)
                    
                    VStack {
                        
                        //Barra para poner el corazón de MeGusta
                        Text("Ver más")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
                //.matchedGeometryEffect(id: detail.selectedPost.id, in: animation)
                .padding()
                .background(Color.gray.opacity(0.5))
                
                Text(detail.selectedPost.title)
                    .padding()
                    .foregroundColor(.white)
                
                Button(action: {}) {
                    
                    Label(title: {
                        Text("Share")
                            .foregroundColor(.white)
                    }) {
                        Image(systemName: "square.and.arrow.up.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            }
        }
        //.scaleEffect(scale)
        .ignoresSafeArea(.all, edges: .top)
    }
}

/*
struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
    }
}
*/

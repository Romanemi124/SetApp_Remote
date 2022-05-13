//
//  CourseView.swift
//  SetApp
//
//  Created by Emilio Roman on 6/5/22.
//

import SwiftUI
import Kingfisher

//Vista usada  en todas las publicaciones de la app donde aparecerán las distintas especificaciones de cada publicación, como los comentarios, likes y atributos de la publicación
struct CourseView: View {
    
    var post: Post
    
    //Para volver la vista hacia atrás
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        
        ZStack {
            
            FondoPantallasApp()
            
            ScrollView {
                
                VStack {
                    
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                        
                        KFImage(URL(string: post.mediaUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            //.matchedGeometryEffect(id: detail.selectedPost.contentImage, in: animation)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                        
                        HStack {
                            
                            Spacer()
                         
                            Button(action: {
                                
                                //Cambiamos el valor de la variable para que vuelva a la anterior vista
                                mode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrow.left.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 300)
                    }
                    //.gesture(DragGesture(minimumDistance: 0).onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                    
                    Text(post.nombreProducto)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    HStack(alignment: .center, spacing: 10) {
                            
                        Text(post.categoria)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("/")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(post.marca)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 2)
                    
                    PostCardLikes(post: post)
                        .padding(.top, 3)
                    
                    HStack(spacing: 0) {
                        
                        Text("Valoración: \(post.valoracion)" + "/10")
                            .padding()
                            .foregroundColor(.white)
                        
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                    }
                    
                    /*
                    Text("Valoración: \(post.valoracion)" + "/10")
                        .padding()
                        .foregroundColor(.white)
                    */
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("Ventajas")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            //Para saber ha cuanto se subió la publicación
                            Text(post.puntosPositivos)
                                .foregroundColor(.white)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 30)
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("Desventajas")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            //Para saber ha cuanto se subió la publicación
                            Text(post.puntosNegativos)
                                .foregroundColor(.white)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    HStack {
                        
                        KFImage(URL(string: post.profile))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 65, height: 65)
                            .cornerRadius(15)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text(post.username)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            //Para saber ha cuanto se subió la publicación
                            Text((Date(timeIntervalSince1970: post.date)).timeAgo() + " ago").font(.subheadline)
                                .foregroundColor(.white)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.leading, 30)
                    .padding(.top, 20)
                    
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
}

/*
struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
    }
}
*/

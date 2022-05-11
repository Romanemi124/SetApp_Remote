//
//  CategoriaView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 5/5/22.
//


import SwiftUI

struct CategoriaView: View {
   
   /*
   var categoria: CategoriasBuscador
   @Binding var showVistaCategoria: Bool
   @Binding var detailCategoria: CategoriasBuscador?
   @Binding var currentCardSize: CGSize
   
   var animation: Namespace.ID
    */
    
   @State var posts: [PostPrueba] = []
    
   //Para las columnas y distribuir las imágenes en ellas
   @State var columns: Int = 2
    
   //Para la animación
   @Namespace var animation
    
   var body: some View {
       
       ZStack {
           
           NavigationView {
               
               //Obtenemos el objeto para luego mostrarlo en forma de carta
               StaggeredGrid(colums: columns, list: posts, content: { post in
                   //Se mostrarán las imágenes que se van a ver de cada categoría
                   //A cada imagen que se recoge del bucle se le aplica la card con los estilos que tienen pasando el post por parámetro
                   PublicationCategoria(post: post)
                       .matchedGeometryEffect(id: post.id, in: animation)
                       .onAppear {
                           print(post.imageURL)
                       }
                   
               })
               .background(Color(red: 0.331, green: 0.074, blue: 0.423))
               .padding(.horizontal)
               .navigationTitle("Categoria")
               .toolbar {
                   
                   ToolbarItem(placement: .navigationBarTrailing) {
                          
                       Button {
                           columns += 1
                       } label: {
                           Image(systemName: "plus")
                               .foregroundColor(.white)
                       }
                   }
                   
                   ToolbarItem(placement: .navigationBarTrailing) {
                          
                       Button {
                           columns = max(columns - 1, 1)
                       } label: {
                           Image(systemName: "minus")
                               .foregroundColor(.white)
                       }
                   }
               }
               //animación para desplazar las imágenes de un número de columnas
               .animation(.easeInOut, value: columns)
               .background(Color(red: 0.331, green: 0.074, blue: 0.423))
           }
           .onAppear {
               
               //Recorre el bucle de las imágenes que queremos mostrar
               for index in 1...10 {
                   posts.append(PostPrueba(imageURL: "desk"))
               }
           }
           .foregroundColor(.white)
           .padding(.bottom, 30)
           .background(Color(red: 0.331, green: 0.074, blue: 0.423))
       }
   }
}

struct CategoriaView_Previews: PreviewProvider {
   static var previews: some View {
       CategoriaView()
   }
}

//Pasamos el array de las imágenes para poder mostrarlas


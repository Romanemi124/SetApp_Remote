//
//  FeedView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import SwiftUI

struct FeedView: View {
    
    @Namespace var namespace
    @State var show = false
    
    //Clase será la pantalla principal de la app
    var body: some View {
        
        ZStack {
            
            /*
            Image("publi")
                .resizable()
                .ignoresSafeArea()
             */
            
            //Color de fondo de la vista
            Color(red: 0.113, green: 0.031, blue: 0.16).ignoresSafeArea()
            //Color(red: 0.331, green: 0.074, blue: 0.423).ignoresSafeArea()
            
            //El ScrollView permite poner todas las publicaciones que se quieran ver y deslizar hacia abajo
            ScrollView {
                
                Spacer(minLength: 20)
                
                //En el caso de que se haya seleccionado una publicación y se quieran ver los detalles se redirigirá a otra vista
                if !show {
                    
                    PublicationItem()
                        .onTapGesture {
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                show.toggle()
                            }
                        }
                    
                    PublicationItem()
                    PublicationItem()
                }
                
                /*
                Text("Courses".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                 */
            }
            //.padding(top, 80)
            
            if show {
                CourseView(namespace: namespace, show: $show)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

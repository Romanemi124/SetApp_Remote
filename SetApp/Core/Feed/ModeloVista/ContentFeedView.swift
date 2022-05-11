//
//  ContentFeedView.swift
//  SetApp
//
//  Created by Emilio Roman on 6/5/22.
//

import SwiftUI

struct ContentFeedView: View {
    
    //@Namespace var animation
    //Este objeto lo usamos para recoger los datos de la publiicación y mostrar más detalles
    @StateObject var detailObject = DetailsViewModel()
    
    //Clase será la pantalla principal de la app donde se muestra el scroll con  todas las publicaciones de la aplicación
    var body: some View {
        
        ZStack {
            
            TabView {
                ScrollPostView(/*animation: animation*/)
                    .environmentObject(detailObject)
            }
            .opacity(detailObject.show ? 0 : 1)
            
            if detailObject.show {
                /*
                CourseView(detail: detailObject, animation: animation)*/
                CourseView(detail: detailObject)
            }
        }
    }
}

struct ContentFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ContentFeedView()
    }
}

//
//  CourseView.swift
//  SetApp
//
//  Created by Emilio Roman on 18/4/22.
//

import SwiftUI
import Kingfisher

struct CourseView: View {
    
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    let publicacion: Publicacion
    
    var body: some View {
        
        ZStack {
            
            //Se pondrán las características y se podrá deslizar hacia abajo
            ScrollView {
                
                cover
                contenido
            }
            .background(Color(red: 0.113, green: 0.031, blue: 0.16))
            .ignoresSafeArea()
            
            //Botón que se podrá volver atrás donde se ve la publicación que se quería ampliar con una animación
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    show.toggle()
                }
            } label: {
                
                //Fondo del icono del botón con sus estilos
                Image(systemName: "arrow.left")
                    .font(.body.weight(.bold))
                    .foregroundColor(.secondary)
                    .padding(10)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(20)
            .padding(.top, 80)
            .ignoresSafeArea()
        }
    }
    
    //Se encuentran la imagen de la publicación y los datos de ésta
    var cover: some View {
        
        VStack {
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .foregroundStyle(.black)
        //Se pone de fondo la publicación del usuario
        .background(
            //Image("publi")
            KFImage(URL(string: publicacion.UrlImagePublicacion))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .mask(
            LinearGradient(gradient: Gradient(stops: [
                .init(color: Color.black, location: 0),
                .init(color: Color.black, location: 0.85),
                .init(color: Color.black.opacity(0), location: 1)]),
                           startPoint: .top, endPoint: .bottom))
        
    }
    
    var contenido: some View {
        
        VStack(spacing: 12) {
            
            if let usuario = publicacion.user {
                
                //Cada texto tiene su estilo y se cargarán los datos anteriores
                Text(publicacion.nombreProducto)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                Text(publicacion.valoracion.uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle", in: namespace)
                    .foregroundColor(.white)
                Text(publicacion.marca)
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text", in: namespace)
                    .foregroundColor(.white)
                Divider()
                HStack {
                    
                    //Se carga la foto de pefil del usuario junto con su nombre
                    KFImage(URL(string: usuario.UrlImagenPerfil))
                        .resizable()
                        .frame(width: 26.0, height: 26.0)
                        .cornerRadius(10)
                        .padding(8)
                        .background(.ultraThinMaterial, in:
                                        RoundedRectangle(cornerRadius: 18, style: .continuous))
                    
                    Text(usuario.nombreUsuario)
                        .font(.footnote)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
/*
struct CourseView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        CourseView(namespace: namespace, show: .constant(true), publicacion: publicacion)
    }
}
*/

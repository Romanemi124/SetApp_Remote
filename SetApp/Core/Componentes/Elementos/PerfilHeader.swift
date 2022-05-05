//
//  PerfilHeader.swift
//  SetApp
//
//  Created by Emilio Roman on 3/5/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PerfilHeader: View {
    
    var user: Usuario?
    
    var body: some View {
        
        VStack {
            
            if user != nil {
                WebImage(url: URL(string: user!.UrlImagenPerfil))
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100, alignment: .trailing)
                    .padding(.leading)
            } else {
                Color.init(red: 0.113, green: 0.031, blue: 0.16).frame(width: 100, height: 100, alignment: .trailing)
                    .padding(.leading)
            }
            
            Text(user!.nombreUsuario).font(.headline).bold().padding(.leading)
        }
        
        VStack {
            
            HStack {
                
                Spacer()
                
                VStack {
                    Text("Seguidores").font(.headline)
                    Text("20").font(.title).bold()
                }.padding(.top)
                
                Spacer()
                
                VStack {
                    Text("Seguidos").font(.headline)
                    Text("20").font(.title).bold()
                }.padding(.top)
                
                Spacer()
            }
        }
    }
}

struct PerfilHeader_Previews: PreviewProvider {
    static var previews: some View {
        PerfilHeader()
    }
}

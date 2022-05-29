//
//  UserRowView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import SwiftUI
import Kingfisher

/*Esta clase se usa para mostrar los datos del usuario en el buscador*/
struct UserRowView: View {
    
    let user: UsuarioFireBase
    var body: some View {
        
        HStack(spacing: 12){
            
            KFImage(URL(string: user.urlImagenPerfil))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
            .frame(width: 56, height: 56)
            
            VStack(alignment: .leading, spacing: 4){
                
                Text(user.nombreUsuario).font(.subheadline)
                    .bold().foregroundColor(.black)
                
                Text(user.nombreCompleto).font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}


/*
struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView()
    }
}
*/

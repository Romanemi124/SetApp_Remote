//
//  PerfilPublicacion.swift
//  SetApp
//
//  Created by Emilio Roman on 25/4/22.
//

import SwiftUI
import Kingfisher

struct PerfilPublicacion: View {
    
    var post: Post
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            //Cargamos la foto de la publicación
            KFImage(URL(string: post.mediaUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(post.nombreProducto)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Label {
                    Text("\(post.categoria.uppercased())" + " / " + "\(post.marca.uppercased())")
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "gamecontroller.fill")
                        .foregroundColor(.white)
                }
                PostCardLikes(post: post)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            //Eliminar publiacion
            Button{
                print("Id del post \(post.postId)")
                print("Id del OwnerId \(post.OwnerId)")
                
                /*  Eliminar la publicación de Storage */
                StorageService.eliminarPublicacion(idPublicacion: post.postId){ result in
                    switch result {
                        //En caso de error o que no haya encontrado
                    case .failure(let error):
                        
                        //Mostraremos un alert indicando que ha habido alñgún error al borrar la foto
                        print("Error: Publicacion Storage \(error.localizedDescription)")
                        //En caso de que se haya borrado correcatmente
                    case .success(_):
                        
                        print("Se ha borrado la publicación Storage correctamente")
                        
                        /*  Eliminar la publicación de Cloud Firestore */
                        
                        //1º Borramos de la colección de todas las publicaciones
                        Store.eliminarColeccionAllPost(idPublicacion: post.postId){ result in
                            switch result {
                                //En caso de error o que no haya encontrado
                            case .failure(let error):
                                //Mostraremos un alert indicando que ha habido alñgún error al borrar la foto
                                print("Error: Publicacion eliminarColeccionAllPost \(error.localizedDescription)")
                                //En caso de que se haya borrado correcatmente
                            case .success(_):
                                print("Se ha borrado la publicación eliminarColeccionAllPost correctamente")
                                
                                //2º Borramos de la publicacion de cada usuario
                                Store.eliminarColeccionPost(idUsuario: post.OwnerId, idPublicacion: post.postId){ result in
                                    switch result {
                                        //En caso de error o que no haya encontrado
                                    case .failure(let error):
                                        
                                        //Mostraremos un alert indicando que ha habido alñgún error al borrar la foto
                                        print("Error: Publicacion eliminarColeccionPost \(error.localizedDescription)")
                                        //En caso de que se haya borrado correcatmente
                                    case .success(_):
                                        print("Se ha borrado la publicación eliminarColeccionPost correctamente")
                                    }
                                    
                                }
                                
                            }
                        }
            
                        
                    }
                    
                }
                
            }label: {
                Image(systemName: "trash")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            
        }
    }
}

/*
struct PerfilPublicacion_Previews: PreviewProvider {
    static var previews: some View {
        PerfilPublicacion()
    }
}
*/

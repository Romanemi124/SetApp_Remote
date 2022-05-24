//
//  FeedView.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 2/4/22.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    @ObservedObject var viewModel: FeedViewModel
    let threeColumn = [GridItem()]
    
    init() {
        self.viewModel = FeedViewModel()
    }
    
    //Clase será la pantalla principal de la app
    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
        
            //Mostramos la vista deseada
            ZStack {
                
                FondoPantallasApp()
                
                ScrollView {
                    
                    VStack {
                        
                        Text("Descubre")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 15)
                        
                        LazyVGrid(columns: threeColumn) {
                            
                            ForEach(viewModel.posts) { post in
                                
                                NavigationLink{
                                    //Mostramos el usuario gracias el usuario que hemos guardado de la sesión
                                    CoursePostView(post: post)
                                        .navigationBarHidden(true)
                                }label: {
                                    PostItem(post: post)
                                }
                            }
                        }
                        .padding()
                        .padding(.bottom, 150)
                    }
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

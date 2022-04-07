//
//  MenuDesplegableView.swift
//  SetApp
//
//  Created by Emilio Roman on 7/4/22.
//

import SwiftUI

struct MenuDesplegableView: View {
    
    @Binding var currentTab: String
    
    //Transición en la que se muestra la ventana a la que queremos acceder
    @Namespace var animation
    var body: some View {
        
        VStack {
            
            HStack(spacing: 15) {
                
                //Cargamos la foto de perfil
                Image("SetApp")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                
                //Nombre del usuario
                /*
                Text("")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                 */
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
             //Para las pantallas pequeñas
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false, content: {
                
                //Parte donde se encuentran los botones del menú
                VStack(alignment: .leading, spacing: 30) {
                    
                    CustomTabBoton(icon: "person", title: "Perfil")
                    CustomTabBoton(icon: "gearshape", title: "Ajustes")
                    CustomTabBoton(icon: "qrcode.viewfinder", title: "Código QR")
                    CustomTabBoton(icon: "creditcard", title: "Pagos")
                    
                    Spacer()
                    
                    CustomTabBoton(icon: "rectangle.portrait.and.arrow.right", title: "Cerrar sesión")
                }
                .padding()
                .padding(.top, 80)
            })
            
            //Alineación
            .frame(width: getRect().width / 2, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(red: 0.113, green: 0.031, blue: 0.16))
    }
    
    //Botón customizable
    @ViewBuilder
    func CustomTabBoton(icon: String, title: String) -> some View {
        
        Button {
            
            if title == "Cerrar sesión" {
                
                //Cuando mostremos la vista principal y se haya cerrado la sesión del usuario
                
                print("Cerrar sesión")
            } else {
                withAnimation {
                    currentTab = title
                }
            }
        } label: {
            
            HStack(spacing: 12) {
                
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: currentTab == title ? 48 : nil, height: 48)
                    .foregroundColor(currentTab == title ? Color(red: 0.721, green: 0.491, blue: 0.849) : (title == "Cerrar sesión" ? Color(red: 0.721, green: 0.491, blue: 0.849) : .white))
                    .background(
                    
                        ZStack {
                            
                            if currentTab == title {
                                Color.white.clipShape(Circle())
                                    .matchedGeometryEffect(id: "TabCirculo", in: animation)
                            }
                        }
                    )
                
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(title == "Cerrar sesión" ? Color(red: 0.721, green: 0.491, blue: 0.849) : .white)
            }
            .padding(.trailing, 18)
            .background(
            
                ZStack {
                    if currentTab == title {
                        Color(red: 0.331, green: 0.074, blue: 0.423).clipShape(Capsule())
                            .matchedGeometryEffect(id: "TabCapsula", in: animation)
                    }
                }
            )
        }
        .offset(x: currentTab == title ? 15 : 0)
    }
}

extension View {
    
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

struct MenuDesplegableView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView()
    }
}

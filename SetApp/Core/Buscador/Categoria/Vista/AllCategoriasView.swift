//
//  AllCategoriasView.swift
//  SetApp
//
//  Created by Emilio Roman on 22/5/22.
//

import SwiftUI

struct AllCategoriasView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
            
            ZStack {
                
                FondoPantallasApp()
                
                ScrollView {
                    
                    HStack(spacing: 12) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("CATEGORÍAS")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .padding(.top, 10)
                    
                    /*Se almacenan todas las categorías que se pueden tener dentro de la aplicación*/
                    Group {
                        FilaCategoria(txtCategoria: "Monitor", logoCategoria: "desktopcomputer")
                        FilaCategoria(txtCategoria: "Ratón", logoCategoria: "magicmouse.fill")
                        FilaCategoria(txtCategoria: "Teclado", logoCategoria: "keyboard.fill")
                        FilaCategoria(txtCategoria: "Auriculares", logoCategoria: "airpodsmax")
                        FilaCategoria(txtCategoria: "Altavoz", logoCategoria: "hifispeaker.fill")
                        FilaCategoria(txtCategoria: "Micrófono", logoCategoria: "mic.fill")
                    }
                    
                    Group {
                        FilaCategoria(txtCategoria: "Webcam/Cámara Web", logoCategoria: "camera.fill")
                        FilaCategoria(txtCategoria: "Mando", logoCategoria: "gamecontroller.fill")
                        FilaCategoria(txtCategoria: "Consola", logoCategoria: "logo.playstation")
                        FilaCategoria(txtCategoria: "Juegos", logoCategoria: "dpad.left.filled")
                        FilaCategoria(txtCategoria: "Racing", logoCategoria: "car.fill")
                        FilaCategoria(txtCategoria: "PC", logoCategoria: "airport.extreme.tower")
                    }
                    
                    Group {
                        FilaCategoria(txtCategoria: "Componente PC", logoCategoria: "cpu.fill")
                        FilaCategoria(txtCategoria: "Portátil", logoCategoria: "laptopcomputer")
                        FilaCategoria(txtCategoria: "Silla", logoCategoria: "studentdesk")
                        FilaCategoria(txtCategoria: "Mesa", logoCategoria: "externaldrive.connected.to.line.below.fill")
                        FilaCategoria(txtCategoria: "Alfombrilla", logoCategoria: "tv.fill")
                        FilaCategoria(txtCategoria: "Accesorios", logoCategoria: "memorychip.fill")
                    }
                    
                    Group {
                        FilaCategoria(txtCategoria: "Almacenamiento", logoCategoria: "folder.fill")
                        FilaCategoria(txtCategoria: "Teléfono", logoCategoria: "iphone.homebutton")
                        FilaCategoria(txtCategoria: "Tablet", logoCategoria: "ipad.homebutton.landscape")
                        FilaCategoria(txtCategoria: "Audio", logoCategoria: "message.and.waveform")
                        FilaCategoria(txtCategoria: "Foto", logoCategoria: "photo.on.rectangle.angled")
                        FilaCategoria(txtCategoria: "Video", logoCategoria: "video.fill")
                    }
                    
                    Group {
                        FilaCategoria(txtCategoria: "TV", logoCategoria: "4k.tv.fill")
                        FilaCategoria(txtCategoria: "Impresora", logoCategoria: "printer.filled.and.paper")
                        FilaCategoria(txtCategoria: "Software", logoCategoria: "icloud.fill")
                        FilaCategoria(txtCategoria: "Red", logoCategoria: "wifi")
                        FilaCategoria(txtCategoria: "Hogar", logoCategoria: "house.fill")
                        FilaCategoria(txtCategoria: "Robótica", logoCategoria: "atom")
                    }
                    
                    Group {
                        FilaCategoria(txtCategoria: "Figura", logoCategoria: "puzzlepiece.extension.fill")
                        FilaCategoria(txtCategoria: "Reloj", logoCategoria: "applewatch")
                        FilaCategoria(txtCategoria: "Ocio y tiempo libre", logoCategoria: "guitars.fill").padding(.bottom, 50)
                    }
                }
            }
        }
    }
}

struct AllCategoriasView_Previews: PreviewProvider {
    static var previews: some View {
        AllCategoriasView()
    }
}

/*Estructura para mostrar cada categoría con su nombre e icono*/
struct FilaCategoria: View {
    
    var txtCategoria: String
    var logoCategoria: String
    
    var body: some View {
        
        VStack {
            
            Rectangle()
                .fill(Color.white)
                .frame(height: 0.5)
                .padding(.bottom, 20)
            
            HStack(spacing: 12) {
                
                Image(systemName: logoCategoria)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .padding(.leading, 20)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    NavigationLink {
                        
                        CategoriaView(categoria: txtCategoria, categoriaTxt: txtCategoria)
                    } label: {
                        
                        Text(txtCategoria)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.leading, 30)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
    }
}

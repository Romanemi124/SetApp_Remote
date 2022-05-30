//
//  NetworkManager.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 21/5/22.
//

import Foundation
import Network

//La clase es de tipo ObservableObject para que se mantenga atento a los cambios de conexión a Internet
class NetworkManager: ObservableObject{
    
    //Controlador de la red
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    //Esta variable va indicar si está conectada o no a Internet
    @Published var isConnected = true
    
    //? Para que el caso que haya o no internet se muestre una imagen
    var imageName: String {
        return isConnected ? "wifi" : "wifi.slash"
    }
    
    //Para que se muestre un texto dependidendo de la conexión de internet
    var connectionDescription: String {
        if isConnected {
            return "Internet connection looks good!"
        } else {
            return ""
        }
    }
    
    init(){
        
        // monitor.pathUpdateHandler controlamos si hay algún cambio en la conexión
        monitor.pathUpdateHandler = { path  in
            // DispatchQueue.main.async  cada vez que intentamos actuluaza la interfaz queremos ejecutar eso en hilo principal de la aplicación
            DispatchQueue.main.async {
                //path.status == .satisfied Evaluamos si está conectado a internet devulve un boolean
                // self.isConnected = path.status == .satisfied guardamos en la variable si está conectado a Internet o no
                self.isConnected = path.status == .satisfied
            }

        }
        
        //Empezamos el proceso de monitoreo en esta cola
        monitor.start(queue: queue)
    }
    
}

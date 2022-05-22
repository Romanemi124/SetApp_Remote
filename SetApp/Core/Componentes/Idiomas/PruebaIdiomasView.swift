//
//  PruebaIdiomasView.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 20/5/22.
//

import SwiftUI

struct PruebaIdiomasView: View {
    
    @State var textFieldName: String = ""
    @State var textFielPhone: String = ""
    
    var body: some View {
        TabView{
            Form {
                
                Section{
                    TextField("form-name-key", text: $textFieldName)
                    //User´s Phone Interpolación de los Strings
                    TextField("form-phone-user \(textFieldName)", text: $textFielPhone)
                        .keyboardType(.namePhonePad)
                    HStack{
                        Spacer()
                        Button("Accept"){
                            print("Save information...")
                        }
                        .buttonStyle(.bordered)
                        .tint(.blue)
                    }
                }header: {
                   
                    Text("conexion-internet-fallida")
                    Text("form-name-key")
                   
                }footer: {
                    Text("*All the information  will be confident")
                }
            }
            .tabItem{
                Label("Home", systemImage: "house.fill")
            }
            Text("Profile")
                .tabItem{
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
        
    }
}

struct PruebaIdiomasView_Previews: PreviewProvider {
    static var previews: some View {
        PruebaIdiomasView()
    }
}

//Ver toda la viusta en español
/* struct ContentView_Previews: PreviewProvider {
 static var previews some View {
     ContentView()
         .environment(\.locale, .init(identifier: "en"))
 }
} */

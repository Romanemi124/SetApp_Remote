//
//  PublicacionView.swift
//  SetApp
//
//  Created by Emilio Roman on 14/4/22.
//

import SwiftUI

struct PublicacionView: View {
    
    @Environment(\.presentationMode) var mode
    
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "¡Ups!"
    //@State private var text = ""
    
    //Atributos que tiene la publicación
    @State private var categoria: TiposCategoria = .monitor
    @State private var marca: NombreMarcas = .life
    //@State private var categoria: String = ""
    @State private var nombreProducto: String = ""
    //@State private var marca: String = ""
    @State private var valoracion: String = ""
    @State private var caracteristicas: String = ""
    
    var body: some View {
        
        ZStack {
            
            FondoPantallaClaroApp()
            
            //Parte donde se encontrará la foto que se publicar y los botones para poder seleccionar galería o cámara
            VStack {
                
                //Este link se muestra en el momento en el que ya se ha seleccionado una foto para publicar
                HStack{
                    
                    Text("Publicar")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Button(action: uploadPost) {
                        Image(systemName: "icloud.and.arrow.up.fill")
                            .resizable()
                            .frame(width: 35, height: 30)
                            .foregroundColor(.white)
                            .padding(.top, 15)
                            .padding(.bottom, 15)
                            .padding(.leading, 15)
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                    }
                }
                
                VStack {
                    
                    //Parte donde se encontrarán los campos a rellenar
                    ScrollView {
                        
                        Group{
                            
                            //Se cargará la imagen anterior para poder ver la publicación
                            if postImage != nil {
                                postImage!
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 250, height: 250)
                                    .cornerRadius(10)
                                    .padding(.bottom, 15)
                                    .onTapGesture {
                                        self.showingActionSheet = true
                                    }
                            } else {
                                Image("publi")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 250, height: 250)
                                    .cornerRadius(10)
                                    .padding(.bottom, 15)
                                    .onTapGesture {
                                        self.showingActionSheet = true
                                    }
                            }
                            
                            CamposEntrada(placeholder: "Nombre componente", isSecureField: false,text: $nombreProducto)
                            
                            //CamposEntrada(placeholder: "Marca",isSecureField: false, text: $marca)
                            HStack(spacing:150){
                                Text("Seleccionar Marca:").foregroundColor(Color.white)
                                //Elegir el sexo
                                Picker(selection: $marca, label: Text("")) {
                                    ForEach(NombreMarcas.allCases, id: \.self) { marca in
                                        Text(marca.nombreMarcas)
                                    }
                                }
                                .labelsHidden()
                                .padding(.leading,-43)
                            }
                            
                            //CamposEntrada(placeholder: "Categoría", isSecureField: false,text: $categoria)
                            HStack(spacing:150){
                                Text("Seleccionar Categoría:").foregroundColor(Color.white)
                                //Elegir el sexo
                                Picker(selection: $categoria, label: Text("")) {
                                    ForEach(TiposCategoria.allCases, id: \.self) { categoria in
                                        Text(categoria.tiposCategoria)
                                    }
                                }
                                .labelsHidden()
                                .padding(.leading,-43)
                            }
                            
                            CamposEntrada(placeholder: "Valoración", isSecureField: false,text: $valoracion)
                            
                            TextEditor(text: $caracteristicas)
                                .frame(height: 200)
                                .padding(4)
                                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.331, green: 0.074, blue: 0.423)))
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 30)
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Selecciona una opción"),
                                buttons: [
                                    .default(Text("Galería")) {
                                        self.sourceType = .photoLibrary
                                        self.showingImagePicker = true
                                    },
                                    .default(Text("Camera")) {
                                        self.sourceType = .camera
                                        self.showingImagePicker = true
                                    },
                                    .cancel()
                                ])
                }
            }
            .padding(30)
        }
    }
    
    func loadImage() {
        guard let inputImage = pickedImage else {return}
        
        postImage = inputImage
    }
    
    func uploadPost() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            
            return
        }
        
        ServicioPost.uploadPost(imageData: imageData, categoria: categoria.tiposCategoria, nombreProducto: nombreProducto, marca: marca.nombreMarcas, valoracion: valoracion, caracteristicas: caracteristicas, onSuccess: {
            self.clear()
        }) {
            (errorMessage) in
            
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    func clear() {
        self.nombreProducto = ""
        self.valoracion = ""
        self.caracteristicas = ""
        self.imageData = Data()
        self.postImage = Image("publi")
    }
    
    func errorCheck() -> String? {
        
        if nombreProducto.trimmingCharacters(in: .whitespaces).isEmpty || valoracion.trimmingCharacters(in: .whitespaces).isEmpty || caracteristicas.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
            
            return "Faltan datos por rellenar"
        }
        return nil
    }
}

struct PublicacionView_Previews: PreviewProvider {
    static var previews: some View {
        PublicacionView()
    }
}

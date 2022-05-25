//
//  PublicacionView.swift
//  SetApp
//
//  Created by Emilio Roman on 14/4/22.
//

import SwiftUI

struct PublicacionView: View {
    
    //Controlar que esté conectado a Internet
    @ObservedObject var networkManager = NetworkManager()
    
    @EnvironmentObject var session: EstadoAutentificacionUsuario
    
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet: Bool = false
    @State private var showingImagePicker: Bool = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var error:String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "¡Ups!"
    @Environment(\.presentationMode) var mode
    
    //Atributos que tiene la publicación
    @State private var categoria: TiposCategoria = .monitor
    @State private var marca: NombreMarcas = .life
    @State private var valoracion: NumValoracion = .diez
    @State private var nombreProducto: String = ""
    @State private var linkProducto: String = ""
    //@State private var valoracion: String = ""
    @State private var puntosPositivos: String = ""
    @State private var puntosNegativos: String = ""
    
    
    var body: some View {
        
        //Verficamos que esté conectado a Internet
        if !networkManager.isConnected {
            
            //Mostramos la vista de fallo de conexión a Internet
            ConexionInternetFallidaView(networkManager: networkManager)
            
        }else{
        
            //Mostramos la vista deseada
            ZStack {
                
                FondoPantallaClaroApp()
                
                //Parte donde se encontrará la foto que se publicar y los botones para poder seleccionar galería o cámara
                VStack {
                    
                    //Este link se muestra en el momento en el que ya se ha seleccionado una foto para publicar
                    HStack{
                        
                        Text("publicacion-titulo")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423))
                        
                        Button(action: uploadPost) {
                            Image(systemName: "icloud.and.arrow.up.fill")
                                .resizable()
                                .frame(width: 35, height: 30)
                                .foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423))
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
                                    Image("camaraFondo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 250, height: 250)
                                        .cornerRadius(10)
                                        .padding(.bottom, 15)
                                        .onTapGesture {
                                            self.showingActionSheet = true
                                        }
                                }
                                
                                //Se despliegan las distintas marcas que existen dentro del fichero de Xcode
                                HStack {
                                    
                                    Text("publicacion-marca-titulo").foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423)).fontWeight(.heavy)
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        
                                        Picker(selection: $marca, label: Text("")) {
                                            ForEach(NombreMarcas.allCases, id: \.self) { marca in
                                                Text(marca.nombreMarcas)
                                            }
                                        }
                                    }
                                    
                                    Spacer(minLength: 0)
                                }
                                .padding(.leading, 35)
                                
                                //Se despliegan las distintas categorías que hay dentro del fichero
                                HStack {
                                    
                                    Text("publicacion-categoria-titulo").foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423)).fontWeight(.heavy)
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        
                                        Picker(selection: $categoria, label: Text("")) {
                                            ForEach(TiposCategoria.allCases, id: \.self) { categoria in
                                                Text(categoria.tiposCategoria)
                                            }
                                        }
                                    }
                                    
                                    Spacer(minLength: 0)
                                }
                                .padding(.leading, 35)
                                
                                //Se selecciona una valoración entre el 1 al 10
                                HStack {
                                    
                                    Text("publicacion-valoracion-titulo").foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423)).fontWeight(.heavy)
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        
                                        Picker(selection: $valoracion, label: Text("")) {
                                            ForEach(NumValoracion.allCases, id: \.self) { valoracion in
                                                Text(valoracion.numValoracion)
                                            }
                                        }
                                    }
                                    
                                    Spacer(minLength: 0)
                                }
                                .padding(.leading, 35)
                                
                                CamposPost(placeholder: "publicacion-nombre", isSecureField: false,text: $nombreProducto)
                                
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        
                                        Text("publicacion-ventajas")
                                            .foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423)).fontWeight(.heavy)
                                        
                                        TextEditor(text: $puntosPositivos)
                                            .frame(height: 120)
                                            .padding(4)
                                            .foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423))
                                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.331, green: 0.074, blue: 0.423)))
                                            .padding(.top, 10)
                                    }
                                    
                                    Spacer(minLength: 0)
                                }
                                .padding(.horizontal, 35)
                                .padding(.top, 20)
                                
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        
                                        Text("publicacion-desventajas")
                                            .foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423)).fontWeight(.heavy)
                                        
                                        TextEditor(text: $puntosNegativos)
                                            .frame(height: 120)
                                            .padding(4)
                                            .foregroundColor(Color(red: 0.331, green: 0.074, blue: 0.423))
                                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.331, green: 0.074, blue: 0.423)))
                                            .padding(.top, 10)
                                    }
                                    
                                    Spacer(minLength: 0)
                                }
                                .padding(.horizontal, 35)
                                .padding(.top, 20)
                                
                                CamposPost(placeholder: "publicacion-link", isSecureField: false,text: $linkProducto)
                                    .padding(.top, 20)
                                    .padding(.bottom, 40)
                                
                            }
                            
                        }
                        .padding(.bottom, 30)
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData, sourceType: self.sourceType)
                        //SeleccionarFoto(image: self.$pickedImage, isShown: self.$showingImagePicker, sourceType: self.sourceType)
                    }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text(LocalizedStringKey("registrarCuenta-notificacion")),
                                    buttons: [
                                        .default(Text(LocalizedStringKey("registrarCuenta-notificacion-galeria"))) {
                                            //vm.source = .library
                                            self.sourceType = .photoLibrary
                                            self.showingImagePicker = true
                                        },
                                        .default(Text(LocalizedStringKey("registrarCuenta-notificacion-camara"))) {
                                            //vm.source = .camera
                                            self.sourceType = .camera
                                            self.showingImagePicker = true
                                        },
                                        .cancel()
                                    ])
                    }
                    .accentColor(Color(red: 0.331, green: 0.074, blue: 0.423))
                    /*
                    .alert("Error", isPresented: $vm.showCameraAlert, presenting: vm.cameraError, actions: { cameraError in
                        cameraError.button
                    }, message: { cameraError in
                        Text(cameraError.message)
                    })
                     */
                }
                .padding(30)
            }
            
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
        
        ServicioPost.uploadPost(imageData: imageData, categoria: categoria.tiposCategoria, nombreProducto: nombreProducto, marca: marca.nombreMarcas, valoracion: valoracion.numValoracion, link: linkProducto, puntosPositivos: puntosPositivos, puntosNegativos: puntosNegativos, usuario: self.session.usuario, onSuccess: {
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
        self.linkProducto = ""
        self.puntosPositivos = ""
        self.puntosNegativos = ""
        self.imageData = Data()
        self.postImage = Image("camaraFondo")
    }
    
    func errorCheck() -> String? {
        
        if nombreProducto.trimmingCharacters(in: .whitespaces).isEmpty || linkProducto.trimmingCharacters(in: .whitespaces).isEmpty || puntosPositivos.trimmingCharacters(in: .whitespaces).isEmpty || puntosNegativos.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
            
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

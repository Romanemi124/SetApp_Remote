/* Esta clase gestionará las credenciales del usuario y los datos asociados a los usuarios */
//  AutentificacionModelView..swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 1/4/22.
//

import SwiftUI
import Firebase

/*  ObservableObject Permite que en tiempo de ejecución reaccionar a los cambios en sus datos. ObservableObject proporciona una implementación predeterminada para que el objecto cambie utilizando Combine/ObservableObjectPublisher.
    Para desencadenar eventos objectWillChange eventos que nos va permitir cambiar los datos de los objectos, debemos anotar en sus propiedades el contenedor de propiedades @Published, de modo que cuando ocurran cambios importantes, la vista se volverá a cargar. */
class AutentificacionModelView: ObservableObject{
    
    /* @Published contenedor de propiedades le dice a SwiftUI que los cambios en en las varibles deben desencadenar recargas de vista; puesto que hace que el objeto emita un evento objectWillChange cada vez que se modifica esa variable */
    /* @Published var userSession: Almacena la sesión de usauario al autenticarse */
    /* @Published var userSession: FirebaseAuth.User? es importante indicar que tiene que ser de tipo FirebaseAuth.User Esta clase le permite manipular el perfil de un usuario, vincular y desvincular proveedores de autenticación y actualizar tokens de autenticación.*/
    /* @Published var userSession: FirebaseAuth.User? Al añdir una ? inicamos que es también que es un Objecto Optional, es decir, que puede almacenar objectos nulos y no nulo. Esto no será util para mostrar al inicio de laejecución de la aplicación mostrar */
    //Variable que almacena las credenciales de los usuarios
    @Published var sesionUsuario: FirebaseAuth.User?
    //Variable almacena si está autentificado el usuario
    @Published var usuarioAutentificado = false
    //Almacena los datos del usuario que ha iniciado sesión
    @Published var usuarioActual: Usuario?
    //Esta variable almacenará las credenciales del usuario solo durante el proceso de registro, debido a que el proceso de guardar la foto de perfil se realiza en un método diferente al registro de datos del usuario
    private var sesionUsuarioTemporal: FirebaseAuth.User?
    
    /* Objecto para acceder a los servicios del usuario, esto será util para mostrar los datos del usuario autentificado */
    private let service = ServicioUsuario()
    
    /* Objecto que almacena el usuario validado */
    @Published var usuarioRegistro : UsuarioRegistro?
    /* Objecto que valida si el usuario puede registrarse correctamente y pasar la vista seleccionar foto de perfil */
    @Published var usuarioValidado = false

    /* init() La inicialización es el proceso de preparación de una instancia de una clase, estructura o enumeración para su uso*/
    //Creamos "el contructor" de la clase
    init(){
        /* Auth.auth().currentUser obtener el usuario que ha accedido, sino ha accedido ningún usuario, el valor de currentUser es nulo */
        //Guardamos las credenciales del usuario logeado
        self.sesionUsuario = Auth.auth().currentUser
        //Mostramos los datos del usuario. También nos sirve para refrescar los datos en la app al iniciar sesión con diferentes usuarios
        self.datosUsuario()
        
        //print("SUCESSFUL: Usuario que ha iniciado sesión es \(sesionUsuario?.email)")
        
        //cerrarSesion()
        
    }
    
    //Función para iniciar sesión añadiendo por parámetro el email y contraseña
    func iniciarSesion(withEmail email: String, password: String){
        
        //Inciamos sesión con el email y la contraseña en usuarios registrados en Firebase
        Auth.auth().signIn(withEmail: email, password: password){ resultado, error in
            
            //Si hay un error en el back-end
            /* if let error = error Esta estrucutura se denomina Optional binding,un tipo de vinculación opcional*, La condición de este if reside en que se pueda definir una constante apartir del valor que podría almacenar la variable opcional, caso contrario se ejecutaría el bloque else. Es decir, lo usa para verificar si el opcional ( erroren su caso) contiene un valor y, en caso afirmativo, para asignar ese valor a la constante vinculada ( en su caso) */
            /* -*La vinculación opcional nos permite verificar si un opcional contiene un valor y, si lo contiene, nos permite hacer que ese valor esté disponible en una variable.*/
            //Controlamos los errores al iniciar sesión
            if let error = error{
                //error.localizedDescription mensaje del error
                print("DEBUG: Error al iniciar sesión, el error es \(error.localizedDescription)")
                return
            }
            
            /* La senetencia guard sirve para transferir el control del programa fuera del alcance cuando no se cumplen ciertas condiciones.
             La declaración guard es similar a la declaración if con una gran diferencia. La instrucción if se ejecuta cuando se cumple una determinada condición. Sin embargo, la instrucción guard se ejecuta cuando no se cumple una determinada condición */
            /* result?.user  no encontramos con el encadenamiento opcional (o también optional chaining) es una característica que nos permite acceder a propiedades, métodos y subíndices de objetos que son opcionales, con lo cual podrían ser igual a nil
             A diferencia del desempaquetamiento forzado (forced unwrapping) que da lugar a una excepción en tiempo de ejecución cuando se encuentra con nil, el optional chaining ha sido diseñado para que siga con la ejecución del programa con un valor nil */
            /* Si el result no existe ningún usuario nos encontraremos con un nil al tratar de acceder a la propiedad que deseamos, porque de hecho no existirá instancia alguna. Para tener esta posibilidad bajo control tenemos el optional chaining en Swift, y este consiste en anteponer el signo de interrogación (?) al punto que nos da acceso a las propiedades y métodos de la instancia.
             De esta forma sino existe un usuario nos devolverá un nil, en caso contrario podremos acceder al objecto usuario */
            /* Obtenemos el usuario gracias result ya que es un objecto AuthDataResult el cual almacena el usuario. Además si existe el usuario se almacenará en la varible usuario */
            //Evaluamos si existe el usuario y almacenamos el usuario en una varible, en caso contrario saldrá de la función.
            guard let usuario = resultado?.user else{ return }
            //print("SUCESSFUL: Usuario que ha iniciado sesión es \(usuario.email)")
            //Guardamos el usuario que ha iniciado sesión
            self.sesionUsuario = usuario
            //Recargamos los datos del usuario logeado
            self.datosUsuario()

        }
        
    }
    
    //Función para registrar un usuario solo se almecenará en está función el email, nombre de usuario, el nombre completo,la fechaNacimiento y el id del usuario
    func registrarse(withEmial email: String, password: String, nombreCompleto: String, nombreUsuario: String, sexo: String, fechaNacimiento: String){
        
        //Registramos el usuaario según el email y contraseña añadida
        Auth.auth().createUser(withEmail: email, password: password){ resultado, error in
            
            //Si hay un error en la hora de registrar el usuario
            if let error = error{
                //error.localizedDescription mensaje del error
                print("DEBUG: Error al registrar el usuario, el error es \(error.localizedDescription)")
                return
            }
            
            //Evaluamos si el usuario se ha registrado correctamente y almacenamos el usuario en una varible, en caso contrario saldrá de la función.
            guard let usuario = resultado?.user else{ return }
            //Guardamos el usuario que ha registrado
            self.sesionUsuarioTemporal = usuario
            
            print("SUCESSFUL: La fecha del usuario es \(fechaNacimiento)")
            
            /* Creamos el array para almacenar los datos del usuario ha registrar */
            /* username.lowercased() obligamos que todos los nombres de usuario sean en minúsculas */
            let data = ["email": email,
                        "nombreUsuario": nombreUsuario.lowercased(),
                        "nombreCompleto": nombreCompleto ,
                        "sexo": sexo,
                        "fechaNacimiento": fechaNacimiento,
                        "uid": usuario.uid]
            //Seleccionamos la colección donde se guardará el usuario ha registrar
            Firestore.firestore().collection("usuarios")
            //NODO principal del documnto
                .document(usuario.uid)
            //Guardamos los datos del array del usuario en la base de datos
                .setData(data){ _ in
                    //Tras registrar el usuario se autentifica, por tanto ya pordrá subir su foto de perfil
                    self.usuarioAutentificado = true
                }
        }
    }
    
    /* Cerrar la sesión del usuario */
    func cerrarSesion(){
        
        //Hacemos que el valor de la sesión sea nulo para que de forma predeterminada al arrancar la aplicación muestra la pantalla de login si ha cerrado sesión
        sesionUsuario = nil
    
        //Cerrar la sesión en el servidor
         try? Auth.auth().signOut()
        
    }
    
    //Subir la foto de perfil del usuarioa registrar
    func subirImagenPerfil(_ image: UIImage){
        
        //Evaluamos si el usuario se ha autentificado correctamente y almacenamos el id usuario en una varible, en caso contrario saldrá de la función.
        guard let uid = sesionUsuarioTemporal?.uid else { return }
        
        SubirImagen.subirImagen(image: image){ UrlImagenPerfil in
            //Seleccionamos la colección donde se guardará el usuario ha registrar
            Firestore.firestore().collection("usuarios")
                //NODO principal del documnto, el cual debe coincidir con el id del documento
                .document(uid)
                //Subimos la imagen de perfil
                .updateData(["UrlImagenPerfil": UrlImagenPerfil]){ _ in
                    //Igualamos la sesión temporal a la sesión del usuario para almacenar las credenciales del usuario registrado
                    self.sesionUsuario = self.sesionUsuarioTemporal
                    //Recargar los datos
                    self.datosUsuario()
            }
        }
    }
    
    //Mostramos los datos del usuario
    func datosUsuario(){
        
        //Evaluamos si el usuario se ha autentificado correctamente y almacenamos el id usuario en una varible, en caso contrario saldrá de la función.
        guard let uid = self.sesionUsuario?.uid else{ return }
        
        //Llamamos a la función que nos proporciona los datos del usuario, la cual nos mostrará los datos del usuario en función de su id
        service.mostrarUsuario(withUid: uid){ usuario in
            //Guardamos el usuario que iniciado sesión, esto nos será util para mostrar o recargar los datos del usuario
            self.usuarioActual = usuario
        }
    }
    
    
    /*--- Validación del usuario---*/
    
    /* Guardar los datos del usuario validado */
    func guardarDatosPersonales(withUsuarioRegistro nombreCompleto:String, nombreUsuario:String, sexo:String, fechaNacimiento:String, email:String, password: String){
        
        /* Añadimos los datos del formulario al usuario */
        let usuarioRegistrar: UsuarioRegistro = UsuarioRegistro( nombreCompleto: nombreCompleto, nombreUsuario: nombreUsuario, sexo: sexo, fechaNacimiento: fechaNacimiento, email: email, password: password)
        
        /* Desempaquetamos el opcional */
        guard var usuario = self.usuarioRegistro else{ return }
        
        /* Igualamos el usuario registrado con el usuario desempaquetado */
        usuario = usuarioRegistrar
        
        print(usuario.nombreCompleto)
        print(usuario.fechaNacimiento)
        print(usuario.sexo)
        print(usuario.email)
        print(usuario.password)
        
        /* Igualamos a la variable de la clase */
        self.usuarioRegistro = usuario
        
        //Dirgirse a la siguiente vista
        self.usuarioValidado = true
        
    }
    
    
    /* Buscar el email en la base de datos nos devolverá un booleano si lo encuentra o no */
    func buscarEmail(withEmail email: String, completion:@escaping ((Bool)-> () )){
        
        Firestore.firestore().collection("usuarios").whereField("email".lowercased(), isEqualTo: email.lowercased()).getDocuments{ (resultado, error) in
            
            if let error = error{
                
                print("Error")
                completion(false)
                
            }else{
                
                if (resultado!.count > 0){
                    
                    completion(true)
                    print("Email encontrado")
                    
                }else{
                    
                    completion(false)
                    print("Email NO encontrado")
                }
                
            }
            
        }
    }
    /* Buscar el nombre de usuario en la base de datos nos devolverá un booleano si lo encuentra o no */
    func buscarNombreUsuario(withNombreUsuario nombreUsuario: String, completion:@escaping ((Bool)-> () )){
        
        
        Firestore.firestore().collection("usuarios").whereField("nombreUsuario", isEqualTo: nombreUsuario).getDocuments{ (resultado, error) in
            
            if let error = error {
                
                
                print("Error")
                completion(false)
                
            }else{
                
                if (resultado!.count > 0){
                    
                    completion(true)
                    print("nombreUsuario encontrado")
                    
                }else{
                    
                    completion(false)
                    print("nombreUsuario NO encontrado")
                }
                
            }
            
        }
    }
    
    
}



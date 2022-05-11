//
//  FBFireStore.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-18.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//
import FirebaseFirestore


/*  Clase permite recuparar el usuario una vez esté autentificado e inyectarlo a al variable de entorno que utilizamos en toda la aplicación*/
enum FBFirestore {

    /* (Result<FBUser, Error>) -> () me devuelve un usuario o un error. Los errores que nos devuelvan los trateremos con la clase FBFireStoreError */
    static func retrieveFBUser(uid: String, completion: @escaping (Result<FBUser, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
        //Tratamiento de documentos se realiza en la función getDocument()
        getDocument(for: reference) { (result) in
            switch result {
            case .success(let data):
               //Se realiza el tratamiento de errores si lo hay
                guard let user = FBUser(documentData: data) else {
                    //Mostramos el error
                    completion(.failure(FireStoreError.noUser))
                    return
                }
                completion(.success(user))
            case .failure(let err):
                completion(.failure(err))
            }
        }
        
    }
    
    //Nos devolverá un error si no se ha realizado correctamente, esto será útil en la creación de usuarios
    /*  (Result<Bool, Error>) -> () controlador de finalización */
    static func mergeFBUser(_ data: [String: Any], uid: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        let reference = Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
        
        reference.setData(data, merge: true) { (err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
        }
    }
    
    /* Tratamiento de documentos
     Result<[String : Any Para crear el diccionario del usuario  en el caso que no hay errores */
    fileprivate static func getDocument(for reference: DocumentReference, completion: @escaping (Result<[String : Any], Error>) -> ()) {
        reference.getDocument { (documentSnapshot, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let documentSnapshot = documentSnapshot else {
                completion(.failure(FireStoreError.noDocumentSnapshot))
                return
            }
            guard let data = documentSnapshot.data() else {
                completion(.failure(FireStoreError.noSnapshotData))
                return
            }
            completion(.success(data))
        }
    }
    
    static func deleteUserData(uid: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        let reference = Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
        reference.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}

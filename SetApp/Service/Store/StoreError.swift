//
//  StoreError.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 6/5/22.
//

import Foundation

// MARK: - FireStore errores
/* Esta clase sirve para recopilar los errores y personalizar los mensajes de error */
/* Lista de todos los errores que se va a tratar */
enum StoreError: Error {
    
    case noAuthDataResult
    case noCurrentUser
    case noDocumentSnapshot
    case noSnapshotData
    case noUser
    
}

extension StoreError: LocalizedError {
    //Este es el provedor de los errores
    var errorDescription: String? {
        switch self {
        case .noAuthDataResult:
            return NSLocalizedString("No Auth Data Result", comment: "")
        case .noCurrentUser:
            return NSLocalizedString("No Current User", comment: "")
        case .noDocumentSnapshot:
            return NSLocalizedString("No Document Snapshot", comment: "")
        case .noSnapshotData:
            return NSLocalizedString("No Snapshot Data", comment: "")
        case .noUser:
            return NSLocalizedString("No User", comment: "")
        }
    }
}

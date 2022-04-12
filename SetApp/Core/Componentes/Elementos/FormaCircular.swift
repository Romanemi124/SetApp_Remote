//
//  RoundedShape.swift
//  TwitterSwiftUI
//
//  Created by Omar Bonilla Varela on 4/4/22.
//

import SwiftUI

struct FormaCircular: Shape{
    
    var corner: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: 80, height: 80))
        return Path(path.cgPath)
    }
    
}

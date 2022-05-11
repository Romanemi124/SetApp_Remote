//
//  StaggeredGrid.swift
//  SetApp
//
//  Created by Emilio Roman on 9/5/22.
//

import SwiftUI

struct StaggeredGrid<Content: View,T: Identifiable>: View where T:Hashable {
    
    var content: (T) -> Content
    var list: [T]
    
    //Propiedades del ScrollView
    var showsIndicators: Bool
    var spacing: CGFloat
    
    //Para establecer las columnas de la vista
    var columns: Int
    
    //Para las funciones principales de efecto del StaggeredGrid
    func setUpList()->[[T]] {
        
        //Creamos arrays para las distintos tipos de columnas que pueden haber en la vista
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        var currentIndex: Int = 0
        
        for object in list {
            
            gridArray[currentIndex].append(object)
            
            //Incrementamos el contador una vez se vaya pulsando el botón de incrementar
            if currentIndex == (columns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    init(colums: Int, showsIndicators:Bool = false, spacing:CGFloat = 10, list: [T], @ViewBuilder content: @escaping (T)->Content)  {
        self.content = content
        self.list  = list
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.columns = colums
    }
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.vertical, showsIndicators: showsIndicators) {
                
                HStack(alignment: .top) {
                    
                    ForEach(setUpList(), id: \.self) { columsData in
                        
                        LazyVStack(spacing: spacing) {
                            
                            ForEach(columsData) { object in
                                content(object)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .background(Color(red: 0.331, green: 0.074, blue: 0.423))
    }
}

/*
struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredGrid()
    }
}
*/

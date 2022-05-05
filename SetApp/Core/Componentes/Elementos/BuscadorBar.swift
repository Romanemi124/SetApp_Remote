//
//  BuscadorBar.swift
//  SetApp
//
//  Created by Omar Bonilla Varela on 3/5/22.
//

import SwiftUI

struct BuscadorBar: View {
    
    @Binding var texto: String
    
    var body: some View {
        HStack{
            TextField("Search...",text: $texto)
                .padding(8)
                .padding(.horizontal,24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay{
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                }
        }
        .padding(.horizontal,4)
    }
}

struct BuscadorBar_Previews: PreviewProvider {
    
    static var previews: some View {
        BuscadorBar(texto: .constant(""))
            .previewLayout(.sizeThatFits)
    }

}

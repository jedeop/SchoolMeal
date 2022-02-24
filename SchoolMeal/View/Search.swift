//
//  Search.swift
//  SchoolMeal
//

import SwiftUI

struct Search: View {
    @Binding var search: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
            TextField("검색", text: $search)
        }
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(10)

    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(search: .constant(""))
    }
}

//
//  SchoolSelect.swift
//  SchoolMeal
//

import SwiftUI

struct SchoolSelect: View {
    @Binding var select: Int
    @Binding var show: Bool
    @State private var searchText = ""
    
    private var filteredSchools: [School] {
        schools.filter { searchText.isEmpty || $0.name.contains(searchText) }
    }
    
    var body: some View {
        VStack {
            Search(search: $searchText)
                .padding([.top, .leading, .trailing])
            ScrollView {
                LazyVStack(spacing: 5.0) {
                    Section {
                        ForEach(filteredSchools) { school in
                            Divider()
                            Button {
                                select = schools.firstIndex(where: {$0.id == school.id})!
                                show = false
                            } label: {
                                SchoolRow(school: school)
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SchoolSelect_Previews: PreviewProvider {
    static var previews: some View {
        SchoolSelect(select: .constant(0), show: .constant(true))
    }
}

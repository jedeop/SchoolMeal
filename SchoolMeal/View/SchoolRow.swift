//
//  SchoolRow.swift
//  SchoolMeal
//

import SwiftUI

struct SchoolRow: View {
    var school: School
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(school.name)
                Text(school.location)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct SchoolRow_Previews: PreviewProvider {
    static var previews: some View {
        SchoolRow(school: schools[2])
    }
}

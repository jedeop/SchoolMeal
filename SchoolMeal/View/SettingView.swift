//
//  SettingView.swift
//  SchoolMeal
//

import SwiftUI

struct SettingView: View {
    @State private var showSchoolSelect = false
    @AppStorage("school") private var schoolIndex = 0
    private var school: School {
        schools[schoolIndex]
    }
    
    var body: some View {
        NavigationView {
            List {
                Button {
                    showSchoolSelect.toggle()
                } label: {
                    HStack {
                        Text("학교")
                            .foregroundColor(.primary)
                        Spacer()
                        Text(school.name)
                            .foregroundColor(.secondary)
                    }
                }
                .sheet(isPresented: $showSchoolSelect) {
                    SchoolSelect(select: $schoolIndex, show: $showSchoolSelect)
                }
            }
            .navigationTitle("설정")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

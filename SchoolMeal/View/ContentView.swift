//
//  ContentView.swift
//  SchoolMeal
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .meal
    
    enum Tab {
        case meal
        case setting
    }
    
    var body: some View {
        TabView(selection: $selection) {
            MealView()
                .tabItem {
                    Label("급식", systemImage: "tray")
                }
                .tag(Tab.meal)
            
            SettingView()
                .tabItem {
                    Label("설정", systemImage: "person")
                }
                .tag(Tab.setting)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

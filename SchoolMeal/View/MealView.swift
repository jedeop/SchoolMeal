//
//  MealView.swift
//  SchoolMeal
//

import SwiftUI

struct MealView: View {
    private var mealFetcher = MealFetcher(key: Bundle.main.infoDictionary?["API_KEY"] as! String)
    
    @State private var dishes: [Dish]? = nil
    @State private var date = Date()
    @AppStorage("school") private var schoolIndex: Int = 0
    private var school: School {
        schools[schoolIndex]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    DatePicker(selection: $date, displayedComponents: .date){
                        Text("날짜")
                    }
                    .onChange(of: date) { newDate in
                        mealFetcher.getMeal(school: school, date: newDate) { meal in
                            dishes = meal?.dishes
                        }
                    }
                    .environment(\.locale, Locale(identifier: "ko-KR"))
                    
                    Button("오늘") {
                        date = Date.now
                    }
                }
                .padding(.horizontal, 20)
                
                List {
                    if let dishes = dishes {
                        ForEach(dishes) { dish in
                            Text(dish.name)
                        }
                    } else {
                        Text("정보 없음")
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("급식")
        }
        .onAppear {
            mealFetcher.getMeal(school: school, date: date) { meal in
                dishes = meal?.dishes
            }
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}

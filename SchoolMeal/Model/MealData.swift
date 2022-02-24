//
//  MealInfo.swift
//  SchoolMeal
//

import Foundation
import Alamofire

struct MealFetcher {
    private let key: String
    private var dateFormatter: DateFormatter
    
    init(key: String) {
        self.key = key
        self.dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
    }
    
    private struct MealParameter: Encodable {
        let KEY: String
        let `Type`: String = "json"
        let ATPT_OFCDC_SC_CODE: String
        let SD_SCHUL_CODE: String
        let MMEAL_SC_CODE: String = "2"
        var MLSV_YMD: String
        
        init(key: String, school: School, date: String) {
            KEY = key
            ATPT_OFCDC_SC_CODE = school.office
            SD_SCHUL_CODE = school.id
            MLSV_YMD = date
        }
    }
    
    func getMeal(school: School, date: Date, completionHandler: @escaping (Meal?) -> Void) {
        let parameters = MealParameter(key: key, school: school, date: self.dateFormatter.string(from: date))
        AF.request("https://open.neis.go.kr/hub/mealServiceDietInfo", method: .get, parameters: parameters).responseDecodable(of: MealResponse.self) { response in
            if case let .data(data) = response.value?.mealServiceDietInfo[1] {
                completionHandler(data.row[0])
            } else {
                completionHandler(nil)
            }
        }
    }
}

struct MealResponse: Decodable {
    let mealServiceDietInfo: [FetchResult]
    
}

enum FetchResult: Decodable {
    case data(Meals)
    case none
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let data = try? container.decode(Meals.self) {
            self = .data(data)
        } else {
            self = .none
        }
    }
}

struct Meals: Decodable {
    let row: [Meal]
}

struct Meal: Decodable {
    let MLSV_YMD: String //급식일자
    let DDISH_NM: String //요리명
    let ORPLC_INFO: String // 원산지정보
    let CAL_INFO: String // 칼로리정보
    let NTR_INFO: String // 영양정보
    
    var dishes: [Dish] {
        DDISH_NM.components(separatedBy: "<br/>").map({ dish in
            Dish(name: dish)
        })
    }
}

struct Dish: Identifiable {
    var id = UUID()
    var name: String
}

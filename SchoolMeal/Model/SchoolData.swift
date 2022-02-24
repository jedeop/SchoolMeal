//
//  SchoolData.swift
//  SchoolMeal
//

import Foundation

let schools: [School] = load_csv("schoolData.csv")

struct School: Identifiable {
    let office: String
    let id: String
    let name: String
    let location: String
    
    init(_ school: [String]) {
        office = school[0]
        id = school[1]
        name = school[2]
        location = school[3]
    }
}

func load_csv(_ filename: String) -> [School] {
    let data: String

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try String(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    return data.components(separatedBy: "\r\n").dropFirst()
        .map { School($0.components(separatedBy: ",")) }
}

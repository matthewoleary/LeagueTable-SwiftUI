//
//  Services.swift
//  PremierLeagueTable
//
//  Created by Matthew O'Leary on 28/07/2022.
//

import Foundation

struct Services {
    static func loadJson<T: Decodable>(file fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
        do {
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            return jsonData
        } catch {
            print("Error: \(error)")
        }
        return nil
    }
}

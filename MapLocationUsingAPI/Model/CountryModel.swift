//
//  CountryModel.swift
//  MapLocationUsingAPI
//
//  Created by Aniket Patil on 21/05/24.
//

import Foundation
import MapKit

struct Country: Identifiable, Codable,Equatable {
    let name: Name
    let region: String
    let latlng: [Double]
    let flags: Flags

    var id: String {
        name.common + region
    }

    struct Name: Codable {
        let common: String
    }

    struct Flags: Codable {
        let png: String
    }
    
    static func == (lhs: Country, rhs: Country) -> Bool {
            lhs.id == rhs.id
        }
}


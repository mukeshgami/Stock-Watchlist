//
//  Stock.swift
//  Stock
//
//  Created by Mukesh Gami on 27/05/21.
//

import Foundation

struct Stock: Codable {
    let symbol: String
    let shortName: String
    let regularMarketPrice: Double
    let regularMarketChange: Double
    let regularMarketChangePercent: Double
}




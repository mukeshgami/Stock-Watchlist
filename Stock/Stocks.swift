//
//  Stocks.swift
//  Stock
//
//  Created by Mukesh Gami on 28/05/21.
//

import Foundation

struct StocksResponse: Codable {
    let quoteResponse: Stocks
}

struct Stocks: Codable {
    let result: [Stock]
}

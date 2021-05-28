//
//  NetworkHandler.swift
//  Stock
//
//  Created by Mukesh Gami on 28/05/21.
//

import Foundation

func fetchStocks(completion: @escaping ([Stock]) -> Void) {
    var stocks = [Stock]()
    let headers = [
        "x-rapidapi-key": "b7cd245b51mshd6ffa85eb9ee061p1fa673jsn121c9ee5b342",
        "x-rapidapi-host": "apidojo-yahoo-finance-v1.p.rapidapi.com"
    ]

    let request = NSMutableURLRequest(url: NSURL(string: "https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes?region=US&symbols=AMD%2CIBM%2CAAPL%2CAPPS%2CDOYU%2CPLUG%2CNIO")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if error == nil && data != nil {
            stocks = parse(json: data!)
            completion(stocks)
        }else {
            completion(stocks)
            print("error: ", error.debugDescription)
        }
    })

    dataTask.resume()
    
}

func parse(json: Data) -> [Stock] {
    var stocks = [Stock]()
    let decoder = JSONDecoder()
    
    do {
        let jsonStocks = try decoder.decode(StocksResponse.self, from: json)
        stocks = jsonStocks.quoteResponse.result
    } catch {
        print("error on decode: \(error.localizedDescription)")
    }
    
    return stocks
}

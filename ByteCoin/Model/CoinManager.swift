//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let fiat = "USD"
    let apiKey = ""
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func performRequest(fiat: String){
        if let url = URL(string: "\(baseURL)/\(fiat)?apikey=\(apiKey)"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    delegate?.didGetError(error!)
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    let parsedData = try JSONDecoder().decode(Coin.self, from: data)
                    let coinData = Coin(rate: parsedData.rate)
                    delegate?.didUpdatePrice(coinData)
                
                } catch  {
                    delegate?.didGetError(error)
                }
                
                
            }
            task.resume()
        }
    }
    
}

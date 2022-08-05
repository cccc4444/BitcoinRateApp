//
//  CoinManagerDelegate.swift
//  BitcoinPriceChecker
//
//  Created by Danylo Kushlianskyi on 05.08.2022.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdatePrice(_ coinData: Coin)
    func didGetError(_ error: Error)
}

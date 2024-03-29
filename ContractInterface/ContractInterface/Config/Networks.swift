//
//  Networks.swift
//  ContractInterface
//
//  Created by Quincy Jones on 7/8/23.
//

import Foundation

struct NetworkInfo: Codable {
    let name: String
    let symbol: String
    let rpcPrimary: String
    let rpcFailover: String
    let rpcTestnet: String
    let priceFeed: String
}

enum NetworkRPC {
    case primary
    case failover
    case testnet
}
/**
 Extracts the names and symbols from a JSON string representing network RPC information.
 - Parameters:
    - jsonString: The JSON string containing the network RPC information.
 - Returns:
    A tuple containing two arrays: `names` and `symbols`. If the JSON string is successfully decoded and the necessary data is extracted, the function returns the tuple. Otherwise, it returns `nil`.
 - Note:
    The JSON string should follow a specific format with the following structure:
    ```
    [
      {
        "name": "Network Name",
        "symbol": "Network Symbol",
        "rpcPrimary": "Primary RPC URL",
        "rpcFailover": "Failover RPC URL",
        "rpcTestnet": "Testnet RPC URL",
        "priceFeed": "Price Feed URL"
      },
      // ... (more network RPC information objects)
    ]
    ```
    The `name` and `symbol` fields are mandatory for each network RPC information object.
    - `name`: The name of the network.
    - `symbol`: The symbol or ticker of the network.
    - `rpcPrimary`: The primary RPC URL for the network.
    - `rpcFailover`: The failover RPC URL for the network.
    - `rpcTestnet`: The testnet RPC URL for the network.
    - `priceFeed`: The URL for the price feed API of the network.
*/
func extractNamesAndSymbols(jsonString: String) -> (names: [String], symbols: [String])? {
    guard let jsonData = jsonString.data(using: .utf8) else {
        return nil
    }
    
    do {
        let networkRPCs = try JSONDecoder().decode([NetworkInfo].self, from: jsonData)
        let names = networkRPCs.map { $0.name }
        let symbols = networkRPCs.map { $0.symbol }
        return (names, symbols)
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}

/// Parses the network information JSON data and retrieves the RPC endpoints for the specified symbol and network type.
/// - Parameters:
///   - symbol: The symbol of the network.
///   - network: The type of network RPC endpoint to retrieve.
/// - Returns: A tuple of strings representing the RPC endpoints, or nil if the network information is not found.
func parseNetworkInfo(symbol: String, network: NetworkRPC) -> (String, String, String, String)? {
    guard let jsonData = networkRPCs.data(using: .utf8) else {
        fatalError("Failed to convert JSON string to data.")
    }
    let decoder = JSONDecoder()
    do {
        let networkInfoArray = try decoder.decode([NetworkInfo].self, from: jsonData)
        
        for networkInfo in networkInfoArray {
            if networkInfo.symbol == symbol {
                switch network {
                case .primary:
                    return (networkInfo.name, networkInfo.symbol, networkInfo.rpcPrimary, networkInfo.priceFeed)
                case .failover:
                    return (networkInfo.name, networkInfo.symbol, networkInfo.rpcFailover, networkInfo.priceFeed)
                case .testnet:
                    return (networkInfo.name, networkInfo.symbol, networkInfo.rpcTestnet, networkInfo.priceFeed)
                }
            }
        }
    } catch {
        print("Error parsing JSON: \(error)")
    }
    return nil
}

let xdcNetworkContracts:[String] = []
let ganachehNetworkContracts:[String] = ["0x8fBf99110408C29d0E2fe19B58B39b2078b6B87b","0x078c1ed4ff59C60D80e0dd908aDeaA8095D8EcF5"]
// JSON data containing the network information
let tokens = """
    [
      {
      "address": "0x8fBf99110408C29d0E2fe19B58B39b2078b6B87b",
      "network": "Ganache",
      "standard": "ERC20",
      "decimals": 0
      },
      {
      "address": "0x078c1ed4ff59C60D80e0dd908aDeaA8095D8EcF5",
      "network": "Ganache",
      "standard": "ERC20",
      "decimals": 0
      }
    ]
"""
let networkRPCs = """
    [
      {
        "name": "XDC Network",
        "symbol": "XDC",
        "rpcPrimary": "https://rpc.XDC.org",
        "rpcFailover": "https://rpc.xinfin.network",
        "rpcTestnet": "https://rpc.apothem.network",
        "priceFeed": "https://api.coingecko.com/api/v3/simple/price?ids=xdce-crowd-sale&vs_currencies=usd"
      },
      {
        "name": "Ganache",
        "symbol": "Ganache",
        "rpcPrimary": "HTTP://127.0.0.1:8545",
        "rpcFailover": "HTTP://127.0.0.1:8546",
        "rpcTestnet": "HTTP://127.0.0.1:8547",
        "priceFeed": "https://api.coingecko.com/api/v3/simple/price?ids=xdce-crowd-sale&vs_currencies=usd"
      }
    ]
"""



//{
//  "name": "Binance Smart Chain Mainnet",
//  "symbol": "BSB",
//  "rpcPrimary": "https://bsc-dataseed.binance.org",
//  "rpcFailover": "https://bsc-dataseed1.defibit.io",
//  "rpcTestnet": "https://data-seed-prebsc-1-s1.binance.org:8545",
//  "priceFeed": "https://api.coingecko.com/api/v3/simple/price?ids=xdce-crowd-sale&vs_currencies=usd"
//},
//{
//  "name": "Polygon Mainnet",
//  "symbol": "MATIC",
//  "rpcPrimary": "https://rpc-mainnet.maticvigil.com",
//  "rpcFailover": "https://polygon-rpc.com",
//  "rpcTestnet": "https://rpc-mumbai.matic.today",
//  "priceFeed": "https://api.coingecko.com/api/v3/simple/price?ids=xdce-crowd-sale&vs_currencies=usd"
//},
//{
//  "name": "Ethereum Classic Mainnet",
//  "symbol": "ETC",
//  "rpcPrimary": "https://ethereumclassic.network",
//  "rpcFailover": "https://ethereumclassic.network",
//  "rpcTestnet": "https://kotti.ethereumclassic.network",
//  "priceFeed": "https://api.coingecko.com/api/v3/simple/price?ids=xdce-crowd-sale&vs_currencies=usd"
//},
//{
//  "name": "ETH",
//  "symbol": "ETH",
//  "rpcPrimary": "https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID",
//  "rpcFailover": "https://eth-mainnet.alchemyapi.io/v2/YOUR_ALCHEMY_API_KEY",
//  "rpcTestnet": "https://ropsten.infura.io/v3/YOUR_INFURA_PROJECT_ID",
//  "priceFeed": "https://api.coingecko.com/api/v3/simple/price?ids=xdce-crowd-sale&vs_currencies=usd"
//},

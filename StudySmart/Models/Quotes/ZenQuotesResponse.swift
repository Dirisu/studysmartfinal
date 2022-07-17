//
//  ZenQuotesResponse.swift
//  StudySmart
//
//  Created by Marvellous Dirisu on 15/07/2022.
//

import Foundation

struct ZenQuotesResponse : Codable {
    let quote : String
    let author : String
    let blockQuote : String
    
    enum CodingKeys : String, CodingKey {
        case quote = "q"
        case author = "a"
        case blockQuote = "h"
    }
}

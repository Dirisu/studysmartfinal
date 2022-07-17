//
//  ZenQuotesClient.swift
//  StudySmart
//
//  Created by Marvellous Dirisu on 15/07/2022.
//

import Foundation
class ZenQuotesClient {
    
    enum Endpoints {
        case randomQuote
        
        var stringValue : String {
            switch self {
            case .randomQuote :
                return "https://zenquotes.io/api/random"
            }
        }
        
        var url : URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGetRequest <ResponseType : Decodable> (url : URL, responseType : ResponseType.Type, completion : @escaping ([ResponseType]?, Error?)->Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // if theres an error
            if error != nil {
                completion(nil, error)
            }
            
            guard let data = data else {
                
                DispatchQueue.main.async {
                    completion([], error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode([ResponseType].self, from: data)
                
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
                
            } catch  {
                DispatchQueue.main.async {
                    completion([], error)
                }
            }
        }
        
        task.resume()
    }
    
    class func getRandomQuotes(completion : @escaping (ZenQuotesResponse?, Error?) -> Void) {
        
        taskForGetRequest(url: Endpoints.randomQuote.url, responseType: ZenQuotesResponse.self) { response, error in
            
            if let response = response {
                
                for quote in response {
                    completion(quote, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
}

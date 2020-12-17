//
//  QuoteManager.swift
//  Quotery
//
//  Created by Admin on 12/3/20.
//

import UIKit

protocol QuoteManagerDelegate {
    func didUpdateQuote(_ quoteManager: QuoteManager, quote: QuoteModel)
    func didFailWithError(error: Error)
}

struct QuoteManager {
    
    var delegate: QuoteManagerDelegate?
    
    func performRequest(){
    //URL
        let url = URL(string: "https://quotes-by-quovoo1.p.rapidapi.com/quotes/random?numberOfResults=1")
        
        guard url != nil else {
        print("Error")
        return
        }
    //URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
    
    //Specify the header
        let headers = [
            "x-rapidapi-key": "7e5cc04f81mshd0483de70fbc1d5p16b2d4jsnc6d01b111ae9",
            "x-rapidapi-host": "quotes-by-quovoo1.p.rapidapi.com",
            //"content-type": "application/json"
        ]
        
        request.allHTTPHeaderFields = headers
        
        // Specify the body
    

    // Set the request type
        request.httpMethod = "GET"
    // Get the URLSession
        let session = URLSession.shared
    // Create the data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // Check for errors
            
            if error == nil && data != nil {
                if let safeData = data {
                    if let quote = self.parseJSON(safeData) {
                        self.delegate?.didUpdateQuote(self, quote: quote)
                    }
                }
            }
        }
    //Fire off the data task
        dataTask.resume()
    }
    
    func parseJSON(_ quoteData: Data) -> QuoteModel? {
        //print(String(data: quoteData, encoding: .utf8))
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([QuoteData].self, from: quoteData)
            let quote = decodedData[0].content
            let author = decodedData[0].author
            
            let quoteModel = QuoteModel(quoteText: quote, authorText: author)
            
            UserDefaults.standard.setValue(quote, forKey: Constants.Defaults.LATEST_QUOTE)
            UserDefaults.standard.setValue(author, forKey: Constants.Defaults.LATEST_AUTHOR)
            //print(quoteModel)
            return quoteModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}




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
        let url = URL(string: "https://quotes.rest/qod?language=en")
        
        guard url != nil else {
        print("Error")
        return
        }
    //URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
    
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
     
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(QuoteData.self, from: quoteData)
            let quote = decodedData.contents.quotes[0].quote
            let author = decodedData.contents.quotes[0].author
            
            let quoteModel = QuoteModel(quoteText: quote, authorText: author)
            
            UserDefaults.standard.setValue(quote, forKey: Constants.Defaults.LATEST_QUOTE)
            UserDefaults.standard.setValue(author, forKey: Constants.Defaults.LATEST_AUTHOR)
           
            return quoteModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}




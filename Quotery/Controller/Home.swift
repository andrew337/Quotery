//
//  ViewController.swift
//  Quotery
//
//  Created by Admin on 12/1/20.
//

import UIKit
import FontAwesome_swift

class Home: UIViewController, QuoteManagerDelegate {
    
    var quoteManager = QuoteManager()

    
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        quoteManager.delegate = self
        
        menuButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 21, style: .solid)
        menuButton.setTitle(String.fontAwesomeIcon(name: .bars), for: .normal)
        nextButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 21, style: .solid)
        nextButton.setTitle(String.fontAwesomeIcon(name: .arrowRight), for: .normal)
        
        quoteLabel.text = "jfhhghs ghgggggggg gjpjsgjdgkdsjgijdsipgj gjpdsjgpidsjgpidsjg gjipsdjipgjpsd opjgsjpisgjps pijgpsjhpigj "
    
    }
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        quoteManager.performRequest()
    }
    
    func didUpdateQuote(_ quoteManager: QuoteManager, quote: QuoteModel) {
        DispatchQueue.main.async {
            self.quoteLabel.text = quote.quoteText
            self.authorLabel.text = quote.authorText
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}



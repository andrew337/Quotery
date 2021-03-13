//
//  ViewController.swift
//  Quotery
//
//  Created by Admin on 12/1/20.
//

import UIKit
import FontAwesome_swift

class HomeViewController: UIViewController, QuoteManagerDelegate {
    
    var quoteManager = QuoteManager()
    let userDefaults = UserDefaults()
    let refreshManager = RefreshManager()
    let calender = Calendar.current
    
    private var observor: NSObjectProtocol?
    
    
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        quoteManager.delegate = self
        favoritesButton.alpha = 0
        
        menuButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 21, style: .solid)
        menuButton.setTitle(String.fontAwesomeIcon(name: .bars), for: .normal)
        favoritesButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 21, style: .solid)
        favoritesButton.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        
        if userDefaults.value(forKey: Constants.Defaults.LATEST_QUOTE) != nil {
            loadDataIfNeeded { (success) in
                print(success)
            }
        } else {
            quoteManager.performRequest()
        }
        
        observor = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main, using: { [unowned self] notification in
            self.createTimer()
        })
        
        
    }
    
    
    
    func createTimer() {
        _ = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        if isRefreshRequired() == true {
            quoteManager.performRequest()
            print("yes")
        }
        
    }
    
    func didUpdateQuote(_ quoteManager: QuoteManager, quote: QuoteModel) {
        DispatchQueue.main.async {
            self.quoteLabel.text = quote.quoteText
            self.authorLabel.text = "Author:   \(quote.authorText)"
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    @IBAction func menuButton(_ sender: UIButton) {
        
        let vc1 = self.storyboard!.instantiateViewController(identifier: "Settings")
        let navController = UINavigationController(rootViewController: vc1)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
        
    }
    func loadDataIfNeeded(completion: (Bool) -> Void) {
        
        if isRefreshRequired() {
            quoteManager.performRequest()
            quoteLabel.text = userDefaults.value(forKey: Constants.Defaults.LATEST_QUOTE) as? String
            authorLabel.text =  "Author: \(userDefaults.value(forKey: Constants.Defaults.LATEST_AUTHOR) as! String)"
            completion(true)
        } else {
            quoteLabel.text = userDefaults.value(forKey: Constants.Defaults.LATEST_QUOTE) as? String
            authorLabel.text =  "Author: \(userDefaults.value(forKey: Constants.Defaults.LATEST_AUTHOR) as! String)"
            completion(false)
        }
    }
    
    func isRefreshRequired() -> Bool {
        
        guard let lastRefreshDate = userDefaults.object(forKey: Constants.Defaults.LATEST_REQUEST_TIME) as? Date else {
            return true
        }
        
        if let diff = calender.dateComponents([.minute], from: lastRefreshDate, to: Date()).minute, diff > 2 {
            return true
        } else {
            return false
        }
    }
    
    
}



//
//  Settings.swift
//  Quotery
//
//  Created by Admin on 12/17/20.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    private let reuseIdentifier = "SettingsCell"
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        configureUI()
    }
    
    
    func configure() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        //tableView.backgroundColor = UIColor(red: 40/255, green: 56/255, blue: 69/255, alpha: 1)

        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.tableFooterView = UIView()
    }
    
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 128/255, green: 100/255, blue: 77/255, alpha: 1)
        navigationItem.title = "Settings"
        
        let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backToFirst))
        backButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backToFirst() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else {return 0}
        
        switch section {
        //case .Social: return SocialOptions.allCases.count
        case .Communications: return CommunicationsOptions.allCases.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 216/255, green: 189/255, blue: 118/255, alpha: 1)
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view 
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        cell.contentView.isUserInteractionEnabled = false
        cell.backgroundColor = UIColor(red: 128/255, green: 100/255, blue: 77/255, alpha: 1)
        cell.switchControl.tag = indexPath.row
            let communications = CommunicationsOptions(rawValue: indexPath.row)
            cell.textLabel?.text = communications?.description
        
        
        return cell
    }
}

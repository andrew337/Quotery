//
//  SettingsCell.swift
//  Quotery
//
//  Created by Admin on 12/17/20.
//

import UIKit
import UserNotifications


class SettingsCell: UITableViewCell {
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.onTintColor = UIColor(red: 55/255, green: 130/255, blue: 250/255, alpha: 1)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(switchControl)
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            //fatalError("init(coder:)  has not been implemented")
        }
    
    @objc func handleSwitchAction(sender: UISwitch) {
        switch sender.tag {
        case 0:
            if sender.isOn {
                print("on")
            } else {
                print("off")
            }
        case 1:
            print("Button 2")
        default:
            print("Nothing")
        }
    }

}

//
//  ViewController.swift
//  SPopup
//
//  Created by Sunil Verma on 24/05/24.
//

import UIKit


enum SMenuType: Int, CaseIterable {
    case myProfile = 0
    case helpAndSupport
    case termsAndConditions
    case privacyPolicy
    case logout
    
    var popupMenu: SPopModel {
        switch self {
        case .myProfile:
            return SPopModel(id: "\(self.rawValue)", name: "My Profile", imageName: "profile")
        case .helpAndSupport:
            return SPopModel(id: "\(self.rawValue)", name: "Help and Support", imageName: "help")
        case .termsAndConditions:
            return SPopModel(id: "\(self.rawValue)", name: "Terms and Conditions", imageName: "terms_and_service_icon")
        case .privacyPolicy:
            return SPopModel(id: "\(self.rawValue)", name: "Privacy Policy", imageName: "privacy_icon")
        case .logout:
            return SPopModel(id: "\(self.rawValue)", name: "Logout", imageName: "logout")
        }
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func listTextTapped(sender: UIButton) {
        
        let data = SMenuType.allCases.map { menu in
            return menu.popupMenu
        }
        SPopupVC.presentPoup(data: data, controller: self, sender: sender) { model in
            
        }
    }
    
    @IBAction func listTextWithIconTapped(sender: UIButton) {
        
        let data = SMenuType.allCases.map { menu in
            return menu.popupMenu
        }
       
        SPopupVC.presentPoup(data: data, cellType: .textWithIcon, controller: self, sender: sender, preferedSize: CGSize(width: 240, height: 400)) { selectedItem in
            if let item  = selectedItem {
                DispatchQueue.main.async {
                    let type = SMenuType(rawValue: Int(item.id) ?? 0) ?? .myProfile
                    print(type)
                }
            }
        }
    }

    @IBAction func listMultiSelectionTapped(sender: UIButton) {
        let data = SMenuType.allCases.map { menu in
            return menu.popupMenu
        }
       
        SPopupVC.presentPoup(data: data, cellType: .multiSelection, controller: self, sender: sender, preferedSize: CGSize(width: 240, height: 400)) { selectedItem in
            if let item  = selectedItem {
                DispatchQueue.main.async {
                    let type = SMenuType(rawValue: Int(item.id) ?? 0) ?? .myProfile
                    print(type)
                }
            }
        }
    }
}


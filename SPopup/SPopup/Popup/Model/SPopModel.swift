//
//  SPopModel.swift
//  SPopup
//
//  Created by Sunil Verma on 24/05/24.
//

import UIKit


class SPopModel {
    var id: String = ""
    var name: String = ""
   
    var imageName: String = ""
    var isSelected: Bool = true
    
    var asImage: UIImage? {
        return UIImage.init(named: imageName)
    }
    
    var asCheckImage: UIImage? {
        if isSelected {
            return UIImage.init(named: "filledCheckbox")
        }else {
            return UIImage.init(named: "emptyCheckbox")
        }
    }
    
    
    init(id: String, name: String, imageName: String = "", isSelected: Bool = true) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.isSelected = isSelected
    }
    
    static func == (lhs: SPopModel, rhs: SPopModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

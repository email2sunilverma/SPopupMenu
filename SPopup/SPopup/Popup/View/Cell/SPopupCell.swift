//
//  SPopupCell.swift
//  SPopup
//
//  Created by Sunil Verma on 24/05/24.
//

import UIKit

class SPopupCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel?
    @IBOutlet weak var checkBtn: UIButton?
    @IBOutlet weak var bgView: UIView?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

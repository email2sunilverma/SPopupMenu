//
//  SPopupVC.swift
//  SPopup
//
//  Created by Sunil Verma on 24/05/24.
//

import UIKit

typealias PopupCompletionBlock = (SPopModel?) -> Void

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}
enum SPopupCellType: Int {
    case text
    case textWithIcon
    case multiSelection
    
    var cellIdentifire: String {
        switch self {
        case .text:
            return "SPopupCell"
        default:
            return "SPopupIconCell"
        }
    }
}

class SPopupVC: UIViewController {
    @IBOutlet weak var tblView: UITableView?
    private var data = [SPopModel]()
    fileprivate var onCompletion: PopupCompletionBlock?
    fileprivate var cellType: SPopupCellType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView?.register(SPopupCell.nib, forCellReuseIdentifier: SPopupCell.className)
        tblView?.register( UINib(nibName: "SPopupIconCell", bundle: nil), forCellReuseIdentifier: "SPopupIconCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTableData()
    }
    static var linkedWithStoryBoard: SPopupVC {
        
        let storyboard = UIStoryboard.init(name: "SPopup", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: SPopupVC.className) as! SPopupVC
        return vc
    }
    
    static func presentPoup(data:[SPopModel], cellType:SPopupCellType = .text, controller: UIViewController, sender: UIView?, preferedSize:CGSize = CGSize(width: 300,height: 500), popupDirection: UIPopoverArrowDirection = .any, onCompletion:@escaping PopupCompletionBlock){
        
        var size = preferedSize
        let viewHeight: CGFloat = Double(data.count) * 50.0
        if viewHeight < preferedSize.height {
            size.height = viewHeight
        }
        let optionsVC = SPopupVC.linkedWithStoryBoard
        optionsVC.data = data
        optionsVC.cellType = cellType
        optionsVC.onCompletion = onCompletion
        optionsVC.modalPresentationStyle = .popover
        optionsVC.preferredContentSize = size
        let popoverController = optionsVC.popoverPresentationController
        popoverController?.permittedArrowDirections = popupDirection
        popoverController?.sourceView = sender
        popoverController?.sourceRect = sender!.bounds
        controller.present(optionsVC, animated: true) {
            
        }
    }
    
    fileprivate func reloadTableData() {
        DispatchQueue.main.async { [weak self] in
            self?.tblView?.reloadData()
        }
    }
}

extension SPopupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType!.cellIdentifire , for: indexPath) as! SPopupCell
        let item = data[indexPath.row]
        cell.nameLbl?.text = item.name
        
        if cellType == .multiSelection {
            cell.checkBtn?.setImage(item.asCheckImage, for: .normal)
        } else {
            cell.checkBtn?.setImage(item.asImage, for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item  = data[indexPath.row]
        item.isSelected = !item.isSelected
        
        if let block = self.onCompletion {
            block(data[indexPath.row])
        }
        
        if !(cellType == .multiSelection) {
            self.dismiss(animated: true)
        }else {
            if isAllDeselcted() {
                item.isSelected = true
            }
            reloadTableData()
        }
    }
    
    fileprivate func isAllDeselcted() -> Bool {
        let filters = self.data.filter { obj in
            return obj.isSelected == true
        }
        return filters.count == 0 ? true : false
    }
}



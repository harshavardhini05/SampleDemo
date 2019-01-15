//
//  PlayerListTableViewCell.swift
//  DemoProject
//
//  Created by HarshaVardhini on 08/01/19.
//  Copyright © 2019 HarshaVardhini. All rights reserved.
//

import UIKit

protocol PlayerListTableViewCellDelegate: NSObjectProtocol {
    func didDeletePlayer(_ btnIndexPath: IndexPath)
}
class PlayerListTableViewCell: UITableViewCell {
    @IBOutlet weak var playerNameTxt: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    weak var delegate:PlayerListTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.deleteBtn.addTarget(self, action: #selector(deleteMethod), for: .touchUpInside)
    }
    
  @objc  func deleteMethod() {
        self.delegate.didDeletePlayer(IndexPath(row: self.tag, section: 0))
    }
}

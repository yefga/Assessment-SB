//
//  LatestNewsTableViewCell.swift
//  SBTCryptoApp
//
//  Created by Yefga on 12/07/21.
//

import UIKit

class LatestNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configure(item: News) {
        self.publisherLabel.text = item.categories
        self.titleLabel.text = item.title
        self.descriptionTextView.text = item.body
    }
    
}

//
//  TopListsTableViewCell.swift
//  SBTCryptoApp
//
//  Created by Yefga on 11/07/21.
//

import UIKit

class TopListsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var initialCurrencyLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var upAndDownPriceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item: CryptoCurrency) {
        
        self.initialCurrencyLabel.text = item.coinInfo?.name
        self.currencyLabel.text = item.coinInfo?.fullName
        self.priceLabel.text = item.display?.currency?.price
    }
    
    
}

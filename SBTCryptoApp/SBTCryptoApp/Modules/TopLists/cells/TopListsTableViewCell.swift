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
        

        self.upAndDownPriceButton.setTitleColor(.white, for: .normal)
        self.upAndDownPriceButton.layer.cornerRadius = 8.0
        
        if let changeHour = item.display?.currency?.change,
           let changeHourPercentage = item.display?.currency?.changePercent,
           let intOfChange = Double(changeHourPercentage) {
            
            let symbol = intOfChange > 0 ? "+" : ""
            
            let hourly = changeHour.replacingOccurrences(of: "$", with: "")
            let doubleHourly = NSString(string: hourly).doubleValue
            let makeShortDoubleHourly = round(doubleHourly * 100) / 100.0
            
            self.upAndDownPriceButton.setTitle("\(makeShortDoubleHourly) (\(symbol)\(changeHourPercentage) %)", for: .normal)
            self.upAndDownPriceButton.backgroundColor = intOfChange < 0 ? .systemRed : .systemGreen
            
        }
        
    }
    
    
}

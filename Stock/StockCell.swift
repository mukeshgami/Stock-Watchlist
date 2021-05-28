//
//  StockCell.swift
//  Stock
//
//  Created by Mukesh Gami on 27/05/21.
//

import UIKit

class StockCell: UITableViewCell {
    
    @IBOutlet var stockSymbol: UILabel!
    @IBOutlet var stockName: UILabel!
    @IBOutlet var stockPrice: UILabel!
    @IBOutlet var stockPriceChange: UILabel!
    @IBOutlet var stockPriceChangeBox: UIView!
    
    
    var boxTapped: (() -> Void)? = nil
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stockPriceChangeBox.layer.cornerRadius = 5
        
        let stockPriceChangeBoxTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.boxClicked(_:)))
        stockPriceChangeBoxTapRecognizer.numberOfTapsRequired = 1
        self.stockPriceChangeBox.isUserInteractionEnabled = true
        self.stockPriceChangeBox.addGestureRecognizer(stockPriceChangeBoxTapRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func boxClicked(_ tapGesture: UIGestureRecognizer){
        if let boxAction = boxTapped {
            boxAction()
        }
    }
}

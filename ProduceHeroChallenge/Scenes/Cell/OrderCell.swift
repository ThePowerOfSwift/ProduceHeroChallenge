//
//  OrderCell.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import UIKit

protocol OrderCellDelegate: class{
    func adjustButtonTouched(at row: Int)
}

class OrderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    private var row: Int!
    private weak var delegate: OrderCellDelegate?
        
    func configure(name: String, row: Int, quantity: String, delegate: OrderCellDelegate?) {
        titleLabel.text = "Order Item \(name)"
        quantityLabel.text = "x\(quantity)"
        
        self.row = row
        self.delegate = delegate
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        delegate?.adjustButtonTouched(at: row)
    }
}

//
//  AdjustOrderViewController.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import UIKit

protocol AdjustOrderViewControllerDelegate: class{
    func saveTouched(quantity: Int)
    func deleteTouched()
}

class AdjustOrderViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    weak var delegate: AdjustOrderViewControllerDelegate?
    
    var order: Order!
    private var quantity: Int = 0 {
        didSet {
            quantityLabel.text = String(quantity)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Order Item \(order.name) (1 Kg)"
        quantity = order.quantity
        
    }
    
    @IBAction func plusButtonTouched(_ sender: UIButton) {
        quantity += 1
    }
    
    @IBAction func minusButtonTouched(_ sender: UIButton) {
        if quantity > 0 {
            quantity -= 1
        }
    }
    
    @IBAction func saveBarButtonTouched(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        delegate?.saveTouched(quantity: quantity)
    }
    
    @IBAction func deleteButtonTouched(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        delegate?.deleteTouched()
    }
}

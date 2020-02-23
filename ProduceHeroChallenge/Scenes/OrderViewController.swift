//
//  OrderViewController.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var orders: [Order] = []
    private let orderCellId = "OrderCell"
    private let changeItemSegueId = "showChangeItem"
    private let signSegueId = "presentSign"

    private var selectedRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: orderCellId, bundle: nil), forCellReuseIdentifier: orderCellId)
        tableView.dataSource = self
    }

    @IBAction func signButtonItemTouched(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: signSegueId, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case changeItemSegueId:
            if let changeItemVc = segue.destination as? AdjustOrderViewController, let order = sender as? Order {
                changeItemVc.order = order
                changeItemVc.delegate = self
            }
            
        case signSegueId:
            break
            
        default:
            break
        }
    }
}

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: orderCellId) as? OrderCell else { return UITableViewCell() }
        let row = indexPath.row
        let order = orders[row]
        selectedRow = row
        cell.configure(name: order.name, row: row, quantity: String(order.quantity), delegate: self)
        
        return cell
    }
}

extension OrderViewController: OrderCellDelegate {
    func adjustButtonTouched(at row: Int) {
        selectedRow = row
        performSegue(withIdentifier: changeItemSegueId, sender: orders[row])
    }
}

extension OrderViewController: AdjustOrderViewControllerDelegate {
    
    func saveTouched(quantity: Int) {
        orders[selectedRow].quantity = quantity
        tableView.reloadData()
    }
    
    func deleteTouched() {
        orders.remove(at: selectedRow)
        tableView.reloadData()
    }
}

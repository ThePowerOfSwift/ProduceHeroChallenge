//
//  RoutesViewController.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import UIKit

class RoutesViewController: UITableViewController {
    
    private var cities: [City] = [City(name: "Toronto", businesses:
        [Business(name: "Pizza Inc.", address: "100 Yonge St, Toronto", signed: false),
         Business(name: "Boston Pizza Inc.", address: "20 Sheppard St, Toronto", signed: false),
         Business(name: "Milestone Inc.", address: "1220 Queen St, Toronto", signed: false),
         Business(name: "Ten Ichi", address: "1020 Bloor St, Toronto", signed: true),
         Business(name: "Jack Astors Inc.", address: "100 Yonge St, Toronto", signed: true),
         Business(name: "II Libreto.", address: "1230 Dundas St, Toronto", signed: true)]),
                                  City(name: "Waterloo", businesses: []),
                                  City(name: "Guelph", businesses: [])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RouteCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlan", sender: cities[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPlan":
            if let planVc = segue.destination as? RoutesPlanViewController, let city = sender as? City {
                planVc.city = city
            }
        default:
            break
        }
    }
}

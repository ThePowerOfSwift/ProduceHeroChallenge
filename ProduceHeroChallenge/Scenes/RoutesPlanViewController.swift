//
//  RoutesPlanViewController.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RoutesPlanViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var city: City!
    
    private let orderSegueId = "showOrder"
    private let businessCellId = "BusinessCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(city?.name ?? "") Route Plan"
        
        tableView.register(UINib(nibName: businessCellId, bundle: nil), forCellReuseIdentifier: businessCellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case orderSegueId:
            if let orderVc = segue.destination as? OrderViewController, let orders = sender as? [Order] {
                orderVc.orders = orders
            }
        default:
            break
        }
    }
}

extension RoutesPlanViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: businessCellId, for: indexPath) as? BusinessCell else { return UITableViewCell() }
        cell.configure(city.businesses[indexPath.row], delegate: self)

        return cell
    }
}

extension RoutesPlanViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: orderSegueId, sender: city.businesses[indexPath.row].orders)
    }
}

extension RoutesPlanViewController: BusinessCellDelegate {
    func mapTouched(at mapItem: MKMapItem) {
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}

extension CLLocation {
    
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
    
    func geocode(latitude: Double, longitude: Double, completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude), completionHandler: completion)
    }
}

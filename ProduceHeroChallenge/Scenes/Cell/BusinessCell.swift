//
//  BusinessCell.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import UIKit
import MapKit

protocol BusinessCellDelegate: class{
    func mapTouched(at mapItem: MKMapItem)
}

class BusinessCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var signed = false
    private weak var delegate: BusinessCellDelegate?
    private var business: Business!
    
    func configure(_ business: Business, delegate: BusinessCellDelegate?) {
        
        titleLabel.text = business.name
        addressLabel.text = business.address
        signed = business.signed
        signed ? setupMapButton() : setupSignButton()
        activityIndicator.isHidden = true
        
        self.delegate = delegate
        self.business = business
    }
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        if signed {
            getMapItem(with: business.address)
        }
    }
    
    private func setupSignButton() {
        button.setTitle("Signed", for: .normal)
        button.backgroundColor = .gray
    }
    
    private func setupMapButton() {
        button.setTitle("Map", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 0, green: 0.749, blue: 0.612, alpha: 1.0)
    }
    
    private func stopLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        button.setTitleColor(.white, for: .normal)
    }
    
    private func getMapItem(with address: String){
        
        activityIndicator.isHidden = false
        button.setTitleColor(.clear, for: .normal)
        activityIndicator.startAnimating()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) -> Void in
            
            if let placemark = placemarks?.first {
                
                let mapItem = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                mapItem.name = placemark.locality
                self?.delegate?.mapTouched(at: mapItem)

            }
            
            self?.stopLoading()
        }
    }
}

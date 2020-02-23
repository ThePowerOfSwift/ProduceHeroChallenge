//
//  SignViewController.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import UIKit

protocol SignViewControllerDelegate: class{
    func doneTouched(paths: [UIBezierPath])
    func cancelTouched()
}

class SignViewController: UIViewController {

    weak var delegate: SignViewControllerDelegate?
    @IBOutlet weak var signatureView: SignatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTouched(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.signatureView.clear()
            self?.delegate?.cancelTouched()
        }
    }
    
    @IBAction func doneButtonTouched(_ sender: UIButton) {
        let paths = signatureView.paths
        dismiss(animated: true) { [weak self] in
            self?.delegate?.doneTouched(paths: paths)
        }
    }
    
    @IBAction func clearButtonTouched(_ sender: UIButton) {
        signatureView.clear()
    }

}

//
//  FirstVC.swift
//  SPMAnimation
//
//  Created by Kate on 04/10/2023.
//

import UIKit

class FirstVC: BaseViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.isHidden = true
        }
    }
    
    @IBAction func startBtnAction() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        startActivityAnimation(message: "Loading",
                              type: .lineScalePulseOutRapid,
                              color: .white)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.activityIndicatorView.isHidden = true
            self?.stopActivityAnimating()
        }
    }
}


//
//  BaseViewController.swift
//  SPMAnimation
//
//  Created by Kate on 04/10/2023.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class BaseViewController: UIViewController, NVActivityIndicatorViewable {
    
    func startActivityAnimation(message: String, type: NVActivityIndicatorType, color: UIColor) {
        startAnimating(message: message, type: type, color: color)
    }
    
    func stopActivityAnimating() {
        stopAnimating()
    }
}


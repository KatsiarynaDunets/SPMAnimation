//
//  SecondVC.swift
//  SPMAnimation
//
//  Created by Kate on 04/10/2023.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class SecondVC: BaseViewController {
    
    private let presentingIndicatorTypes = {
            return NVActivityIndicatorType.allCases.filter { $0 != .blank }
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: CGFloat(10 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            let safeArea = view.safeAreaLayoutGuide.layoutFrame

            var cols = 4
            var rows = Int(ceil(Double(presentingIndicatorTypes.count) / 4.0))
            if safeArea.width > safeArea.height {
                //Landscape
                cols = Int(ceil(Double(presentingIndicatorTypes.count) / 4.0))
                rows = 4
            }
            let cellWidth = Int(safeArea.width / CGFloat(cols))
            let cellHeight = Int(safeArea.height / CGFloat(rows))

            self.view.subviews.forEach {
                $0.removeFromSuperview()
            }

            for (index, indicatorType) in presentingIndicatorTypes.enumerated() {
                let x = index % cols * cellWidth + Int(safeArea.origin.x)
                let y = index / cols * cellHeight + Int(safeArea.origin.y)
                let frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
                let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                                    type: indicatorType)
                let animationTypeLabel = UILabel(frame: frame)

                animationTypeLabel.text = String(index)
                animationTypeLabel.sizeToFit()
                animationTypeLabel.allowsDefaultTighteningForTruncation = true
                animationTypeLabel.textColor = UIColor.white
                animationTypeLabel.frame.origin.x += 5
                animationTypeLabel.frame.origin.y += CGFloat(cellHeight) - animationTypeLabel.frame.size.height

                activityIndicatorView.padding = 20
                if indicatorType == NVActivityIndicatorType.orbit {
                    activityIndicatorView.padding = 0
                }
                self.view.addSubview(activityIndicatorView)
                self.view.addSubview(animationTypeLabel)
                activityIndicatorView.startAnimating()

                let button = UIButton(frame: frame)
                button.tag = index
                button.addTarget(self,
                                 action: #selector(buttonTapped(_:)),
                                 for: .touchUpInside)
                self.view.addSubview(button)
            }
        }

    @objc func buttonTapped(_ sender: UIButton) {
        let size = CGSize(width: 30, height: 30)
        let selectedIndicatorIndex = sender.tag
        let indicatorType = presentingIndicatorTypes[selectedIndicatorIndex]
        
        startAnimating(size, message: "Loading...", type: indicatorType, fadeInAnimation: nil)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating(nil)
        }
    }
}


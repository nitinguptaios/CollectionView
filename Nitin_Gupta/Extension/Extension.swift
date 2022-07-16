//
//  Extension.swift
//  Nitin_Gupta
//
//  Created by iPHSTech 34 on 14/05/22.
//

import Foundation
import UIKit

var timerForLoader: Timer?


extension UIViewController{
    
    func showLoader(msg:String = "", animationType: NVActivityIndicatorType = .circleStrokeSpin, color: UIColor = .systemGreen, timeInterval: TimeInterval = 30.0, size: CGSize = CGSize(width: 70, height: 70)){
        let activityData =  ActivityData(size: size, message: msg, messageFont: nil, messageSpacing: nil, type: animationType, color: color, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.clear, textColor: UIColor.white)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        timerForLoader?.invalidate()
        timerForLoader = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.hideLoaderAfterWaitingTime), userInfo: nil, repeats: false)
    }

    @objc func hideLoaderAfterWaitingTime() {
        
        if NVActivityIndicatorPresenter.sharedInstance.isAnimating {
            hideLoader()
        }
    }
    
    func hideLoader() {
        timerForLoader?.invalidate()
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }

}

extension UIImageView {
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "Placeholder")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "Placeholder")
            }
        }
    }
}

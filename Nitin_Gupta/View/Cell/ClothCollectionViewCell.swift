//
//  ClothCollectionViewCell.swift
//  Nitin_Gupta
//
//  Created by iPHSTech 34 on 14/05/22.
//

import UIKit

class ClothCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 20
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cutPrice: UILabel! {
        didSet {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$139.95")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            
            cutPrice.attributedText = attributeString
        }
    }
    
    @IBOutlet weak var heartView: UIView! {
        didSet {
            heartView.layer.cornerRadius = heartView.frame.height / 2
        }
    }
    @IBOutlet weak var heartImage: UIImageView!
    
    var heartuttonPressed : (() -> ()) = {}

    @IBAction func heartButtonClick(_ sender: UIButton) {
        heartuttonPressed()
    }
    
    
    
    
}

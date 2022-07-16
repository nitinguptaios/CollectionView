//
//  ViewController.swift
//  Nitin_Gupta
//
//  Created by iPHSTech 34 on 13/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var clothCollectionView: UICollectionView!
    
    @IBOutlet weak var firstMenuView: UIView!
    @IBOutlet weak var secondMenuView: UIView!
    @IBOutlet weak var thirdMenuView: UIView!
    @IBOutlet weak var fourthMenuView: UIView!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    
    let array = ["Trending Now", "2021 New In", "Tik Tok", "Whatsapp", "Facebook"]
    
    var i = 0
    
    var arrDataModel = [CatelougeDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        getData()
    }
    
    func getData(){
        self.showLoader()
        Service.shareInstance.getAllMovieData { (data, error) in
            if(error==nil){
                self.arrDataModel = data?.map({ return CatelougeDataModel(image: $0.image!, price: $0.price!, title: $0.title!) }) ?? []
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.clothCollectionView.reloadData()
                }
            }
        }
    }
    
    func setupUI() {
        firstView.clipsToBounds = true
        firstView.layer.cornerRadius = 50
        firstView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        
        clothCollectionView.delegate = self
        clothCollectionView.dataSource = self
        
        tabCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        firstMenuView.layer.cornerRadius = firstMenuView.frame.height / 2
        secondMenuView.layer.cornerRadius = secondMenuView.frame.height / 2
        thirdMenuView.layer.cornerRadius = thirdMenuView.frame.height / 2
        fourthMenuView.layer.cornerRadius = fourthMenuView.frame.height / 2
    }
    
    @IBAction func firstButton(_ sender: UIButton) {
        firstMenuView.backgroundColor = UIColor.systemOrange
        secondMenuView.backgroundColor = .clear
        thirdMenuView.backgroundColor = .clear
        fourthMenuView.backgroundColor = .clear
        
        firstImage.tintColor = .white
        secondImage.tintColor = .lightGray
        thirdImage.tintColor = .lightGray
        fourthImage.tintColor = .lightGray
    }
    
    @IBAction func secondButton(_ sender: UIButton) {
        firstMenuView.backgroundColor = .clear
        secondMenuView.backgroundColor = UIColor.systemOrange
        thirdMenuView.backgroundColor = .clear
        fourthMenuView.backgroundColor = .clear
        
        firstImage.tintColor = .lightGray
        secondImage.tintColor = .white
        thirdImage.tintColor = .lightGray
        fourthImage.tintColor = .lightGray
    }
    
    @IBAction func thirdButton(_ sender: UIButton) {
        firstMenuView.backgroundColor = .clear
        secondMenuView.backgroundColor = .clear
        thirdMenuView.backgroundColor = UIColor.systemOrange
        fourthMenuView.backgroundColor = .clear
        
        firstImage.tintColor = .lightGray
        secondImage.tintColor = .lightGray
        thirdImage.tintColor = .white
        fourthImage.tintColor = .lightGray
    }

    @IBAction func fourthButton(_ sender: UIButton) {
        firstMenuView.backgroundColor = .clear
        secondMenuView.backgroundColor = .clear
        thirdMenuView.backgroundColor = .clear
        fourthMenuView.backgroundColor = UIColor.systemOrange
        
        firstImage.tintColor = .lightGray
        secondImage.tintColor = .lightGray
        thirdImage.tintColor = .lightGray
        fourthImage.tintColor = .white
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clothCollectionView {
            return self.arrDataModel.count
        }
        else {
            return array.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clothCollectionView {
            let cell = clothCollectionView.dequeueReusableCell(withReuseIdentifier: "ClothCollectionViewCell", for: indexPath) as! ClothCollectionViewCell
            cell.imageView.setCustomImage(self.arrDataModel[indexPath.row].image!)
            cell.title.text = self.arrDataModel[indexPath.row].title!
            cell.price.text = "$\(self.arrDataModel[indexPath.row].price!)"
                        
            cell.heartuttonPressed = {
                if cell.heartImage.image == UIImage(systemName: "heart.fill") {
                    cell.heartImage.image = UIImage(systemName: "heart")
                    cell.heartImage.tintColor = .black
                }
                else {
                    cell.heartImage.image = UIImage(systemName: "heart.fill")
                    cell.heartImage.tintColor = .red
                }
            }
            return cell
        }
        else {
            let cell = tabCollectionView.dequeueReusableCell(withReuseIdentifier: "tabViewCell", for: indexPath) as! TabViewCell
            cell.label.text = array[indexPath.row]
            cell.view.layer.cornerRadius = 10
            cell.view.layer.borderColor = UIColor.lightGray.cgColor
            cell.view.layer.borderWidth = 1
            
            if indexPath.row == 0 {
                cell.label.textColor = .white
                cell.view.backgroundColor = .black
            }
            else {
                cell.label.textColor = .darkGray
                cell.view.backgroundColor = .clear
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == clothCollectionView {
            let j = i
            i += 1
            if j == 0 {
                return CGSize(width: clothCollectionView.frame.width / 2 - 10, height: 280)
            }
            else if j == 1 {
                return CGSize(width: clothCollectionView.frame.width / 2 - 10, height: 220)
            }
            else if j == 2 {
                return CGSize(width: clothCollectionView.frame.width / 2 - 10, height: 220)
            }
            else {
                i = 0
                return CGSize(width: clothCollectionView.frame.width / 2 - 10, height: 280)
            }
        }
        else {
            return CGSize(width: 150, height: 50)
        }
        
    }
}

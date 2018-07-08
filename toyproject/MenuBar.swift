//
//  MenuBar.swift
//  toyproject
//
//  Created by polycube on 2018. 7. 7..
//  Copyright © 2018년 sesang06. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.blue
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let cellId = "cellIdj"
    var homeController : HomeController?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
        //addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        //addConstraintsWithFormat("V:|[v0]|", views: collectionView)
      let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition()  )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4 , height: frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
class MenuCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        
        setupViews()
    }
    
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.brown
        return iv
    }()
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.brown
        }
    }
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.brown
        }
    }
    func setupViews(){
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(28)
            make.width.equalTo(28)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        //addConstraintsWithFormat("H:[v0(28)]", views: imageView)
        //addConstraintsWithFormat("V:[v0(28)]", views: imageView)
        
        //addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        //addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

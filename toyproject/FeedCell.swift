//
//  FeedCell.swift
//  toyproject
//
//  Created by polycube on 2018. 7. 8..
//  Copyright © 2018년 sesang06. All rights reserved.
//

import Foundation
import UIKit


class FeedCell : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PinterestLayoutDelegate  {
    var homeController : HomeController?
    
    lazy var collectionView : UICollectionView = {
        let layout = PinterrestLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        if let layout = cv.collectionViewLayout as? PinterrestLayout {
            layout.delegate = self
        }
        
        return cv
    }()
    var contents : [Content]?
    let cellid = "cellid"
    
    func setupContents(){
        contents = [Content]()
        
        for i in 1...5 {
            let content = Content()
            if (i % 2 == 0){
                content.thumbnailImageName = "dora"
                content.titleText = "마지막 처럼"
                content.detailText = "\(i)번째 baby 날 터질 것처럼 안아줘 그만 생각해 뭐가 그리 어려워 거짓말 처럼 키스해줘 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼"
            }else {
                content.thumbnailImageName = "tear"
                content.titleText = "빨간맛"
                content.detailText = "\(i)번째 빨간 맛 궁금해 허니 깨물면 저점 녹아든 스트로베리 그 맛 코너 캔디 찾아봐 베이비 내가 제일좋아하는 여름그맛"
            }
            contents?.append(content)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        backgroundColor = .brown
        setupContents()
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: cellid)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! ContentCell
        cell.content = contents?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let titleText = contents?[indexPath.item].titleText, let detailText = contents?[indexPath.item].detailText {
            
            let size = CGSize(width : frame.width / 2,  height : 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let titleEstimatedRect = NSString(string: titleText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
            if titleEstimatedRect.size.height > 20 {
                
            } else {
                //    titleLabelHeightConstraint?.constant = 20
            }
            
            
            let detailEstimatedRect = NSString(string: detailText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
            
            return CGSize(width: frame.width / 2, height: 200 + max(20, titleEstimatedRect.size.height) + max(20, detailEstimatedRect.size.height))
            
        }
        
        return CGSize(width: frame.width / 2, height: 200)
    }
    func collectionView(collectionView : UICollectionView, heightForItemAtIndexPath indexPath : NSIndexPath)-> CGFloat {
        if let titleText = contents?[indexPath.item].titleText, let detailText = contents?[indexPath.item].detailText {
            
            let size = CGSize(width : frame.width / 2,  height : 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let titleEstimatedRect = NSString(string: titleText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
            if titleEstimatedRect.size.height > 20 {
                
            } else {
                //    titleLabelHeightConstraint?.constant = 20
            }
            
            
            let detailEstimatedRect = NSString(string: detailText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
            
            return 200 + max(20, titleEstimatedRect.size.height) + max(20, detailEstimatedRect.size.height)
            
        }
        
        return 200
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        /*if (velocity.y > 0){
            UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.homeController?.navigationController?.setNavigationBarHidden(true, animated: true)
                    //self.homeController?.navigationController?.setToolbarHidden(true, animated: true)
            }, completion: nil)
        }else {
            
            UIView.animate(withDuration: 2.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.homeController?.navigationController?.setNavigationBarHidden(false, animated: true)
                    //self.homeController?.navigationController?.setToolbarHidden(false, animated: true)
            }, completion: nil)
        }*/
    }
    
}

//
//  FacebookCell.swift
//  toyproject
//
//  Created by polycube on 2018. 7. 8..
//  Copyright © 2018년 sesang06. All rights reserved.
//

import Foundation
import UIKit


class FacebookCell : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    var trendings : [Trending]?
    let cellid = "cellid"
    let noImageCellId = "noImageCellId"
    let oneImageCellId = "oneImageCellId"
    let twoImageCellId = "twoImageCellId"
    let threeImageCellId = "threeImageCellId"
    let fourImageCellId = "fourImageCellId"
    
    let headerId = "headerId"
    
    func setupContents(){
         trendings = [Trending]()
        
        for i in 0..<5 {
            let trending = Trending()

            
            if (i % 2 == 0){
                trending.thumbnailImageNames = [String]()
                trending.thumbnailImageNames?.append("tear")
                trending.thumbnailImageNames?.append("dora")
                trending.titleText = "마지막 처럼"
                trending.detailText = "\(i)번째 baby 날 터질 것처럼 안아줘 그만 생각해 뭐가 그리 어려워 거짓말 처럼 키스해줘 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼"
            }else {
              
                trending.thumbnailImageNames = [String]()
                trending.thumbnailImageNames?.append("tear")
                trending.titleText = "빨간맛"
                trending.detailText = "\(i)번째 빨간 맛 궁금해 허니 깨물면 저점 녹아든 스트로베리 그 맛 코너 캔디 찾아봐 베이비 내가 제일좋아하는 여름그맛"
            }
            trendings?.append(trending)
        }
        
        let trending = Trending()
        trending.thumbnailImageNames = [String]()
        trending.thumbnailImageNames?.append("tear")
        trending.thumbnailImageNames?.append("dora")
        trending.thumbnailImageNames?.append("land")
        trending.titleText = "마지막 처럼"
        trending.detailText = "번째 baby 날 터질 것처럼 안아줘 그만 생각해 뭐가 그리 어려워 거짓말 처럼 키스해줘 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼"
        trendings?.append(trending)
        
        
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
        collectionView.register(HotTrendingCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: cellid)
        collectionView.register(NoImageTrendingCell.self, forCellWithReuseIdentifier : noImageCellId)
        collectionView.register(OneImageTrendingCell.self, forCellWithReuseIdentifier : oneImageCellId)
        collectionView.register(TwoImageTrendingCell.self, forCellWithReuseIdentifier : twoImageCellId)
        collectionView.register(ThreeImageTrendingCell.self, forCellWithReuseIdentifier: threeImageCellId)
        collectionView.register(FourImageTrendingCell.self, forCellWithReuseIdentifier: fourImageCellId)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HotTrendingCell
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let count = trendings?[indexPath.item].thumbnailImageNames?.count {
            let identifier : String
            if (count == 0){
                identifier = noImageCellId
            }else if (count == 1) {
                identifier = oneImageCellId
            }else if (count == 2){
                identifier = twoImageCellId
            }else if (count == 3) {
                identifier = threeImageCellId
            }else {
                identifier = fourImageCellId
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TrendingCell
            cell.content = trendings?[indexPath.item]
            return cell
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! TrendingCell
        cell.content = trendings?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = trendings?[indexPath.item].thumbnailImageNames?.count ?? 0
        let estimatedTextHeight : CGFloat
        if let titleText = trendings?[indexPath.item].titleText, let detailText = trendings?[indexPath.item].detailText {
            
            let size = CGSize(width : frame.width - 20,  height : 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let titleEstimatedRect = NSString(string: titleText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
           
            
            let detailEstimatedRect = NSString(string: detailText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
           
            
            estimatedTextHeight = max(40, titleEstimatedRect.size.height + 40) + max(40, detailEstimatedRect.size.height + 40)
            
        }else {
            estimatedTextHeight = 0
        }
        let estimatedPhotoHeight : CGFloat
        if count == 0 {
            estimatedPhotoHeight = 100
        }else if count == 1 {
            estimatedPhotoHeight = 200
        }else if count == 2 {
            estimatedPhotoHeight = ((frame.width - 30) / 2)
        }else {
            estimatedPhotoHeight = ((frame.width - 30) )
            
        }
        return CGSize(width: frame.width, height: estimatedTextHeight + estimatedPhotoHeight)
    }
    
}

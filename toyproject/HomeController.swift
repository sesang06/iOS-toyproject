//
//  ViewController.swift
//  toyproject
//
//  Created by polycube on 2018. 7. 6..
//  Copyright © 2018년 sesang06. All rights reserved.
//

import UIKit
import SnapKit
class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout , PinterestLayoutDelegate {

    var contents : [Content] = [Content]()
    let cellid = "cellid"
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContents()
        
        navigationItem.title = "호호"
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ContentCell.self, forCellWithReuseIdentifier: cellid)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        if let layout = collectionView?.collectionViewLayout as? PinterrestLayout {
            layout.delegate = self
        }
        setupMenuBar()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setupMenuBar(){
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.height.equalTo(50)
        }
        //view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        //view.addConstraintsWithFormat("V:|[v0(50)]|", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    func setupContents(){
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
            contents.append(content)
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (contents.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! ContentCell
        //cell.backgroundColor = UIColor.red
        cell.content = contents[indexPath.item]
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let titleText = contents[indexPath.item].titleText, let detailText = contents[indexPath.item].detailText {
            
            let size = CGSize(width : view.frame.width / 2,  height : 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let titleEstimatedRect = NSString(string: titleText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
            if titleEstimatedRect.size.height > 20 {
                
            } else {
                //    titleLabelHeightConstraint?.constant = 20
            }
            
            
            let detailEstimatedRect = NSString(string: detailText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
            
            return CGSize(width: view.frame.width / 2, height: 200 + max(20, titleEstimatedRect.size.height) + max(20, detailEstimatedRect.size.height))
            
        }
        
        return CGSize(width: view.frame.width / 2, height: 200)
    }
    func collectionView(collectionView : UICollectionView, heightForItemAtIndexPath indexPath : NSIndexPath)-> CGFloat {
        if let titleText = contents[indexPath.item].titleText, let detailText = contents[indexPath.item].detailText {
            
            let size = CGSize(width : view.frame.width / 2,  height : 1000)
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
}

class Content : NSObject {
    var thumbnailImageName : String? //섬네일을 가져가기 위한 이미지뷰
    var titleText : String? //타이틀을 가져온다
    var detailText : String? //디테일을 가져온다
}

class ContentCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    var titleTextHeightConstraint : Constraint? = nil
    var detailTextHeightConstraint : Constraint? = nil
    var content :Content? {
        didSet{
            thumbnailImageView.image = UIImage(named: (self.content?.thumbnailImageName)!)
            titleTextView.text = self.content?.titleText!
            detailTextView.text = self.content?.detailText!
            
            
            if let titleText = content?.titleText {
                
                let size = CGSize(width : frame.width - 16 - 44 - 8 - 16,  height : 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedRect = NSString(string: titleText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20 {
                    titleTextHeightConstraint?.update(offset: estimatedRect.size.height)

                  } else {
                //    titleLabelHeightConstraint?.constant = 20
                }
            }
            if let detailText = content?.detailText {
                let size = CGSize(width : frame.width - 16 - 44 - 8 - 16,  height : 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedRect = NSString(string: detailText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20 {
                    detailTextHeightConstraint?.update(offset: estimatedRect.size.height)
                 } else {
                    //    titleLabelHeightConstraint?.constant = 20
                }
            }
            
        }
    }
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "tear")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleTextView : UITextView = {
       let textView = UITextView()
        
        textView.text = "친구를 만나느라 shy shy shy"
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
        
    }()
    
    let detailTextView : UITextView = {
        
        let textView = UITextView()
        textView.text = "거짓말처럼 키스해줘 내가 너에게 마지막 사랑인 것처럼"
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
        
    }()
    func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(titleTextView)
        addSubview(detailTextView)
        
        thumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(self).multipliedBy(0.3)
            
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
        }
        titleTextView.snp.makeConstraints { (make) in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            titleTextHeightConstraint =  make.height.equalTo(20).constraint
        }
        
        detailTextView.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextView.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            detailTextHeightConstraint = make.height.equalTo(20).constraint
        }
        
        
        self.backgroundColor = UIColor.blue
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol  PinterestLayoutDelegate : class {
    func collectionView(collectionView : UICollectionView, heightForItemAtIndexPath indexPath : NSIndexPath)-> CGFloat
}
class PinterrestLayout : UICollectionViewLayout {
    var delegate : PinterestLayoutDelegate!
    var numberOfColumns = 2
    
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight : CGFloat = 0
    private var width : CGFloat {
        get {
            return (collectionView?.bounds.width)!
        }
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    override func prepare(){
        if cache.isEmpty {
            
            let columnWidth = width / CGFloat(numberOfColumns)
            var xOffsets = [CGFloat]()
            for columns in 0..<numberOfColumns {
                xOffsets.append(CGFloat(columns) * columnWidth)
            }
            
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            var column = 0
            for item in 0..<collectionView!.numberOfItems(inSection: 0){
                let indexPath = NSIndexPath(item: item, section: 0)
                let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath)
                let frame = CGRect(x: xOffsets[column], y: yOffset[column], width : columnWidth, height : height)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.frame = frame
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
                
            }
            
        }
        
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}

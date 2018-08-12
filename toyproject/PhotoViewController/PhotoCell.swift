import Foundation
import UIKit
import SnapKit

class PhotoCell : UICollectionViewCell {
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted){
                UIView.animate(withDuration: 0.75) {
                    self.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
                   }
            }else {
                UIView.animate(withDuration: 0.75) {
                    self.backgroundColor = UIColor.white
                  }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    var thumbnailImageHeightConstraint : Constraint?
    var content :PhotoContent? {
        didSet{
            thumbnailImageView.image = UIImage(named: (self.content?.thumbnailImageName)!)
            if let imageHeight = self.content?.imageHeight, let imageWidth = self.content?.imageWidth {
                let width = self.frame.size.width - 20
                let height = width * imageHeight / imageWidth
                thumbnailImageHeightConstraint?.update(offset: height)
            }
            titleLabel.text = self.content?.titleText!
        }
    }
    let cardShadowView : UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.shadowOffset = .zero
        v.layer.shadowOpacity = 0.7
        v.layer.shadowRadius = 5
        return v
        
    }()
    
    let cardView : UIView = {
       let v = UIView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
//        v.layer.cornerRadius = 10
//        v.layer.shadowOffset = .zero
//        v.layer.shadowOpacity = 0.7
//        v.layer.shadowRadius = 5
        return v
    }()
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
//        imageView.layer.addShadow()

        imageView.clipsToBounds = true
//        imageView.layer.roundCorners(radius: 10)
//        imageView.layer.masksToBounds = false
//        imageView.layer.cornerRadius = 10
//        imageView.layer.shadowRadius = 14
//        imageView.layer.shadowOffset = CGSize(width: 0, height: 10)
//        imageView.layer.shadowOpacity = 0.7
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size: 12)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    func setupViews(){
        addSubview(cardShadowView)
        
        cardShadowView.addSubview(cardView)
        cardView.addSubview(thumbnailImageView)
        cardView.addSubview(titleLabel)
        
        cardView.backgroundColor = UIColor.white
        
        cardShadowView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-10)
        }
        cardView.snp.makeConstraints { (make) in
            make.top.trailing.leading.bottom.equalTo(cardShadowView)
        }
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(cardView)
            thumbnailImageHeightConstraint =  make.height.equalTo(300).constraint
            
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
            make.leading.equalTo(cardView).offset(5)
            make.trailing.equalTo(cardView).offset(-5)
            make.height.equalTo(20)
            make.bottom.equalTo(cardView).offset(-5)

        }

//        addSubview(titleLabel)
//
//        cardView.snp.makeConstraints { (make) in
//            thumbnailImageHeightConstraint =  make.height.equalTo(300).constraint
//            make.top.equalTo(self).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//
//        }
//        thumbnailImageView.snp.makeConstraints { (make) in
//            make.top.leading.trailing.bottom.equalTo(cardView)
//
//        }
//        titleLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
//            make.leading.equalTo(self).offset(15)
//            make.trailing.equalTo(self).offset(-15)
//            make.height.equalTo(20)
//            make.bottom.equalTo(self).offset(-10)
//
//        }
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CALayer {
    private func addShadowWithRoundedCorners(){
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter{ $0.frame.equalTo(self.bounds)}
                .forEach{$0.roundCorners(radius: self.cornerRadius)}
            self.contents = nil
            if let sublayer = sublayers?.first,
            sublayer.name == "contentLayerName" {
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = "contentLayerName"
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
            
        }
    }
    func addShadow(){
        self.shadowOffset = .zero
        self.shadowOpacity = 1
        self.shadowRadius = 10
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }
    func roundCorners(radius : CGFloat){
        self.cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }
}

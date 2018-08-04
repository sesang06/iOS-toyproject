

import Foundation
import UIKit
import SnapKit

class GameDetailViewController : UIViewController {
    var content : GameContent? {
        didSet {
            titleTextView.text = content?.title
            contentTextView.text = content?.content
            if let title = content?.title {
                
                let size = CGSize(width : view.frame.width - 15 - 15,  height : CGFloat.infinity)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let font : UIFont = UIFont(name: "NanumGothicBold", size: 30)!
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
                print(estimatedRect)
                titleTextViewHeightConstraint?.update(offset: estimatedRect.height)
                
            }
            if let content = content?.content {
                let size = CGSize(width : view.frame.width - 15 - 15,  height : CGFloat.infinity)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let font : UIFont = UIFont(name: "NanumGothic", size : 16)!
                let estimatedRect = NSString(string: content).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
                contentTextViewHeightConstraint?.update(offset: estimatedRect.height)
                
            }
            
        }
    }
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    let createdTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size : 15)
        label.textColor = Constants.primaryDarkColor
        label.text = "어제"
        label.textAlignment = .left
        // label.backgroundColor = UIColor.blue
        return label
    }()
    let titleTextView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "NanumGothicBold", size: 30)
        tv.text = "가나다라마바사 아자카남ㄴㅇ럼;ㅏㅣㅇ러ㅏㅣ; ㅇㄴ마ㅣ러;ㅁ아ㅣ너리ㅏㅓ"
        tv.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    let thunbnailImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "dora")
        iv.clipsToBounds = true
//        iv.layer.cornerRadius = 10
        return iv
    }()
    let cheaderImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "dora")
        iv.clipsToBounds = true
        //        iv.layer.cornerRadius = 10
        return iv
    }()
    let contentTextView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "NanumGothic", size : 16)
        tv.textColor = UIColor.black
        tv.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.text = "젤다의 전설젤다의 전설젤다의 전설젤다의 전설젤다의 전설"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    var titleTextViewHeightConstraint : Constraint?
    var contentTextViewHeightConstraint : Constraint?
    override func viewDidLoad() {
        setUpViews()
    }
    let imageContainer = UIView()
    let header = UIView()
    let headerImageView : UIImageView = {
       let iv = UIImageView()
        //headerImageView.frame = header.bounds
        iv.image = UIImage(named: "land")
        iv.contentMode = .scaleAspectFill
        //header.addSubview(headerImageView)
        return iv
    }()
    let headerBlurImageView = UIImageView()
    
    let offset_HeaderStop : CGFloat = 40.0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        header.clipsToBounds = true
//        headerBlurImageView.frame = header.bounds
//        headerBlurImageView.image = UIImage(named: "dora").
//
        
//        var gradient = CAGradientLayer()
//        gradient.frame = self.view.bounds
//        gradient.startPoint = CGPoint(x: 0.5, y: 0)
//        gradient.endPoint = CGPoint(x: 0.5, y: 1)
//        gradient.colors = [
//            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
//            UIColor.black.cgColor,
//            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
//        ]
//        gradient.locations = [0, 0.15 , 0.3]
//        headerImageView.layer.addSublayer(gradient)
    }
    
    func setUpViews(){
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.addSubview(header)
        header.backgroundColor = UIColor.blue
//        scrollView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0)
//        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(150, 0, 0, 0)
        header.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.height.equalTo(114)
        }
        header.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { (make) in
            make.top.trailing.leading.bottom.equalTo(header)
        }
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.bottom.equalTo(self.view)
            
        }
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        scrollView.bounces = true
        
        
        scrollView.addSubview(createdTimeLabel)
        scrollView.addSubview(titleTextView)
        scrollView.addSubview(thunbnailImageView)
        scrollView.addSubview(contentTextView)
        //imageContainer.backgroundColor = .darkGray
        scrollView.addSubview(cheaderImageView)
        
        scrollView.addSubview(imageContainer)
        scrollView.alwaysBounceVertical = true
//        imageContainer.snp.makeConstraints { (make) in
//            make.top.equalTo(scrollView)
//            make.leading.equalTo(scrollView)
//            make.trailing.equalTo(scrollView)
//            make.height.equalTo(imageContainer.snp.width).multipliedBy(0.3)
//
//        }
//        cheaderImageView.snp.makeConstraints { (make) in
//            make.trailing.leading.equalTo(imageContainer)
//            make.top.equalTo(view).priority(.high)
//            make.bottom.equalTo(imageContainer.snp.bottom)
//            make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
//        }
        createdTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(114 + 10)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
            make.height.equalTo(30)
//            make.width.equalTo(scrollView)
        }
        titleTextView.snp.makeConstraints { (make) in
            make.top.equalTo(createdTimeLabel.snp.bottom)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
            titleTextViewHeightConstraint = make.height.equalTo(50).constraint
//            make.width.equalTo(scrollView)
        }
        thunbnailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextView.snp.bottom).offset(10)
            make.leading.equalTo(scrollView)
            make.trailing.equalTo(scrollView)
            make.height.equalTo(250)
            make.width.equalTo(scrollView)
        }
        contentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(thunbnailImageView.snp.bottom).offset(10)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
            contentTextViewHeightConstraint = make.height.equalTo(300).constraint
            make.bottom.equalTo(scrollView).offset(-10)
//            make.width.equalTo(scrollView)
        }
        
        scrollView.bringSubview(toFront: header)
        
    }
}
extension GameDetailViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        print(offset)
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = (
                (header.bounds.height * (1.0 + headerScaleFactor) )
                    - header.bounds.height )/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //  ------------ Label
            
//            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
//            headerLabel.layer.transform = labelTransform
//
            //  ------------ Blur
            
//            headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
//
            // Avatar -----------
            
//            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / avatarImage.bounds.height / 1.4 // Slow down the animation
//            let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
//            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
//            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
//                if avatarImage.layer.zPosition < header.layer.zPosition{
//                    header.layer.zPosition = 0
//                }
                
            }else {
//                if avatarImage.layer.zPosition >= header.layer.zPosition{
//                    header.layer.zPosition = 2
//                }
            }
        }
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        print("hh")
        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(header.frame.height, 0, 0, 0)
        print(header.frame.height)
     //   avatarImage.layer.transform = avatarTransform
        
    }
}

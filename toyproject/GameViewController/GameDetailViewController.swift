

import Foundation
import UIKit
import SnapKit

class GameDetailViewController : UIViewController, UIScrollViewDelegate {
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
            if let thumbnailImageName = content?.thumbnailImageName {
                thunbnailImageView.image = UIImage(named: thumbnailImageName)
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
    
    func setUpViews(){
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            
        }
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
        scrollView.delegate = self
        
        scrollView.addSubview(createdTimeLabel)
        scrollView.addSubview(titleTextView)
        scrollView.addSubview(thunbnailImageView)
        scrollView.addSubview(contentTextView)
        
        scrollView.alwaysBounceVertical = true
        createdTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(10)
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
        
    }
}

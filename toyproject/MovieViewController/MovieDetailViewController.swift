
import Foundation
import UIKit
import SnapKit

class MovieDetailViewController : UIViewController, UIScrollViewDelegate {
    var content : MovieContent? {
        didSet {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5
            let attributes : [NSAttributedStringKey : Any] = [NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font : UIFont(name: "NanumGothic", size: 20)!]
            contentTextView.attributedText = NSAttributedString(string: (self.content?.detailText!)!, attributes: attributes)
            if let detailText = content?.detailText {
                let size = CGSize(width : view.frame.width - (15 + 15 ),  height : CGFloat.infinity)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedRect = NSString(string: detailText).boundingRect(with: size, options: options, attributes: attributes, context: nil)
                detailTextHeightConstraint?.update(offset: estimatedRect.size.height)
                
            }
            
            
        }
    }
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "dora")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 25
        return iv
    }()
    let profileNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size: 14)
        label.text = "파랗게 블루 블루"
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    let createdTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothic", size: 14)
        label.text = "2018. 8. 6. 오전 12:30"
        label.textAlignment = .left
        label.textColor = UIColor.gray
        return label
    }()
    
    let contentTextView : UITextView = {
        
        let tv = UITextView()
        //        tv.text = "거짓말처럼 키스해줘 내가 너에게 마지막 사랑인 것처럼"
        tv.font = UIFont(name: "NanumGothic", size: 14)
        tv.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.isScrollEnabled = false
        tv.isEditable = false
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20
        let attributes = [NSAttributedStringKey.paragraphStyle : style]
        tv.attributedText = NSAttributedString(string: "거짓말처럼 키스해줘", attributes: attributes)
        
        return tv
        
    }()
    var detailTextHeightConstraint :Constraint?
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setUpViews()
    }
    func setUpViews(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
            
        }
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
        
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(profileNameLabel)
        scrollView.addSubview(createdTimeLabel)
        scrollView.addSubview(contentTextView)
        
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView).offset(15 + 2)
            make.leading.equalTo(self.scrollView).offset(15)
            make.height.width.equalTo(50)
        }
        
        profileNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView).offset(25)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self.scrollView).offset(-15)
            make.height.equalTo(20)
        }
        
        contentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.profileImageView.snp.bottom).offset(15)
            make.leading.equalTo(self.scrollView).offset(15)
            make.trailing.equalTo(self.scrollView).offset(-15)
            make.width.equalTo(self.scrollView).offset(-30)
            detailTextHeightConstraint = make.height.equalTo(20).constraint
        }
        
        createdTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentTextView.snp.bottom).offset(15)
            make.leading.equalTo(self.scrollView).offset(15)
            make.trailing.equalTo(self.scrollView).offset(-15)
            make.height.equalTo(20)
            make.bottom.equalTo(self.scrollView).offset(-10)
        }
        
    }
}

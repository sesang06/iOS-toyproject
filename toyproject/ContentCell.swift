

import Foundation
import UIKit
import SnapKit
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
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


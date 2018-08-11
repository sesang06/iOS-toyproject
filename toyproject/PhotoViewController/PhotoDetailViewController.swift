import Foundation
import UIKit
import SnapKit

class PhotoDetailViewController : UIViewController , UIScrollViewDelegate{
    var content :PhotoContent? {
        didSet{
            thumbnailImageView.image = UIImage(named: (self.content?.thumbnailImageName)!)
            if let imageHeight = self.content?.imageHeight, let imageWidth = self.content?.imageWidth {
                let width = self.view.frame.size.width - 20
                let height = width * imageHeight / imageWidth
                thumbnailImageHeightConstraint?.update(offset: height)
            }
            if let titleText = self.content?.titleText {
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 5
                let attributes : [NSAttributedStringKey : Any] = [NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font : UIFont(name: "NanumGothic", size: 20)!]
                titleTextView.attributedText = NSAttributedString(string: titleText, attributes: attributes)
                let size = CGSize(width : view.frame.width - (15 + 15 ),  height : CGFloat.infinity)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedRect = NSString(string: titleText).boundingRect(with: size, options: options, attributes: attributes, context: nil)
                titleTextHeightConstraint?.update(offset: estimatedRect.size.height)
                
            }
            
        }
    }
    var thumbnailImageHeightConstraint : Constraint?
    var titleTextHeightConstraint : Constraint?
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    let titleTextView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "NanumGothic", size : 16)
        tv.textColor = UIColor.black
        tv.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.text = "제1장 답장은 우유 상자에\n제2장 한밤중에 하모니카를\n제3장 시빅 자동차에서 아침까지\n제4장 묵도는 비틀스로\n제5장 하늘 위에서 기도를\n옮긴이의 말"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setUpViews()
    }
    func setUpViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(thumbnailImageView)
        scrollView.addSubview(titleTextView)
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(10)
            make.leading.equalTo(scrollView).offset(10)
            make.trailing.equalTo(scrollView).offset(-10)
            thumbnailImageHeightConstraint = make.height.equalTo(100).constraint
            make.width.equalTo(scrollView).offset(-20)
        }
        
        titleTextView.snp.makeConstraints { (make) in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
            make.leading.equalTo(scrollView).offset(10)
            make.trailing.equalTo(scrollView).offset(-10)
            titleTextHeightConstraint = make.height.equalTo(100).constraint
            make.bottom.equalTo(scrollView).offset(-10)
        }
        
        
    }
}

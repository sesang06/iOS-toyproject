import Foundation
import UIKit
import SnapKit
class PhotoContent : NSObject {
    var thumbnailImageName : String? //섬네일을 가져가기 위한 이미지뷰
    var titleText : String? //타이틀을 가져온다
    var detailText : String? //디테일을 가져온다
    var imageHeight : CGFloat? //이미지 하이트
    var imageWidth : CGFloat?
}

class PhotoCell : UICollectionViewCell {
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
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "tear")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "친구를 만나느라 shy shy shy"
        label.font = UIFont(name: "NanumGothicBold", size: 12)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        
        thumbnailImageView.snp.makeConstraints { (make) in
            thumbnailImageHeightConstraint =  make.height.equalTo(300).constraint
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.height.equalTo(20)
            make.bottom.equalTo(self).offset(-10)
            
        }
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


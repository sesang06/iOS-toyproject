import UIKit
import SnapKit


/*
 비디오
 */
class VideoContent : NSObject {
    var thumbnailImageName : String? //섬네일을 가져가기 위한 이미지뷰
    var titleText : String? //타이틀을 가져온다
    var detailText : String? //디테일을 가져온다
    var imageHeight : CGFloat? //이미지 하이트
    var imageWidth : CGFloat?
}

class VideoCell : BaseCell {
    var content : VideoContent?
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted){
                UIView.animate(withDuration: 0.75) {
                    self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.9)
                }
            }else {
                UIView.animate(withDuration: 0.75) {
                    self.layer.transform = CATransform3DIdentity
                }
            }
        }
    }
    let thumbnailImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        //  iv.layer.cornerRadius =
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "land")
        return iv
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "하루에 네번 사랑을 말하고 여덟번 웃고 여섯번의 키스를 해줘 날 열어주는 단 하나뿐인 비밀번호야 누구도 알수없게 너만이 나를 가질 수 있도록"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    let ownerLabel : UILabel = {
        let label = UILabel()
        label.text = "윤하"
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 1
        label.textColor = UIColor.darkGray
        return label
    }()
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(ownerLabel)
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(5)
            make.leading.equalTo(self).offset(10)
            make.height.equalTo(40)
            make.trailing.equalTo(self).offset(-10)
            
            
        }
        ownerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(self).offset(10)
            make.height.equalTo(15)
            make.trailing.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-5)
        }
    }
}

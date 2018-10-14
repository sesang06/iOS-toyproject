import UIKit
import SnapKit
import SDWebImage


class VideoCell : BaseCell {
    
    var content : VideoContent? {
        didSet {
            let url = URL(string: (content?.thumbnailImageUrl!)!)
            thumbnailImageView.sd_setImage(with: url, completed: nil)
            titleLabel.text = content?.titleText
            ownerLabel.text = content?.username
        }
    }
    
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    let ownerLabel : UILabel = {
        let label = UILabel()
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

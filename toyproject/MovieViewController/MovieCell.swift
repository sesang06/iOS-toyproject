import UIKit
import SnapKit


enum TrendingType {
    case noImage, oneImage, twoImage, threeImage, moreImage
}


class NoImageTrendingCell : MovieCell {
    
}
class OneImageTrendingCell : MovieCell {
    
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
        
    }()
    override var content: MovieContent? {
        didSet {
            thumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
        }
    }
    override func setupViews() {
        super.setupViews()
        addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { (make) in
            make.trailing.leading.equalTo(contentTextView)
            make.top.equalTo(contentTextView.snp.bottom).offset(3 + 10)
            make.height.equalTo(200)
        }
        thumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
//        addSubview(titleTextView)
//        addSubview(contentTextView)
//        addSubview(thumbnailImageView)
//
//        thumbnailImageView.snp.makeConstraints { (make) in
//            make.height.equalTo(200)
//
//            make.top.equalTo(self).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//        }
//        titleTextView.snp.makeConstraints { (make) in
//            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            titleTextHeightConstraint =  make.height.equalTo(20).constraint
//        }
//
//        contentTextView.snp.makeConstraints { (make) in
//            make.top.equalTo(titleTextView.snp.bottom).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            detailTextHeightConstraint = make.height.equalTo(20).constraint
//        }
//

    }
}
class TwoImageTrendingCell : MovieCell {
    
    
    let leftThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
        
    }()
    
    let rightThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
        
    }()
    
    override var content: MovieContent? {
        didSet {
            leftThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            rightThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            
        }
    }
    override func setupViews() {
        super.setupViews()
        addSubview(leftThumbnailImageView)
        addSubview(rightThumbnailImageView)
        leftThumbnailImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentTextView)
            make.top.equalTo(contentTextView.snp.bottom).offset(3 + 10)
            make.height.equalTo(200)
        }
        rightThumbnailImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(leftThumbnailImageView.snp.trailing).offset(3)
            make.trailing.equalTo(contentTextView)
            make.width.equalTo(leftThumbnailImageView.snp.width)
            make.top.equalTo(contentTextView.snp.bottom).offset(3 + 10)
            make.height.equalTo(200)
        }
        
         leftThumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
         rightThumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
//        addSubview(titleTextView)
//        addSubview(contentTextView)
//        addSubview(leftThumbnailImageView)
//        addSubview(rightThumbnailImageView)
//        leftThumbnailImageView.snp.makeConstraints { (make) in
//            make.height.equalTo(leftThumbnailImageView.snp.width)
//            make.top.equalTo(self).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.width.equalTo(self).offset(-15).multipliedBy(0.5)
//        }
//        rightThumbnailImageView.snp.makeConstraints { (make) in
//            make.height.equalTo(rightThumbnailImageView.snp.width)
//            make.top.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            make.width.equalTo(self).offset(-15).multipliedBy(0.5)
//
//        }
//        titleTextView.snp.makeConstraints { (make) in
//            make.top.equalTo(leftThumbnailImageView.snp.bottom).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            titleTextHeightConstraint =  make.height.equalTo(20).constraint
//        }
//
//        contentTextView.snp.makeConstraints { (make) in
//            make.top.equalTo(titleTextView.snp.bottom).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            detailTextHeightConstraint = make.height.equalTo(20).constraint
//        }
    }
}
class ThreeImageTrendingCell : MovieCell {
    
    let leftThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
        
    }()
    let middleThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let rightThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override var content: MovieContent? {
        didSet {
            
            leftThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            middleThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            rightThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            
        }
    }
    override func setupViews() {
        super.setupViews()
        addSubview(leftThumbnailImageView)
        addSubview(middleThumbnailImageView)
        addSubview(rightThumbnailImageView)
        
        middleThumbnailImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentTextView)
            make.top.equalTo(contentTextView.snp.bottom).offset(3 + 10)
            make.height.equalTo(200)
        }
        
        leftThumbnailImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(middleThumbnailImageView.snp.trailing).offset(3)
            make.trailing.equalTo(contentTextView)
            make.top.equalTo(contentTextView.snp.bottom).offset(3 + 10)
            make.width.equalTo(middleThumbnailImageView.snp.width)
            
        }
        rightThumbnailImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(middleThumbnailImageView.snp.trailing).offset(3)
            make.trailing.equalTo(contentTextView)
            make.width.equalTo(middleThumbnailImageView.snp.width)
            make.top.equalTo(leftThumbnailImageView.snp.bottom).offset(3)
            make.bottom.equalTo(middleThumbnailImageView)
            make.height.equalTo(leftThumbnailImageView.snp.height)
            
        }
        middleThumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        leftThumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        rightThumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
    }
}
class FourImageTrendingCell : MovieCell {
    let mainThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    let upperThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    let middleThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    let lowerThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override var content: MovieContent? {
        didSet {
            
            mainThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            upperThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            lowerThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            
        }
    }
    override func setupViews() {
        super.setupViews()
        
        addSubview(mainThumbnailImageView)
        addSubview(upperThumbnailImageView)
        addSubview(middleThumbnailImageView)
        addSubview(lowerThumbnailImageView)

        
        mainThumbnailImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentTextView)
            make.top.equalTo(contentTextView.snp.bottom).offset(3 + 10)
            make.height.equalTo(200)
        }
        
        upperThumbnailImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(mainThumbnailImageView.snp.trailing).offset(3)
            make.trailing.equalTo(contentTextView)
            make.top.equalTo(contentTextView.snp.bottom).offset(3 + 10)
            make.width.equalTo(mainThumbnailImageView.snp.width).dividedBy(2)
        }
        
        middleThumbnailImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(mainThumbnailImageView.snp.trailing).offset(3)
            make.trailing.equalTo(contentTextView)
            
            make.width.equalTo(upperThumbnailImageView.snp.width)
            make.top.equalTo(upperThumbnailImageView.snp.bottom).offset(3)
            make.height.equalTo(upperThumbnailImageView.snp.height)
        }
        lowerThumbnailImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(mainThumbnailImageView.snp.trailing).offset(3)
            make.trailing.equalTo(contentTextView)
            
            make.width.equalTo(upperThumbnailImageView.snp.width)
            make.top.equalTo(middleThumbnailImageView.snp.bottom).offset(3)
            make.height.equalTo(upperThumbnailImageView.snp.height)
           
            make.bottom.equalTo(mainThumbnailImageView)
        }
        mainThumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        upperThumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        middleThumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        lowerThumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        
        //        mainThumbnailImageView.snp.makeConstraints { (make) in
//            make.height.equalTo(mainThumbnailImageView.snp.width).multipliedBy(3.0 / 2.0)
//            make.top.equalTo(self).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.width.equalTo(self).offset(-15).multipliedBy(2.0 / 3.0)
//        }
//        upperThumbnailImageView.snp.makeConstraints { (make) in
//            make.height.equalTo(upperThumbnailImageView.snp.width)
//            make.top.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            make.width.equalTo(self).offset(-15).dividedBy(3)
//
//        }
//        middleThumbnailImageView.snp.makeConstraints { (make) in
//            make.height.equalTo(middleThumbnailImageView.snp.width)
//            make.top.equalTo(upperThumbnailImageView.snp.bottom).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            make.width.equalTo(self).offset(-15).dividedBy(3)
//
//        }
//        lowerThumbnailImageView.snp.makeConstraints { (make) in
//            make.height.equalTo(lowerThumbnailImageView.snp.width)
//            make.top.equalTo(middleThumbnailImageView.snp.bottom).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            make.width.equalTo(self).offset(-15).dividedBy(3)
//
//        }
//
//        titleTextView.snp.makeConstraints { (make) in
//            make.top.equalTo(mainThumbnailImageView.snp.bottom).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            titleTextHeightConstraint =  make.height.equalTo(20).constraint
//        }
//
//        contentTextView.snp.makeConstraints { (make) in
//            make.top.equalTo(titleTextView.snp.bottom).offset(10)
//            make.leading.equalTo(self).offset(10)
//            make.trailing.equalTo(self).offset(-10)
//            detailTextHeightConstraint = make.height.equalTo(20).constraint
//        }
    }
}
protocol MovieCellDelegate : class {
    func thumbnailImageViewDidTapped(_ imageView : UIImageView, _ movieContent: MovieContent?)
    func movieContentDidClicked(_ movieContent: MovieContent?)
    func profileContentDidClicked(_ profileContent: ProfileContent?)
    func videoContentDidClicked(_ videoContent: VideoContent?)
}

class MovieCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @objc func animate(recognizer : UITapGestureRecognizer){
        let imageView = recognizer.view as! UIImageView
        delegate?.thumbnailImageViewDidTapped(imageView, self.content)
        
    }
    @objc func profileDidTapped(recognizer : UITapGestureRecognizer){
        delegate?.profileContentDidClicked(nil)
    }
    
    weak var delegate : MovieCellDelegate?
    var titleTextHeightConstraint : Constraint? = nil
    var detailTextHeightConstraint : Constraint? = nil
    var content : MovieContent? {
        didSet{
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3
            let attributes : [NSAttributedStringKey : Any] = [NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font : UIFont(name: "NanumGothic", size: 14)!]
            contentTextView.attributedText = NSAttributedString(string: (self.content?.detailText!)!, attributes: attributes)
            if let detailText = content?.detailText {
                let size = CGSize(width : frame.width - (15 + 50 + 10),  height : CGFloat.infinity)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

                let estimatedRect = NSString(string: detailText).boundingRect(with: size, options: options, attributes: attributes, context: nil)
                detailTextHeightConstraint?.update(offset: estimatedRect.size.height)
                
            }
            if let profileImageName = content?.profileImageName{
                profileImageView.image = UIImage(named: profileImageName)
            }
            if let profileText = content?.titleText {
                profileNameLabel.text = profileText
            }
        }
    }
    let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
//        iv.image = UIImage(named: "dora")
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        
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
        label.text = " · 5일"
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
        tv.isUserInteractionEnabled = false
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 20
        let attributes = [NSAttributedStringKey.paragraphStyle : style]
        tv.attributedText = NSAttributedString(string: "거짓말처럼 키스해줘", attributes: attributes)

        return tv
        
    }()
    
    let deviderLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
        return view
    }()
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted){
                UIView.animate(withDuration: 0.75) {
                    self.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
                    self.contentTextView.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
                }
            }else {
                UIView.animate(withDuration: 0.75) {
                    self.backgroundColor = UIColor.white
                    self.contentTextView.backgroundColor = UIColor.white
                }
            }
        }
    }
    func setupViews(){
        addSubview(profileImageView)
        addSubview(profileNameLabel)
        addSubview(createdTimeLabel)
        addSubview(contentTextView)
        addSubview(deviderLineView)
        
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15 + 2)
            make.leading.equalTo(self).offset(15)
            make.height.width.equalTo(50)
        }
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileDidTapped)))
        
        profileNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.height.equalTo(20)

        }
        profileNameLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        profileNameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: UILayoutConstraintAxis.horizontal)
        createdTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.leading.equalTo(profileNameLabel.snp.trailing)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(20)
        }
        
        contentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.profileNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self).offset(-10)
            detailTextHeightConstraint = make.height.equalTo(20).constraint
        }
        deviderLineView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(1)
            make.bottom.equalTo(self)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


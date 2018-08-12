import UIKit


class BookCell : BaseCell {
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
    var content : BookContent? {
        didSet {
            titleLabel.text = content?.title
            thunbnailImageView.sd_setImage(with: URL(string : (content?.thumbnailImageUrl)!), completed: nil)
            contentLabel.text = content?.content
            priceLabel.text = "\((content?.price)!)원"
        }
    }
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size: 15)
        label.numberOfLines = 2
        // tv.backgroundColor = UIColor.brown
        return label
    }()
    let thunbnailImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    let contentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothic", size : 14)
        label.textColor = UIColor.black
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    let authorLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothic", size : 14)
        label.textColor = UIColor.black
        label.text = "히가시노 게이고 | 현대문학"
        return label
    }()
    let priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothic", size : 14)
        label.textColor = UIColor.black
        return label
    }()
    let gradePointLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothic", size : 14)
        label.textColor = UIColor.black
        label.text = "9.5 / 10"
        return label
    }()
    let deviderLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
        return view
    }()
    
    
    override func setupViews() {
        addSubview(thunbnailImageView)
        addSubview(deviderLineView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(priceLabel)
        addSubview(gradePointLabel)
        addSubview(contentLabel)
        thunbnailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.bottom.equalTo(deviderLineView.snp.top).offset(-15)
            make.leading.equalTo(self).offset(15)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.leading.equalTo(thunbnailImageView.snp.trailing).offset(15)
            make.trailing.equalTo(self).offset(-15)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(thunbnailImageView.snp.trailing).offset(15)
            make.trailing.equalTo(self).offset(-15)
            
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom)
            make.leading.equalTo(thunbnailImageView.snp.trailing).offset(15)
            make.trailing.equalTo(self).offset(-15)
        }
        gradePointLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom)
            make.leading.equalTo(thunbnailImageView.snp.trailing).offset(15)
            make.trailing.equalTo(self).offset(-15)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(gradePointLabel.snp.bottom)
            make.leading.equalTo(thunbnailImageView.snp.trailing).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-15)
        }
        
        deviderLineView.snp.makeConstraints { (make) in
            //    make.top.equalTo(contentTextView.snp.bottom).offset(10 - 1)
            make.bottom.equalTo(self)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.height.equalTo(1)
            
        }
        
    }
}

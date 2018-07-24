
import Foundation

import UIKit
import SnapKit
class Trending : NSObject {
    var thumbnailImageNames : [String]? //섬네일을 가져가기 위한 이미지뷰 (멀티)
    var titleText : String? //타이틀을 가져온다
    var detailText : String? //디테일을 가져온다
}


enum TrendingType {
    case noImage, oneImage, twoImage, threeImage, moreImage
}

/*
 비디오
 */
class VideoCell : BaseCell {
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

class HotTrendingCell : BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let todaysTrendLabel : UILabel = {
        let label = UILabel()
        label.text = "인기 동영상"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        
        return label
    }()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let cellId = "cellid"
   /* func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee.x )
        if (targetContentOffset.pointee.x == 0 && velocity.x < 0){
            print("hey")
            scrollView.isScrollEnabled = false
        }else {
            scrollView.isScrollEnabled = true
        }
        
    }*/
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.collectionView.scrollView || scrollView == offersCollectionView {
            let offersCollectionViewPosition: CGFloat = offersCollectionView.contentOffset.y
            let scrollViewBottomEdge: CGFloat = scrollView.contentOffset.y + scrollView.frame.height
            if scrollViewBottomEdge >= self.scrollView.contentSize.height {
                self.scrollView.isScrollEnabled = false
                offersCollectionView.isScrollEnabled = true
            } else if offersCollectionViewPosition <= 0.0 && offersCollectionView.isScrollEnabled() {
                self.scrollView.scrollRectToVisible(self.scrollView.frame(), animated: true)
                self.scrollView.isScrollEnabled = true
                offersCollectionView.isScrollEnabled = false
            }
        }
    }*/
    override func setupViews() {
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        addSubview(todaysTrendLabel)
        addSubview(collectionView)
        todaysTrendLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(todaysTrendLabel.snp.bottom).offset(10)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150 , height: frame.height - 40)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


}

class NoImageTrendingCell : TrendingCell {
    
}
class OneImageTrendingCell : TrendingCell {
    
    let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    override var content: Trending? {
        didSet {
            thumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
        }
    }
    override func setupViews() {
        addSubview(titleTextView)
        addSubview(detailTextView)
        addSubview(thumbnailImageView)

        thumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(200)

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
}
class TwoImageTrendingCell : TrendingCell {
    
    
    let leftThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    
    let rightThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    
    override var content: Trending? {
        didSet {
            leftThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            rightThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            
        }
    }
    override func setupViews() {
        addSubview(titleTextView)
        addSubview(detailTextView)
        addSubview(leftThumbnailImageView)
        addSubview(rightThumbnailImageView)
        leftThumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(leftThumbnailImageView.snp.width)
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.width.equalTo(self).offset(-15).multipliedBy(0.5)
        }
        rightThumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(rightThumbnailImageView.snp.width)
            make.top.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.width.equalTo(self).offset(-15).multipliedBy(0.5)

        }
        titleTextView.snp.makeConstraints { (make) in
            make.top.equalTo(leftThumbnailImageView.snp.bottom).offset(10)
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
}
class ThreeImageTrendingCell : TrendingCell {
    
    let leftThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    let middleThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    
    let rightThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    
    override var content: Trending? {
        didSet {
            
            leftThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            middleThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            rightThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            
        }
    }
    override func setupViews() {
        addSubview(titleTextView)
        addSubview(detailTextView)
        addSubview(leftThumbnailImageView)
        addSubview(middleThumbnailImageView)
        addSubview(rightThumbnailImageView)
        leftThumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(leftThumbnailImageView.snp.width).multipliedBy(3.0 / 2.0)
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.width.equalTo(self).offset(-15).multipliedBy(1.0 / 3.0)
        }
        middleThumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(middleThumbnailImageView.snp.width).multipliedBy(3.0 / 2.0)
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(leftThumbnailImageView.snp.trailing).offset(10)
            make.width.equalTo(self).offset(-15).multipliedBy(1.0 / 3.0)
            
        }
        
        rightThumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(rightThumbnailImageView.snp.width).multipliedBy(3.0 / 2.0)
            make.top.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.width.equalTo(self).offset(-15).multipliedBy(1.0 / 3.0)
            
        }
        
        titleTextView.snp.makeConstraints { (make) in
            make.top.equalTo(middleThumbnailImageView.snp.bottom).offset(10)
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
}
class FourImageTrendingCell : TrendingCell {
    let mainThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    let upperThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    let middleThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    
    
    let lowerThumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.black
        imageView.image = UIImage(named: "dora")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        return imageView
        
    }()
    
    override var content: Trending? {
        didSet {
            
            mainThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            upperThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            lowerThumbnailImageView.image = UIImage(named: (content?.thumbnailImageNames![0])!)
            
        }
    }
    override func setupViews() {
        addSubview(titleTextView)
        addSubview(detailTextView)
        addSubview(mainThumbnailImageView)
        addSubview(upperThumbnailImageView)
        addSubview(lowerThumbnailImageView)
        mainThumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(mainThumbnailImageView.snp.width).multipliedBy(3.0 / 2.0)
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(10)
            make.width.equalTo(self).offset(-15).multipliedBy(2.0 / 3.0)
        }
        upperThumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(upperThumbnailImageView.snp.width)
            make.top.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.width.equalTo(self).offset(-15).dividedBy(3)
            
        }
        middleThumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(middleThumbnailImageView.snp.width)
            make.top.equalTo(upperThumbnailImageView.snp.bottom).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.width.equalTo(self).offset(-15).dividedBy(3)
            
        }
        lowerThumbnailImageView.snp.makeConstraints { (make) in
            make.height.equalTo(lowerThumbnailImageView.snp.width)
            make.top.equalTo(middleThumbnailImageView.snp.bottom).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.width.equalTo(self).offset(-15).dividedBy(3)
            
        }
        
        titleTextView.snp.makeConstraints { (make) in
            make.top.equalTo(mainThumbnailImageView.snp.bottom).offset(10)
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
}
class TrendingCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    var titleTextHeightConstraint : Constraint? = nil
    var detailTextHeightConstraint : Constraint? = nil
    var content :Trending? {
        didSet{
            titleTextView.text = self.content?.titleText!
            detailTextView.text = self.content?.detailText!

            if let titleText = content?.titleText {

                let size = CGSize(width : frame.width - 20,  height : 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

                let estimatedRect = NSString(string: titleText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
                titleTextHeightConstraint?.update(offset: max (estimatedRect.size.height + 40, 40))
                
            }
            if let detailText = content?.detailText {
                let size = CGSize(width : frame.width - 20,  height : 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

                let estimatedRect = NSString(string: detailText).boundingRect(with: size, options: options, attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil)
                detailTextHeightConstraint?.update(offset: max (estimatedRect.size.height + 40, 40))
                
            }

        }
    }
    
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
        
        addSubview(titleTextView)
        addSubview(detailTextView)
        
        titleTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
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
        
        self.backgroundColor = UIColor.yellow
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


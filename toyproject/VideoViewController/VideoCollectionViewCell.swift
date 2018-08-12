import UIKit
import SnapKit


class VideoCollectionViewCell : BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate : MovieCellDelegate?
    var contents : [VideoContent]?

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
        fetchVideo()
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
    func fetchVideo(){
        ApiService.shared.fetchVideoContents { (result) in
            switch(result){
            case let .failure(error):
                break
            case let .success(videoContents):
                self.contents = videoContents
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.videoContentDidClicked(nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        cell.content = contents?[indexPath.item]
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

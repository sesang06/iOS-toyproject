

import Foundation
import UIKit


class MovieViewController : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    weak var delegate : MovieCellDelegate?
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    var contents : [MovieContent]?
    let cellid = "cellid"
    let noImageCellId = "noImageCellId"
    let oneImageCellId = "oneImageCellId"
    let twoImageCellId = "twoImageCellId"
    let threeImageCellId = "threeImageCellId"
    let fourImageCellId = "fourImageCellId"
    
    let headerId = "headerId"
    
    func setupContents(){
         contents = [MovieContent]()
        
        contents?.append({
            let trending = MovieContent()
            trending.thumbnailImageNames = [String]()
            trending.thumbnailImageNames?.append("pop")
            trending.titleText = "Itunes"
            trending.profileImageName = "itunes"
            trending.detailText = "\"I'm off the deep end, watch as I dive in.\"\nSee the spark between @LadyGaga and Bradley Cooper in #AStarIsBorn.\nIn theaters now and pre-order today!"
            return trending
            }())
//        for i in 0..<5 {
//            let trending = MovieContent()
//
//
//            if (i % 2 == 0){
//                trending.thumbnailImageNames = [String]()
//                trending.thumbnailImageNames?.append("tear")
//                trending.thumbnailImageNames?.append("dora")
//                trending.titleText = "마지막 처럼"
//                trending.detailText = "\(i)번째 baby 날 터질 것처럼 안아줘 그만 생각해 뭐가 그리 어려워 거짓말 처럼 키스해줘 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼"
//            }else {
//
//                trending.thumbnailImageNames = [String]()
//                trending.thumbnailImageNames?.append("tear")
//                trending.titleText = "빨간맛"
//                trending.detailText = "\(i)번째 빨간 맛 궁금해 허니 깨물면 저점 녹아든 스트로베리 그 맛 코너 캔디 찾아봐 베이비 내가 제일좋아하는 여름그맛"
//            }
//            contents?.append(trending)
//        }
//
//        let trending = MovieContent()
//        trending.thumbnailImageNames = [String]()
//        trending.thumbnailImageNames?.append("tear")
//        trending.thumbnailImageNames?.append("land")
//
//        trending.thumbnailImageNames?.append("dora")
//        trending.thumbnailImageNames?.append("land")
//        trending.titleText = "마지막 처럼"
//        trending.detailText = "번째 baby 날 터질 것처럼 안아줘 그만 생각해 뭐가 그리 어려워 거짓말 처럼 키스해줘 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼"
//        contents?.append(trending)
        contents?.append({
            let trending = MovieContent()
            trending.thumbnailImageNames = [String]()
            trending.thumbnailImageNames?.append("applemusic1")
            trending.thumbnailImageNames?.append("applemusic2")
            trending.titleText = "Genius"
            trending.profileImageName = "genius"
            trending.detailText = "🎧 GENIUS GETS SMART WITH APPLE MUSIC 🎧 \nwe’re proud to make @applemusic our first official music player, AND to add the world’s best lyrics to Apple Music’s growing database, providing lyrics to thousands of hit songs 🙌\nmore info 👉 http://so.genius.com/uDBqA8b\n\n"
            return trending
            }())
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        setupContents()
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        collectionView.register(VideoCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellid)
        collectionView.register(NoImageTrendingCell.self, forCellWithReuseIdentifier : noImageCellId)
        collectionView.register(OneImageTrendingCell.self, forCellWithReuseIdentifier : oneImageCellId)
        collectionView.register(TwoImageTrendingCell.self, forCellWithReuseIdentifier : twoImageCellId)
        collectionView.register(ThreeImageTrendingCell.self, forCellWithReuseIdentifier: threeImageCellId)
        collectionView.register(FourImageTrendingCell.self, forCellWithReuseIdentifier: fourImageCellId)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! VideoCollectionViewCell
        header.delegate = self.delegate
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieContentDidClicked(contents?[indexPath.item])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let count = contents?[indexPath.item].thumbnailImageNames?.count {
            let identifier : String
            if (count == 0){
                identifier = noImageCellId
            }else if (count == 1) {
                identifier = oneImageCellId
            }else if (count == 2){
                identifier = twoImageCellId
            }else if (count == 3) {
                identifier = threeImageCellId
            }else {
                identifier = fourImageCellId
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MovieCell
            cell.delegate = self.delegate
            cell.content = contents?[indexPath.item]
            return cell
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! MovieCell
        cell.content = contents?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = contents?[indexPath.item].thumbnailImageNames?.count ?? 0
        let estimatedTextHeight : CGFloat
        if let detailText = contents?[indexPath.item].detailText {
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3
            let attributes : [NSAttributedStringKey : Any] = [NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font : UIFont(name: "NanumGothic", size: 14)!]
        
            let size = CGSize(width : frame.width - (15 + 50 + 10),  height : CGFloat.infinity)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let estimatedRect = NSString(string: detailText).boundingRect(with: size, options: options, attributes: attributes, context: nil)
        
            estimatedTextHeight = estimatedRect.size.height
        }else {
            estimatedTextHeight = 0
        }
        let estimatedPhotoHeight : CGFloat
        if count == 0 {
            estimatedPhotoHeight = 15 + 20 + 3 + 20 //여백
        }else {
            estimatedPhotoHeight = 15 + 20 + 3 + 10 + 3 + 200 + 20
        }
        return CGSize(width: frame.width, height: estimatedTextHeight + estimatedPhotoHeight)
    }
 }

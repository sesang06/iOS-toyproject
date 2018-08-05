

import Foundation
import UIKit


class PhotoViewController : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PinterestLayoutDelegate  {
    var homeController : HomeController?
    
    lazy var collectionView : UICollectionView = {
        let layout = PinterrestLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        if let layout = cv.collectionViewLayout as? PinterrestLayout {
            layout.delegate = self
        }
        
        return cv
    }()
    var contents : [PhotoContent]?
    let cellid = "cellid"
    
    func setupContents(){
        contents = [PhotoContent]()
        
        for i in 1...3 {
            var image = UIImage()
            let content = PhotoContent()
            if (i % 2 == 0){
                content.thumbnailImageName = "dora"
                content.titleText = "마지막 처럼"
                content.detailText = "\(i)번째 baby 날 터질 것처럼 안아줘 그만 생각해 뭐가 그리 어려워 거짓말 처럼 키스해줘 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼 내가 너에게 마지막 사랑인 것처럼 마지막처럼 마마마지막처럼 마지막인 것 처럼"
            }else {
                content.thumbnailImageName = "tear"
                content.titleText = "빨간맛"
                content.detailText = "\(i)번째 빨간 맛 궁금해 허니 깨물면 저점 녹아든 스트로베리 그 맛 코너 캔디 찾아봐 베이비 내가 제일좋아하는 여름그맛"
            }
            
            image = UIImage(named: content.thumbnailImageName!)!
            content.imageHeight = CGFloat((image.cgImage?.height)!)
            content.imageWidth = CGFloat((image.cgImage?.width)!)
            contents?.append(content)
        }
        let d : PhotoContent = {
            let gc = PhotoContent()
            gc.thumbnailImageName = "indi"
            gc.titleText = "[인디 큐레이터] 무더위, 우리의 지갑을 지킬 '무료 인디 게임'"
            let image = UIImage(named: gc.thumbnailImageName!)!
            gc.imageHeight = CGFloat((image.cgImage?.height)!)
            gc.imageWidth = CGFloat((image.cgImage?.width)!)
            
            
            return gc
        }()
        let e : PhotoContent = {
            let gc = PhotoContent()
            gc.thumbnailImageName = "labor"
            gc.titleText = "노동부 \"게임 서버가 터져도 52시간 근무 지켜야 한다\""
            let image = UIImage(named: gc.thumbnailImageName!)!
            gc.imageHeight = CGFloat((image.cgImage?.height)!)
            gc.imageWidth = CGFloat((image.cgImage?.width)!)
            
            
            return gc
        }()
        let f : PhotoContent = {
            let gc = PhotoContent()
            gc.thumbnailImageName = "land"
            gc.titleText = "파랗게 blue blue 우리가 칠해지네 서로의 맘도 파랗게 멍들어갈 때"
            let image = UIImage(named: gc.thumbnailImageName!)!
            gc.imageHeight = CGFloat((image.cgImage?.height)!)
            gc.imageWidth = CGFloat((image.cgImage?.width)!)
            
            
            return gc
        }()
        contents?.append(f)
        contents?.append(e)
        contents?.append(d)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        backgroundColor = .brown
        setupContents()
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellid)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! PhotoCell
        cell.content = contents?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width / 2, height: self.collectionView(collectionView: collectionView, heightForItemAtIndexPath: indexPath)
        )
    }
    func collectionView(collectionView : UICollectionView, heightForItemAtIndexPath indexPath : IndexPath)-> CGFloat {
        if let imageHeight = self.contents?[indexPath.item].imageHeight, let imageWidth = self.contents?[indexPath.item].imageWidth {
            let width = (self.frame.width / 2) - 20
            let height = width * imageHeight / imageWidth
            print(height)
            return height + 10 + 10 + 20 + 5
        }
        
        return 200
    }
}

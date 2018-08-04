import Foundation
import SnapKit
import UIKit
class BookContent : NSObject {
    var createdTime : Date?
    var title : String?
    var thumbnailImageName : String?
    var content : String?
    var price : Int? //가격
    var index : String? //목차
    var author : String? //저자
    var grade : Float? //평점
    var publisher : String? //출판사
    
}

class BookCell : BaseCell {
    var content : BookContent? {
        didSet {
            //titleTextView.text = content?.title
            //contentTextView.text = content?.content
        }
    }
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size: 15)
        label.text = "나미야 잡화점의 기적(100만 부 기념 특별 한정판) "
        label.numberOfLines = 2
        // tv.backgroundColor = UIColor.brown
        return label
    }()
    let thunbnailImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "namiya")
        iv.clipsToBounds = true
        return iv
    }()
    let contentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothic", size : 14)
        label.textColor = UIColor.black
        label.text = "따뜻한 고민 상담실 ‘나미야 잡화점’으로 오세요!\n일본을 대표하는 소설가 히가시노 게이고의 신작 『나미야 잡화점의 기적』. 2012년 일본 중앙공론문예상 수상작으로, 작가가 그동안 추구해온 인간 내면에 잠재한 선의에 대한 믿음이 작품 전반에 녹아 있다. 오래된 잡화점을 배경으로, 기묘한 편지를 주고받는다는 설정을 통해 따뜻한 이야기를 들려준다.\n30여 년간 비어 있던 오래된 가게인 나미야 잡화점. 어느 날 그곳에 경찰의 눈을 피해 달아나던 삼인조 도둑이 숨어든다. 난데없이 ‘나미야 잡화점 주인’ 앞으로 의문의 편지 한 통이 도착하고, 세 사람은 얼떨결에 편지를 열어본다. 처음에는 장난이라고 생각하던 세 사람은 어느새 편지 내용에 이끌려 답장을 해주기 시작하는데…."
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
        label.text = "13320원"
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

protocol BookViewControllerDelegate : class {
    func bookContentDidClicked(_ bookContent : BookContent?)
}
class BookViewController : BaseCell {
    weak var delegate : BookViewControllerDelegate?
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self

        return cv
    }()
    let cellId = "cellId"
    lazy var contents : [BookContent]? = {
        var cs = [BookContent]()
        let c : BookContent = {
            let gc = BookContent()
            gc.title = "나미야 잡화점의 기적(100만 부 기념 특별 한정판) "
            gc.thumbnailImageName = "namiya"
            gc.createdTime = Date()
            gc.content = "따뜻한 고민 상담실 ‘나미야 잡화점’으로 오세요!\n일본을 대표하는 소설가 히가시노 게이고의 신작 『나미야 잡화점의 기적』. 2012년 일본 중앙공론문예상 수상작으로, 작가가 그동안 추구해온 인간 내면에 잠재한 선의에 대한 믿음이 작품 전반에 녹아 있다. 오래된 잡화점을 배경으로, 기묘한 편지를 주고받는다는 설정을 통해 따뜻한 이야기를 들려준다.\n30여 년간 비어 있던 오래된 가게인 나미야 잡화점. 어느 날 그곳에 경찰의 눈을 피해 달아나던 삼인조 도둑이 숨어든다. 난데없이 ‘나미야 잡화점 주인’ 앞으로 의문의 편지 한 통이 도착하고, 세 사람은 얼떨결에 편지를 열어본다. 처음에는 장난이라고 생각하던 세 사람은 어느새 편지 내용에 이끌려 답장을 해주기 시작하는데…."
            gc.price = 19240
            gc.index = "제1장 답장은 우유 상자에\n제2장 한밤중에 하모니카를\n제3장 시빅 자동차에서 아침까지\n제4장 묵도는 비틀스로\n제5장 하늘 위에서 기도를\n옮긴이의 말"
            gc.author = "히가시노 게이고"
            gc.grade = 5.5
            gc.publisher = "현대문학"
            return gc
        }()
        let d : BookContent = {
            let gc = BookContent()
            gc.title = "나미야 잡화점의 기적(100만 부 기념 특별 한정판) "
            gc.thumbnailImageName = "namiya"
            gc.createdTime = Date()
            gc.content = "따뜻한 고민 상담실 ‘나미야 잡화점’으로 오세요!\n일본을 대표하는 소설가 히가시노 게이고의 신작 『나미야 잡화점의 기적』. 2012년 일본 중앙공론문예상 수상작으로, 작가가 그동안 추구해온 인간 내면에 잠재한 선의에 대한 믿음이 작품 전반에 녹아 있다. 오래된 잡화점을 배경으로, 기묘한 편지를 주고받는다는 설정을 통해 따뜻한 이야기를 들려준다.\n30여 년간 비어 있던 오래된 가게인 나미야 잡화점. 어느 날 그곳에 경찰의 눈을 피해 달아나던 삼인조 도둑이 숨어든다. 난데없이 ‘나미야 잡화점 주인’ 앞으로 의문의 편지 한 통이 도착하고, 세 사람은 얼떨결에 편지를 열어본다. 처음에는 장난이라고 생각하던 세 사람은 어느새 편지 내용에 이끌려 답장을 해주기 시작하는데…."
            gc.price = 19240
            gc.index = "제1장 답장은 우유 상자에\n제2장 한밤중에 하모니카를\n제3장 시빅 자동차에서 아침까지\n제4장 묵도는 비틀스로\n제5장 하늘 위에서 기도를\n옮긴이의 말"
            gc.author = "히가시노 게이고"
            gc.grade = 5.5
            gc.publisher = "현대문학"
            return gc
        }()

        cs.append(c)
        cs.append(d)
        return cs
    }()

    override func setupViews() {
        addSubview(collectionView)

        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: cellId)

    }
}

extension BookViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
extension BookViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookCell
        cell.content = contents?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.bookContentDidClicked(contents?[indexPath.item])
        collectionView.deselectItem(at: indexPath, animated: false)

    }
    
}

extension BookViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 200)
    }
}

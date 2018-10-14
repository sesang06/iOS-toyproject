import Foundation
import SnapKit
import UIKit

class GameCell : BaseCell {
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted){
                UIView.animate(withDuration: 0.75) {
                    self.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
                    self.titleTextView.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
                    self.contentTextView.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
                }
            }else {
                UIView.animate(withDuration: 0.75) {
                    self.backgroundColor = UIColor.white
                    self.titleTextView.backgroundColor = UIColor.white
                    self.contentTextView.backgroundColor = UIColor.white
                  }
            }
        }
    }
    var content : GameContent? {
        didSet {
            titleTextView.text = content?.title
            contentTextView.text = content?.content
            thunbnailImageView.image = UIImage(named: (content?.thumbnailImageName)!)
            if let title = content?.title {
                
                let size = CGSize(width : frame.width - 15 - 15,  height : CGFloat.infinity)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let font : UIFont = UIFont(name: "NanumGothicBold", size: 30)!
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
                print(estimatedRect)
                titleTextViewHeightConstraint?.update(offset: estimatedRect.height)
                
            }
            if let content = content?.content {
                let size = CGSize(width : frame.width - 15 - 15,  height : CGFloat.infinity)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let font : UIFont = UIFont(name: "NanumGothic", size : 16)!
                let estimatedRect = NSString(string: content).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
                contentTextViewHeightConstraint?.update(offset: estimatedRect.height)
                
            }
            
        }
    }
    let createdTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size : 15)
        label.textColor = Constants.primaryDarkColor
        label.text = "어제"
        label.textAlignment = .left
       // label.backgroundColor = UIColor.blue
        return label
    }()
    let titleTextView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "NanumGothicBold", size: 30)
        tv.text = "가나다라마바사 아자카남ㄴㅇ럼;ㅏㅣㅇ러ㅏㅣ; ㅇㄴ마ㅣ러;ㅁ아ㅣ너리ㅏㅓ"
        tv.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.isUserInteractionEnabled = false
       // tv.backgroundColor = UIColor.brown
        return tv
    }()
    let thunbnailImageView : UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "dora")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    let contentTextView : UITextView = {
       let tv = UITextView()
        tv.font = UIFont(name: "NanumGothic", size : 16)
        tv.textColor = UIColor.black
        tv.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.text = "젤다의 전설젤다의 전설젤다의 전설젤다의 전설젤다의 전설"
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.isUserInteractionEnabled = false
        return tv
    }()
    let deviderLineView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
        return view
    }()
    var titleTextViewHeightConstraint : Constraint?
    var contentTextViewHeightConstraint : Constraint?
    override func setupViews() {
        addSubview(createdTimeLabel)
        addSubview(titleTextView)
        addSubview(thunbnailImageView)
        addSubview(contentTextView)
        addSubview(deviderLineView)
        createdTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.height.equalTo(30)
        }
        titleTextView.snp.makeConstraints { (make) in
            make.top.equalTo(createdTimeLabel.snp.bottom)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            titleTextViewHeightConstraint = make.height.equalTo(50).constraint
        }
        thunbnailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(titleTextView.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.height.equalTo(200)
        }
        contentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(thunbnailImageView.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
           contentTextViewHeightConstraint = make.height.equalTo(300).constraint
        }
        deviderLineView.snp.makeConstraints { (make) in
            make.top.equalTo(contentTextView.snp.bottom).offset(10 - 1)
            make.bottom.equalTo(self)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.height.equalTo(1)
            
        }
    }
}

protocol GameViewControllerDelegate : class {
    func gameContentDidClicked(_ gameContent : GameContent?)
}
class GameViewController : BaseCell {
    weak var delegate : GameViewControllerDelegate?
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    let cellId = "cellId"
    lazy var contents : [GameContent]? = {
       var cs = [GameContent]()
        let c : GameContent = {
            let gc = GameContent()
            gc.title = "[기획] 어렵고 죽는 것이 전부? '로그라이크'의 핵심을 찾아서"
            gc.content = "죽고, 죽고, 또 죽고. 그러면서도 우리는 다시 게임을 시작한다. 몇 년 전부터 많은 게임이 로그라이크의 특징을 살려 제작되기 시작했고, 동시에 다양한 파생작이 태어나기 시작했다. 던전을 탐험하는 전통적인 스타일을 넘어서 다양한 장르에 융합되었고, 시뮬레이션과 횡스크롤 액션, FPS에 이르기까지 수 많은 게임에 영향을 미쳤다. \n 그리고 현재, '로그라이크' 또는 '로그라이트'라는 태그를 달고 하루에도 많은 게임이 출시되고 있다. 1980년 처음으로 세상에 등장한 '로그(Rogue)'는 이제는 없어서는 안 될 존재가 된 것처럼 보인다. 적은 리소스를 최대한 활용할 필요가 있는 인디 게임들은 로그라이크라는 장르의 문법을 자신들의 게임에 적극 활용하기도 한다. \n 수많은 파생작. 그리고 진입 장벽을 덜어낸 '로그라이트'라는 세부 장르까지. 게임마다 다른 모습을 보이는 로그라이크의 흔적들. 그렇다면 우리는 무엇을 '로그라이크'라고 부를 수 있을까. 그리고 로그라이크를 활용한 게임이 있다면, 반드시 포함해야 하는 가치는 무엇일까?"
            gc.thumbnailImageName = "rogue"
            return gc
        }()
        let d : GameContent = {
            let gc = GameContent()
            gc.title = "[인디 큐레이터] 무더위, 우리의 지갑을 지킬 '무료 인디 게임'"
            gc.content = "올해 여름 날씨는 너무나 무덥습니다. 에어컨을 풀가동하지 않으면 버티지 못할 수준에 이르렀습니다. 하지만 언제나 그렇듯, 시원함과 전기요금은 반비례하는 법이죠. 방 안의 온도가 올라갈수록 월말 청구서의 금액은 계속해서 올라가고 있습니다. 누진세가 개편됐다고는 하지만 그럼에도 올해 날씨는 예년을 웃도는 청구서를 받아볼 것 같은 느낌도 들고요.\n\n그래서 준비했습니다. 에어컨 가동 탓에, 필연적으로 작년보다 많은 지출이 예정된 우리의 지갑 사정을 고려했습니다. 날씨가 더우니까 세일! 이런 것도 아닙니다. 아예 공짜, 무료로 플레이해볼 수 있는 인디 게임들만을 몇 가지 추려봤습니다. 우리의 지갑 사정은 소중하니까요."
            gc.thumbnailImageName = "indi"
            
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
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: cellId)
        
    }
}

extension GameViewController : UICollectionViewDelegate {
    
}
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GameCell
        cell.content = contents?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.gameContentDidClicked(contents?[indexPath.item])
        collectionView.deselectItem(at: indexPath, animated: false)
        
    }
}

extension GameViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height : CGFloat = 10 + 30 + 10 + 200 + 10 + 10
        if let title = contents?[indexPath.item].title {
            
            let size = CGSize(width : frame.width - 15 - 15,  height : CGFloat.infinity)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let font : UIFont = UIFont(name: "NanumGothicBold", size: 30)!
            let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
            print(estimatedRect)
            height = height + estimatedRect.height
        }
        if let content = contents?[indexPath.item].content {
            let size = CGSize(width : frame.width - 15 - 15,  height : CGFloat.infinity)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let font : UIFont = UIFont(name: "NanumGothic", size : 16)!
            let estimatedRect = NSString(string: content).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
            print(estimatedRect)
            height = height + estimatedRect.height
        }
        return CGSize(width: frame.width, height: height)
    }
}

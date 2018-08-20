import UIKit
import SnapKit
import SDWebImage
class BookDetailViewController : UIViewController {
    var statusBarHeight : CGFloat? {
        didSet {
//            scrollViewTopConstraint?.update(offset: -statusBarHeight!)
            headerTopConstraint?.update(offset: -statusBarHeight!)
//            scrollView.contentInset = UIEdgeInsetsMake(statusBarHeight!, 0, 0, 0)
        }
    }
   
    var content : BookContent? {
        didSet {
            if let url = URL(string : (content?.thumbnailImageUrl)!) {
                headerImageView.sd_setImage(with: url, completed: nil)
            }
            if let title = content?.title {
                titleLabel.text = title
                headerLabel.text = title
            }
            if let author = content?.author, let publisher = content?.publisher, let createdDate = content?.createdTime {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = Locale.current
                authorLabel.text = "\(author) | \(publisher) | \(dateFormatter.string(from: createdDate))"
            }
            if let content = content?.content {
                let size = CGSize(width : view.frame.width - 15 - 15,  height : CGFloat.infinity)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let font : UIFont = UIFont(name: "NanumGothic", size : 16)!
                let estimatedRect = NSString(string: content).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
                contentTextViewHeightConstraint?.update(offset: estimatedRect.height)
                contentTextView.text = content
            }
            if let index = content?.index {
                let size = CGSize(width : view.frame.width - 15 - 15,  height : CGFloat.infinity)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let font : UIFont = UIFont(name: "NanumGothic", size : 16)!
                let estimatedRect = NSString(string: index).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
                print(estimatedRect)
                indexTextView.text = index
                indexTextViewHeightConstraint?.update(offset: estimatedRect.height)
            }
        }
    }
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "나미야 잡화상의 기적"
        label.font = UIFont(name: "NanumGothicExtraBold", size : 17)
        label.textColor = UIColor.white
        return label
    }()
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size: 18)
        label.text = "나미야 잡화점의 기적 (100만 부 특별 기념 한정판)"
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
   
    let authorLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "NanumGothic", size: 16)
        label.text = "히가시노 게이고 (지은이) 양윤옥 (옮긴이) 현대문학 2018-07-27"
        label.numberOfLines = 0
        return label
        
    }()
    let priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothic", size: 16)
        label.text = "정가 14800원"
        label.numberOfLines = 0
        return label
    }()
    let contentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size: 17)
        label.text = "책 소개"
        label.textColor = Constants.primaryDarkColor
        label.numberOfLines = 0
        return label
    }()
    let contentTextView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "NanumGothic", size : 16)
        tv.textColor = UIColor.black
        tv.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.text = "2012년 12월 19일 국내 번역 출간된 이래 6년 연속 베스트셀러 순위 상위권을 차지하며 서점가에서 \"21세기 가장 경이로운 베스트셀러\"라고 불리는 소설. '2008~2017년, 지난 10년간 한국에서 가장 많이 팔린 소설', 히가시노 게이고의 대표작 <나미야 잡화점의 기적>이 국내 누적 판매 100만 부를 돌파했다. \n출간 당시 서점가에서 가장 인기 있던 책은 아니었으나, 독자들의 입소문과 꾸준한 사랑 속에 출간 5년이 지난 지금도 유일하게 베스트셀러에 올라 있는 책이 되었다. 매년 수만 종의 책이 태어나는 출판 시장에서 이러한 이례적인 현상은 해마다 눈길을 끌며 언론의 뜨거운 조명을 받고 있다. \n나아가 이 책에 감명받은 청년들이 소설 속 주요 무대이자 신비한 고민 상담 편지가 오가는 '나미야 잡화점'을 모티프로 삼아 거리에 고민 상담 우체통을 설치하고, 익명의 어플리케이션 소통 공간을 만들며, 중고교 학생들이 교실에 나미야 고민 상담소를 세우는 등 <나미야 잡화점의 기적>은 하나의 사회 현상처럼 되고 있다. 더불어 2017년 일본과 중국에서 각각 영화화되었으며, 2018년 현재 연출가 나루이 유타카가 각색한 연극으로도 제작돼 상연되고 있다. \n 총 5장으로 이루어진 소설은 30여 년째 비어 있는 폐가, '나미야 잡화점'에 숨어든 삼인조 좀도둑이 뜻밖에도 과거로부터 도착한 고민 상담 편지에 답장을 하면서 겪게 되는 기묘한 하룻밤의 이야기를 그린다. 작가는 시공간을 넘나드는 편지라는 설정을 단순한 판타지가 아닌 추리적인 향기와 깊이가 담긴 소재로 승화시키는데, 마치 연작처럼 단편적으로 이어지던 에피소드들이 어느덧 하나로 연결되는 구성 곳곳에서는 최고의 추리소설가다운 절묘한 솜씨가 돋보인다."
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    let indexLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size: 17)
        label.text = "목차"
        label.textColor = Constants.primaryDarkColor
        label.numberOfLines = 0
        return label
    }()
    let indexTextView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "NanumGothic", size : 16)
        tv.textColor = UIColor.black
        tv.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.textContainer.lineFragmentPadding = 0
        tv.text = "제1장 답장은 우유 상자에\n제2장 한밤중에 하모니카를\n제3장 시빅 자동차에서 아침까지\n제4장 묵도는 비틀스로\n제5장 하늘 위에서 기도를\n옮긴이의 말"
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    var indexTextViewHeightConstraint : Constraint?
    var contentTextViewHeightConstraint : Constraint?
    override func viewDidLoad() {
        setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.layer.zPosition = -1
//        navigationBar = self.navigationController?.navigationBar
        // Hide the navigation bar for current view controller
//        self.navigationController?.navigationBar.barTintColor = UIColor.red;
//        self.navigationController?.navigationBar.barTintColor = .clear
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//            self.navigationController?.extendedLayoutIncludesOpaqueBars = true
        
    }
    let header = UIView()
    let blurredEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.clipsToBounds = true
        return blurEffectView
    }()
    let headerImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "namiya")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    let headerBlurImageView = UIImageView()
    lazy var  dissmissButon : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clear")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(actionDismiss), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    @objc func actionDismiss(_ sender : Any){
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    static let offset_HeaderHeight : CGFloat = 300
    let offset_HeaderStop : CGFloat = offset_HeaderHeight - 64 - 3
    let offset_B_LabelHeader:CGFloat = offset_HeaderHeight - 40 // At this offset the Black label reaches the Header
    let distance_W_LabelHeader:CGFloat = 35.0 // The distance between the bottom of the Header and the top
    var headerTopConstraint: Constraint?
    var scrollViewTopConstraint : Constraint?
    func setUpViews(){
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
            
        view.addSubview(header)
        view.addSubview(dissmissButon)
        dissmissButon.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20 + 10)
            make.leading.equalTo(view).offset(10)
            make.width.height.equalTo(24 )
        
        }
        
        let navigationBarHeight: CGFloat = self.topLayoutGuide.length
        header.clipsToBounds = true
        header.layer.masksToBounds = true
        header.snp.makeConstraints { (make) in
           headerTopConstraint = make.top.equalTo(self.topLayoutGuide.snp.bottom).constraint
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.height.equalTo(BookDetailViewController.offset_HeaderHeight - 3)
        }
        scrollView.snp.makeConstraints { (make) in
           scrollViewTopConstraint = make.top.equalTo(self.topLayoutGuide.snp.bottom).constraint
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            
        }
        header.backgroundColor = UIColor.red
        header.addSubview(headerImageView)
        header.addSubview(blurredEffectView)
        blurredEffectView.snp.makeConstraints { (make) in
            make.top.trailing.leading.bottom.equalTo(header)
        }
        blurredEffectView.alpha = 0
        
        headerImageView.snp.makeConstraints { (make) in
            make.top.trailing.leading.bottom.equalTo(header)
        }
        header.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(header)
            make.top.equalTo(header.snp.top).offset(BookDetailViewController.offset_HeaderHeight)
        }
        
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
        
        
        scrollView.addSubview(titleLabel)
        
        scrollView.addSubview(authorLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(contentLabel)
        scrollView.addSubview(contentTextView)
        scrollView.addSubview(indexLabel)
        scrollView.addSubview(indexTextView)
        scrollView.alwaysBounceVertical = true
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(BookDetailViewController.offset_HeaderHeight - 30)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
            make.width.equalTo(scrollView).offset(-30)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom).offset(30)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(30)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
        }
        contentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
            contentTextViewHeightConstraint = make.height.equalTo(3000).constraint
        }
        indexLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentTextView.snp.bottom).offset(10)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
        }
        indexTextView.snp.makeConstraints { (make) in
            make.top.equalTo(indexLabel.snp.bottom).offset(10)
            make.leading.equalTo(scrollView).offset(15)
            make.trailing.equalTo(scrollView).offset(-15)
            indexTextViewHeightConstraint = make.height.equalTo(300).constraint
            make.bottom.equalTo(scrollView).offset(-30)
        }
        
    }
    
}
extension BookDetailViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
//        print(offset)
//        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            if (headerScaleFactor != CGFloat.infinity){
            let headerSizevariation = (
                (header.bounds.height * (1.0 + headerScaleFactor) )
                    - header.bounds.height )/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
            }
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //  ------------ Label
            
                        let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
                        headerLabel.layer.transform = labelTransform
            
            //  ------------ Blur
            print((offset - offset_B_LabelHeader)/distance_W_LabelHeader)
            
                        blurredEffectView.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
//
            // Avatar -----------
            
            //            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / avatarImage.bounds.height / 1.4 // Slow down the animation
            //            let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
            //            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            //            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
                //                if avatarImage.layer.zPosition < header.layer.zPosition{
                //                    header.layer.zPosition = 0
                //                }
                
            }else {
                //                if avatarImage.layer.zPosition >= header.layer.zPosition{
                //                    header.layer.zPosition = 2
                //                }
            }
        }
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(header.frame.height - 64, 0, 0, 0)
        print(header.frame.height)
        print(header.frame)
        //   avatarImage.layer.transform = avatarTransform
        
    }
}

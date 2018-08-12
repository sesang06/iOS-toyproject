
import UIKit
import SnapKit
class HomeController: UIViewController, UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {

    var touchedImageView : UIImageView?
    let zoomImageView = UIImageView()
    let blackBackgroundView = UIView()
    let navBarCoverView = UIView()

    let feedCellId = "feedCellID"
    let facebookCellId = "facebookCellID"
    let postCellId = "postCellID"
    let gameCellId = "gameCellID"
    let bookCellId = "bookCellId"
    let titles = ["피드", "페이스북", "히히", "후호"]
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        self.navigationController?.navigationBar.layer.zPosition = 0
    }
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = Constants.primaryDarkColor
       navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor : Constants.primaryTextColor]
      //  navigationItem.title = "게임"
    
//        navigationController?.navigationBar.isTranslucent = false
        let postButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(actionPost))
        self.navigationItem.leftBarButtonItem = postButton
        
       // self.navigationController?.hidesBarsOnSwipe = true
        setupMenuBar()
        setupCollectionView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func actionPost(sender : Any){
        let vc = PostEditorViewController()
        let navController = UINavigationController(rootViewController: vc) // Creating a navigation controller with resultController at the root of the navigation stack.
        self.present(navController, animated: true, completion: nil)
        
    }
    
    func setupCollectionView(){
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.menuBar.snp.bottom)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView.register(GameViewController.self, forCellWithReuseIdentifier: gameCellId)
        collectionView.register(PhotoViewController.self, forCellWithReuseIdentifier: feedCellId)
        collectionView.register(MovieViewController.self, forCellWithReuseIdentifier: facebookCellId)
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: postCellId )
        collectionView.register(BookViewController.self, forCellWithReuseIdentifier: bookCellId )
        
        collectionView.backgroundColor = UIColor.white
        
        
//        collectionView.contentInset = UIEdgeInsetsMake(50+50, 0, 0, 0)
//        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(50+50, 0, 0, 0)
//
        collectionView.isPagingEnabled = true
        
    }
    func setupMenuBar(){
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.height.equalTo(50)
        }
        //view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        //view.addConstraintsWithFormat("V:|[v0(50)]|", views: menuBar)
//        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    func scrollToMenuIndex(_ menuIndex : Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.update(offset: scrollView.contentOffset.x / 4)
        
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
        
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        menuBar.collectionView.collectionViewLayout.invalidateLayout()
//        let indexPath = IndexPath(item: <#T##Int#>, section: <#T##Int#>)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier : String
        if (indexPath.item == 0){
            identifier = gameCellId
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GameViewController
            cell.delegate = self
            return cell
        }else if (indexPath.item == 1){
            identifier = feedCellId
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoViewController
            cell.delegate = self
            return cell
            
        }else if (indexPath.item == 2){
            identifier = facebookCellId
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MovieViewController
            cell.delegate = self
            return cell
            
        }else if (indexPath.item == 3){
            
            identifier = bookCellId
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BookViewController
            cell.delegate = self
            return cell
        }else{
            identifier = feedCellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension HomeController : EditPhotoProtocol {
    func editPhoto(postContent: PostContent?) {
        let vc = PhotoEditorViewController()
        let navController = UINavigationController(rootViewController: vc) // Creating a navigation controller with resultController at the root of the navigation stack.
        vc.content = postContent
        self.present(navController, animated: true, completion: nil)
        
    }
}

extension HomeController : GameViewControllerDelegate {
    func gameContentDidClicked(_ gameContent: GameContent?) {
        let vc = GameDetailViewController()
        vc.content = gameContent
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension HomeController : BookViewControllerDelegate {
    func bookContentDidClicked(_ bookContent: BookContent?) {
        let vc = BookDetailViewController()
        vc.content = bookContent
        vc.statusBarHeight = self.topLayoutGuide.length
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension HomeController : PhotoViewControllerDelegate {
    func photoContentDidClicked(_ photoContent: PhotoContent?) {
        let vc = PhotoDetailViewController()
        vc.content = photoContent
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension HomeController : MovieCellDelegate {
    func profileContentDidClicked(_ profileContent: ProfileContent?) {
        let vc = ProfileViewController()
        vc.content = profileContent
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func movieContentDidClicked(_ movieContent: MovieContent?) {
        let vc = MovieDetailViewController()
        vc.content = movieContent
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func videoContentDidClicked(_ videoContent: VideoContent?) {
        let vc = VideoDetailViewController()
        vc.content = videoContent
        vc.modalPresentationStyle = .overFullScreen
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    func thumbnailImageViewDidTapped(_ imageView: UIImageView, _ movieContent: MovieContent?) {
        self.touchedImageView = imageView
        if let startingFrame = imageView.superview?.convert(imageView.frame, to: nil){
            imageView.alpha = 0
            
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            
            self.view.addSubview(blackBackgroundView)
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20+44)
            navBarCoverView.backgroundColor = .black
            navBarCoverView.alpha = 0
            
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
            }
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = imageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            self.view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HomeController.zoomOut)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                
                let y = self.view.frame.height / 2 - height / 2
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
                
            }, completion: nil)
            
        }
    }
    @objc func zoomOut(){
        if let startingFrame = touchedImageView!.superview?.convert(touchedImageView!.frame, to: nil){
            UIView.animate(withDuration: 0.75, animations: {
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                
            }) { (complete) in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.touchedImageView?.alpha = 1
                
            }
        }
    }
}


import UIKit
import SnapKit
class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {

    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = Constants.primaryDarkColor
       navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor : Constants.primaryTextColor]
      //  navigationItem.title = "게임"
    
//        navigationController?.navigationBar.isTranslucent = false
        let postButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(actionPost))
        self.navigationItem.leftBarButtonItem = postButton
        
        setupCollectionView()
       // self.navigationController?.hidesBarsOnSwipe = true
        setupMenuBar()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func actionPost(sender : Any){
        let vc = PostEditorViewController()
        let navController = UINavigationController(rootViewController: vc) // Creating a navigation controller with resultController at the root of the navigation stack.
        self.present(navController, animated: true, completion: nil)
        
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.register(GameViewController.self, forCellWithReuseIdentifier: gameCellId)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
        collectionView?.register(FacebookCell.self, forCellWithReuseIdentifier: facebookCellId)
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: postCellId )
        collectionView?.register(BookViewController.self, forCellWithReuseIdentifier: bookCellId )
        
        collectionView?.backgroundColor = UIColor.white
        
        
        collectionView?.contentInset = UIEdgeInsetsMake(50+50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50+50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
        
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
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    func scrollToMenuIndex(_ menuIndex : Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.update(offset: scrollView.contentOffset.x / 4)
        
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
        
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        menuBar.collectionView.collectionViewLayout.invalidateLayout()
//        let indexPath = IndexPath(item: <#T##Int#>, section: <#T##Int#>)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier : String
        if (indexPath.item == 0){
            identifier = gameCellId
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! GameViewController
            cell.delegate = self
            return cell
        }else if (indexPath.item == 1){
            identifier = feedCellId
        }else if (indexPath.item == 2){
            identifier = facebookCellId
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
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
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
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = kCATransitionReveal
//        transition.subtype = kCATransitionFromLeft
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        view.window?.layer.add(transition, forKey: kCATransition)
//
        self.navigationController?.pushViewController(vc, animated: true)
//        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
}



import Foundation
import UIKit
import SnapKit
class TextEditContent : NSObject {
    var text : String?
    var heightConstraint : Constraint?
    var postEditorViewController : PostEditorViewController?
}


/**
 텍스트 에디팅
 */
class TextEditCell : BaseCell{
    let placeholder = "무슨 일이 일어나고 있나요?"
    let textView : UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
        return tv
    }()
    let placeHolderLabel : UILabel = {
        let label = UILabel()
        label.text = "무슨 일이 일어나고 있나요?"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightGray
        label.sizeToFit()
        return label
    }()
    var content : TextEditContent? {
        didSet {
            textView.text = content?.text
        }
    }
    override func setupViews() {
        self.addSubview(textView)
        textView.delegate = self
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.trailing.equalTo(self)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
        }
        textView.addSubview(placeHolderLabel)
        placeHolderLabel.frame.origin = CGPoint(x: 15, y: 10 )
        self.textViewDidChange(textView)
        
    }
    
}
extension TextEditCell : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        placeHolderLabel.isHidden = !textView.text.isEmpty
        let size = CGSize(width: frame.width, height: CGFloat.infinity)
        let estimatedSize = textView.sizeThatFits(size)
        content?.text = textView.text
        content?.postEditorViewController?.resizeCollectionView(height: estimatedSize.height)
    }
}
class PostEditorViewController  : UIViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    let toolBar : UIToolbar = {
       let tb = UIToolbar()
        return tb
    }()
//    let photoBarButtonItem : UIBarButtonItem = {
//        let bbi = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: PostEditorViewController.self, action: #selector(PostEditorViewController.actionPhoto))
//        return bbi
//    }()
//
    @objc func actionPhoto(sender: AnyObject){
        
    }
    let photoCellId = "photoCellId"
    let cellId = "cellId"
    let photoPreviewCellId = "photoPreviewCellId"
    let headerId = "headerId"
    
    let headerTextEditContent : TextEditContent = {
       let tec = TextEditContent()
        return tec
    }()
    var keyboardHeightConstraint : Constraint?
    var headerView : TextEditCell?
    func setUpView(){
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(toolBar.snp.top)
        }
        collectionView.register(PostEditorPhotoCollectionView.self, forCellWithReuseIdentifier: photoCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TextEditCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(PostEditorPhotoPreviewCollectionView.self, forCellWithReuseIdentifier: photoPreviewCellId)
        let photoBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(actionPhoto))
        
        toolBar.setItems([photoBarButtonItem], animated: true)
        toolBar.snp.makeConstraints { (make) in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            keyboardHeightConstraint = make.bottom.equalTo(bottomLayoutGuide.snp.top).constraint
            
        }
    }
    override func viewDidLoad() {
        setUpView()
        setUpNavigationBar()
        headerTextEditContent.postEditorViewController = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    
    func setUpNavigationBar(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "글쓰기"
        let dissmissButon = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(actionDismiss))
        self.navigationItem.leftBarButtonItem = dissmissButon
        
    }
    @objc func actionDismiss(sender : Any){
        self.dismiss(animated: true, completion: nil)
    }
}
extension PostEditorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! TextEditCell
        header.content = headerTextEditContent
        self.headerView = header
        return header
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellId, for: indexPath) as! PostEditorPhotoCollectionView
            cell.grabPhotos()
            return cell
        }else if (indexPath.item == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoPreviewCellId, for: indexPath) as! PostEditorPhotoPreviewCollectionView
            cell.grabPhotos()
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
      //  cell.backgroundColor = UIColor.red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.item == 1) {
            return CGSize(width: view.frame.width, height: 100)
        }
        return CGSize(width: view.frame.width, height: 200)
    }
    func resizeCollectionView(height : CGFloat){
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //
            layout.headerReferenceSize = CGSize(width: view.frame.width, height: max(height, 200))
            self.collectionView.layoutIfNeeded()
            
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scroll\(headerView?.textView.text)")
        headerView?.textView.resignFirstResponder()
    }
}

extension PostEditorViewController : UICollectionViewDataSource {

}

extension PostEditorViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: view.frame.width, height: CGFloat.infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
    }
}

extension PostEditorViewController {
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    func unregisterForKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            print(keyboardFrame)
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.keyboardHeightConstraint?.update(offset: isKeyboardShowing ? -keyboardFrame!.height : 0)
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                //
                //                if isKeyboardShowing {
                //                    let indexPath = NSIndexPath(forItem: self.messages!.count - 1, inSection: 0)
                //                    self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
                //                }
                
            })
        }
    }
    
}

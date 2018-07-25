import Foundation
import UIKit
import SnapKit

class TestEditorViewController  : UIViewController, UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 50)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let cellId = "cellId"
    let headerId = "headerId"
    func setUpView(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        collectionView.register(TextEditCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    override func viewDidLoad() {
        setUpView()
        setUpNavigationBar()
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
extension TestEditorViewController : UICollectionViewDelegate {
    
    
    
    func resizeCollectionView(height : CGFloat){
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            //
            layout.headerReferenceSize = CGSize(width: view.frame.width, height: max(height, 200))
            self.collectionView.layoutIfNeeded()
            
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        <#code#>
    }
}

extension TestEditorViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! TextEditCell
        header.textView.delegate = self
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.red
            return cell
       
    }
}

extension TestEditorViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: view.frame.width, height: CGFloat.infinity)
        let estimatedSize = textView.sizeThatFits(size)
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.headerReferenceSize = CGSize(width: view.frame.width, height: max(estimatedSize.height, 50))
            self.collectionView.layoutIfNeeded()
        }
    }
}

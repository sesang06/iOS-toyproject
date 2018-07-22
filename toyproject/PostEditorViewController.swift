//
//  PostEditorViewController.swift
//  toyproject
//
//  Created by polycube on 2018. 7. 22..
//  Copyright © 2018년 sesang06. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class TextEditContent : NSObject {
    var text : String?
    var heightConstraint : Constraint?
    var delegate : TextEditCellLayoutDelegate?
    var postEditorViewController : PostEditorViewController?
}

protocol TextEditCellLayoutDelegate : class {
    func textEditCell()
}

/**
 텍스트 에디팅
 */
class TextEditCell : BaseCell{
    let textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .lightGray
        tv.text = "hello world"
        tv.isScrollEnabled = false
        return tv
    }()
    var content : TextEditContent? {
        didSet {
            textView.text = content?.text
            textView.snp.makeConstraints { (make) in
                content?.heightConstraint = make.height.equalTo(200).constraint
                
            }
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
        self.textViewDidChange(textView)
        
    }
    
}
extension TextEditCell : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        let size = CGSize(width: frame.width, height: CGFloat.infinity)
        let estimatedSize = textView.sizeThatFits(size)
        content?.heightConstraint?.update(offset: estimatedSize.height)
        print(content?.heightConstraint)
        content?.postEditorViewController?.resizeCollectionView()
    }
}
class PostEditorViewController  : UIViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    let cellid = "cellid"
    let headerId = "headerId"
    
    let textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .lightGray
        tv.text = "hello world"
        tv.isScrollEnabled = false
        return tv
    }()
    let headerTextEditContent : TextEditContent = {
       let tec = TextEditContent()
        tec.text = "asdf"
        return tec
    }()
    var headerView : TextEditCell?
    func setUpView(){
        headerTextEditContent.postEditorViewController = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellid)
        collectionView.register(TextEditCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
//        collectionView.register(TextEditCell.self, forCellWithReuseIdentifier: headerId)
        textView.delegate = self
        
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
extension PostEditorViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let height = headerTextEditContent.heightConstraint {
            print(height.layoutConstraints[0].constant)
            let constant = height.layoutConstraints[0].constant
            return CGSize(width: view.frame.width, height: constant)
        }
        return CGSize(width: view.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! TextEditCell
        header.content = headerTextEditContent
        self.headerView = header
        return header
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    func resizeCollectionView(){
        
        if let height = headerTextEditContent.heightConstraint, let header = headerView {
            print(height.layoutConstraints[0].constant)
            let constant = height.layoutConstraints[0].constant
            header.frame = CGRect(x: header.frame.minX, y: header.frame.minY, width: header.frame.width, height: constant)
            CGSize(width: view.frame.width, height: constant)
        }
        
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

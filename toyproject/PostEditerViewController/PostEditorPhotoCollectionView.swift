

import Foundation
import UIKit
import SnapKit
import Photos

protocol PostEditorPhotoCellDelegate : class {
    func deletePhotoCell(_ sender: PostEditorPhotoCell)
    func editPhotoCell(_ sender: PostEditorPhotoCell)
}
class PostEditorPhotoCell : BaseCell {
    var content : PostContent? {
        didSet{
            
        }
    }
    var representedAssetIdentifier : String?
    weak var delegate : PostEditorPhotoCellDelegate?
    let thumbnailImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "dora")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 10
        return iv
    }()
    let deletePhotoButton : UIButton = {
        let b = UIButton()
        let image = UIImage(named: "clear")?.withRenderingMode(.alwaysTemplate)
        b.tintColor = UIColor.white
        b.setImage(image, for: UIControlState.normal)
        b.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        b.layer.cornerRadius = 15
        b.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
        return b
    }()
    let editPhotoButton : UIButton = {
        let b = UIButton()
        let image = UIImage(named: "edit")?.withRenderingMode(.alwaysTemplate)
        b.tintColor = UIColor.white
        b.setImage(image, for: UIControlState.normal)
        b.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        b.layer.cornerRadius = 15
        b.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
        
        return b
    }()
    override func setupViews() {
        addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
            make.trailing.equalTo(self)
        }
        addSubview(editPhotoButton)
        addSubview(deletePhotoButton)
        editPhotoButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.trailing.equalTo(self).offset(-10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        deletePhotoButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        editPhotoButton.addTarget(self, action: #selector(editAction), for: UIControlEvents.touchUpInside)
        deletePhotoButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
    }
    @objc func editAction(_ sender: UIButton){
        delegate?.editPhotoCell(self)
    }
    @objc func deleteAction(_ sender: UIButton){
        delegate?.deletePhotoCell(self)
    }
    
}

class PostEditorPhotoCollectionView : BaseCell, UICollectionViewDelegateFlowLayout {
    let cellid = "cellid"
    var contents : [PostContent]?
    let imageManager = PHCachingImageManager()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
       // cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
//        cv.isPagingEnabled = true
        return cv
    }()
    override func setupViews() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.trailing.equalTo(self)
            make.leading.equalTo(self)
            make.bottom.equalTo(self)
        }
        collectionView.register(PostEditorPhotoCell.self, forCellWithReuseIdentifier: cellid)
    }
}

extension PostEditorPhotoCollectionView {
    func grabPhotos(){
        DispatchQueue.global(qos: .background).async {
            let fetchOptions = PHFetchOptions()
            fetchOptions.fetchLimit = 10
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
            self.contents = [PostContent]()
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count {
                    let asset = fetchResult.object(at: i)
                    let postContent = PostContent(type : .asset)
                    postContent.asset = asset
                    self.contents?.append(postContent)
                }
            }

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}



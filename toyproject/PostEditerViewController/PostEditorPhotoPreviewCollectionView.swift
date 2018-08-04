import Foundation
import UIKit
import SnapKit
import Photos
/**
사진 목록..
 셀 크기
 */
protocol PostEditorPhotoPreviewCollectionViewDelegate  : class {
    func cameraDidClicked()
    func photoLibraryDidClicked()
    func photoContentDidClicked(_ content : PostContent)
}
class PostEditorPhotoBaseCell : BaseCell {
    
    override func setupViews() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}
class PostEditorPhotoPreviewCell : PostEditorPhotoBaseCell {
    var content : PostContent? {
        didSet{
            
        }
    }
    var representedAssetIdentifier : String?
    let thumbnailImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    override func setupViews() {
        super.setupViews()
        addSubview(thumbnailImageView)
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
}
class PostEditorPhotoCameraCell : PostEditorPhotoBaseCell {
    let altLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        return label
    }()
    let iconImageView : UIImageView = {
        let iv = UIImageView()
        iv.tintColor = Constants.primaryColor
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    override func setupViews() {
        super.setupViews()
        self.addSubview(iconImageView)
        self.addSubview(altLabel)
        
        altLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(0)
            make.centerX.equalTo(self)
            
        }
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
            make.width.equalTo(40)
            
        }
    }
}

class PostEditorPhotoPreviewCollectionView : BaseCell, UICollectionViewDelegateFlowLayout {
    let cellid = "cellid"
    let postEditorPhotoCameraCellId = "photoEditorPhotoCameraCellId"
    let postEditorPhotoPreviewCellId = "postEditorPhotoPreviewCellId"
    var contents : [PostContent]?
    let imageManager = PHCachingImageManager()
    var delegate : PostEditorPhotoPreviewCollectionViewDelegate?
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        //cv.isPagingEnabled = true
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
        collectionView.register(PostEditorPhotoBaseCell.self, forCellWithReuseIdentifier: cellid)
        collectionView.register(PostEditorPhotoCameraCell.self, forCellWithReuseIdentifier: postEditorPhotoCameraCellId)
        collectionView.register(PostEditorPhotoPreviewCell.self, forCellWithReuseIdentifier: postEditorPhotoPreviewCellId)
    }
}

extension PostEditorPhotoPreviewCollectionView : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (contents?.count ?? 0 + 2)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.item == 0){
            self.delegate?.cameraDidClicked()
        }else if (indexPath.item == 1){
            self.delegate?.photoLibraryDidClicked()
        }else {
            if let content = contents?[indexPath.item - 2] {
                self.delegate?.photoContentDidClicked(content)
            }
        }
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.item == 0 ) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postEditorPhotoCameraCellId, for: indexPath) as! PostEditorPhotoCameraCell
            cell.altLabel.text = "카메라"
            cell.iconImageView.image = UIImage(named: "camera")?.withRenderingMode(.alwaysTemplate)
            return cell
        }else if (indexPath.item == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postEditorPhotoCameraCellId, for: indexPath) as! PostEditorPhotoCameraCell
            cell.altLabel.text = "라이브러리"
            cell.iconImageView.image = UIImage(named: "photo")?.withRenderingMode(.alwaysTemplate)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postEditorPhotoPreviewCellId, for: indexPath) as! PostEditorPhotoPreviewCell
            if let content = contents?[indexPath.item - 2], let asset = content.asset {
                cell.content = content
                cell.representedAssetIdentifier = asset.localIdentifier
                let targetSize = CGSize(width: 80 , height : 80 )
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil) { (image, _) in
                    if (cell.representedAssetIdentifier == asset.localIdentifier){
                        cell.thumbnailImageView.image = image
                    }
                }
            }
            return cell
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
extension PostEditorPhotoPreviewCollectionView {
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
extension PostEditorPhotoPreviewCollectionView : UICollectionViewDataSource {
    
}


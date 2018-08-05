import Foundation
import UIKit
import SnapKit
import Photos

/**
 사진을
 */
protocol PostEditorPhotoPickerControllerDelegate  : class {
    func postEditorPhotoPickerController(_ picker : PostEditorPhotoPickerController, didFinishPickingContents contents: [PostContent]? )
}

class PostEditorPhotoPickerController : UIViewController {
    weak var delegate : PostEditorPhotoPickerControllerDelegate?
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        cv.allowsMultipleSelection = true
        return cv
    }()
    
    let imageManager = PHCachingImageManager()
    var contents : [PostContent]?
    var photoSelectedPostContents : [PostContent]? //선택된 것들..
    let cellId = "cellId"
    func grabPhotos(){
        DispatchQueue.global(qos: .background).async {
            let fetchOptions = PHFetchOptions()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
            self.contents = [PostContent]()
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count {
                    let asset = fetchResult.object(at: i)
                    print(asset)
                    let postContent = PostContent(type : .asset)
                    postContent.asset = asset
                    self.contents?.append(postContent)
                    
               //     let selected = self.photoSelectedPostContents?.filter { $0.asset?.localIdentifier == asset.localIdentifier }
//                    if let selected = selected {
//                        self.contents?.append(contentsOf: selected)
//                    }else {
//                        let postContent = PostContent(type : .asset)
//                        postContent.asset = asset
//                        self.contents?.append(postContent)
//                    }
                }
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        setupViews()
        setUpNavigationBar()
        grabPhotos()
    }
    func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        collectionView.register(PostEditPhotoCell.self, forCellWithReuseIdentifier: cellId)
       
    }
    func setUpNavigationBar(){
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "글쓰기"
        let dissmissButon = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(actionDismiss))
        self.navigationItem.leftBarButtonItem = dissmissButon
        let okButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(actionFinish))
        self.navigationItem.rightBarButtonItem = okButton
    }
    @objc func actionDismiss(_ sender : Any){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionFinish(_ sender : Any){
        let indexPaths = collectionView.indexPathsForSelectedItems
        var pickingContents = [PostContent]()
        indexPaths?.forEach({ (indexPath) in
            if let content = contents?[indexPath.item]{
                pickingContents.append(content)
                
            }
        })
        
        self.delegate?.postEditorPhotoPickerController(self, didFinishPickingContents: pickingContents)
    }
}

extension PostEditorPhotoPickerController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
}
extension PostEditorPhotoPickerController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostEditPhotoCell
        
        if let content = contents?[indexPath.item], let asset = content.asset {
            cell.postContent = content
            cell.representedAssetIdentifier = asset.localIdentifier
            let targetSize = DeviceInfo.Orientation.isPortrait ? CGSize(width: view.frame.width/3 - 1 , height : view.frame.width/3 - 1 ) : CGSize(width: view.frame.width/6 - 1 , height : view.frame.width/6 - 1 )
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil) { (image, _) in
                if (cell.representedAssetIdentifier == asset.localIdentifier){
                    cell.photoImageView.image = image
                }
            }
            cell.delegate = self
            cell.selectedNumber = content.selectedNumber
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if DeviceInfo.Orientation.isPortrait {
            return CGSize(width: view.frame.width/3 - 1 , height : view.frame.width/3 - 1 )
        }else {
            return CGSize(width: view.frame.width/6 - 1 , height : view.frame.width/6 - 1 )
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let count = collectionView.indexPathsForSelectedItems?.count ?? 0
        if (count >= 4){
            return false
        }else {
            return true
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PostEditPhotoCell
        
        let count = collectionView.indexPathsForSelectedItems?.count ?? 0
        
        UIView.animate(withDuration : 0.25,
                       delay: 0,
                       usingSpringWithDamping : 1,
                       initialSpringVelocity : 1,
                       options: .curveEaseOut,
                       animations: {
                        cell.photoImageView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
                        
        },
                       completion:  { bool in
                        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
                            cell.photoImageView.layer.transform = CATransform3DIdentity
                            cell.photoImageView.layer.borderWidth = 2
                            cell.blackView.layer.opacity = 0.5
                        }, completion: nil)
                        
        })
        if let content = contents?[indexPath.item]{
            content.selectedNumber = count
        }
        cell.selectedNumber = count
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PostEditPhotoCell
        
        UIView.animate(withDuration : 0.25,
                       delay: 0,
                       usingSpringWithDamping : 1,
                       initialSpringVelocity : 1,
                       options: .curveEaseOut,
                       animations: {
                        cell.photoImageView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
                        
        },
                       completion:  { bool in
                        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
                            cell.photoImageView.layer.transform = CATransform3DIdentity
                            cell.photoImageView.layer.borderWidth = 0
                            cell.blackView.layer.opacity = 0
                        }, completion: nil)
                        
        })
        
        let indexPaths =  collectionView.indexPathsForSelectedItems?.sorted{
            
            if ( contents?[$0.item].selectedNumber ?? 0 < contents?[$1.item].selectedNumber ?? 0 ) {
                return true
            }else{
                return false
            }
        }
        if let  indexPaths = indexPaths {
            for ( index, indexPath) in indexPaths.enumerated() {
                if let cell = collectionView.cellForItem(at: indexPath) as? PostEditPhotoCell {
                    cell.selectedNumber = index + 1
                }
                if let content = contents?[indexPath.item]{
                    content.selectedNumber = index + 1
                }
                
            }
        }
    }
    
}

extension PostEditorPhotoPickerController : EditPhotoProtocol {
    func editPhoto(postContent: PostContent?) {
        
    }
    
    
}

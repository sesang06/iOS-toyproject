import Foundation
import SnapKit
import UIKit


protocol BookViewControllerDelegate : class {
    func bookContentDidClicked(_ bookContent : BookContent?)
}
class BookViewController : BaseCell {
    weak var delegate : BookViewControllerDelegate?
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self

        return cv
    }()
    let cellId = "cellId"
    func fetchContents(){
        ApiService.shared.fetchBookContents { (result) in
            switch(result){
            case let .failure(error):
                break
            case let .success(contents):
                self.contents = contents
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                break
            }
        }
    }
    var contents : [BookContent]?
    override func setupViews() {
        fetchContents()
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: cellId)

    }
}

extension BookViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
extension BookViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookCell
        cell.content = contents?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.bookContentDidClicked(contents?[indexPath.item])
        collectionView.deselectItem(at: indexPath, animated: false)

    }
    
}

extension BookViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 200)
    }
}


import Foundation
import UIKit
import SnapKit
protocol  PinterestLayoutDelegate : class {
    func collectionView(collectionView : UICollectionView, heightForItemAtIndexPath indexPath : IndexPath)-> CGFloat
}
class PinterrestLayout : UICollectionViewLayout {
    var delegate : PinterestLayoutDelegate!
    var numberOfColumns = 2
    
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight : CGFloat = 0
    private var width : CGFloat {
        get {
            return (collectionView?.bounds.width)!
        }
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepare(){
        if cache.isEmpty {
            
            let columnWidth = width / CGFloat(numberOfColumns)
            var xOffsets = [CGFloat]()
            for columns in 0..<numberOfColumns {
                xOffsets.append(CGFloat(columns) * columnWidth)
            }
            
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            var column = 0
            for item in 0..<collectionView!.numberOfItems(inSection: 0){
                let indexPath = IndexPath(item: item, section: 0)
                let height = delegate.collectionView(collectionView: collectionView!, heightForItemAtIndexPath: indexPath)
                let frame = CGRect(x: xOffsets[column], y: yOffset[column], width : columnWidth, height : height)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.frame = frame
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
                
            }
            
        }
        
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}


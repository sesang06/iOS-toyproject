

import Foundation
import UIKit


extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

class Constants {
    static let primaryColor  = UIColor.rgb(100, green: 181, blue: 246)
    static let primaryLightColor  = UIColor.rgb(155, green: 231, blue: 255)
    static let primaryDarkColor  = UIColor.rgb(34, green: 134, blue: 195)
    static let primaryTextColor = UIColor.black
    
}

class BaseCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
    
    
}

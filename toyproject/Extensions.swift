

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


extension UIView{
    func addTopBorder(color: UIColor = UIColor.white, constant : CGFloat = 2 ,margins: CGFloat = 0) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.snp.makeConstraints { (make) in
            make.height.equalTo(constant)
        }
        border.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(-constant)
            make.trailing.equalTo(self)
            make.leading.equalTo(self)
        }
    }
    func addLeadingBorder(color: UIColor = UIColor.white, constant : CGFloat = 2 ,margins: CGFloat = 0) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.snp.makeConstraints { (make) in
            make.width.equalTo(constant)
        }
        border.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.top.equalTo(self)
            make.leading.equalTo(self).offset(-constant)
        }
    }
    func addTrailingBorder(color: UIColor = UIColor.white, constant : CGFloat = 2 ,margins: CGFloat = 0) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.snp.makeConstraints { (make) in
            make.width.equalTo(constant)
        }
        border.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(constant)
        }
    }
    func addBottomBorder(color: UIColor = UIColor.white, constant : CGFloat = 2 ,margins: CGFloat = 0) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        border.snp.makeConstraints { (make) in
            make.height.equalTo(constant)
        }
        border.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(constant)
            make.trailing.equalTo(self)
            make.leading.equalTo(self)
        }
    }
}

extension UIImageView {
    func imageFrame() -> CGRect {
        let imageViewSize = self.frame.size
        guard let imageSize = self.image?.size else { return CGRect.zero}
        let imageRatio = imageSize.width / imageSize.height
        let imageViewRatio = imageViewSize.width / imageViewSize.height
        if imageRatio < imageViewRatio {
            let scaleFactor = imageViewSize.height / imageSize.height
            let width = imageSize.width * scaleFactor
            let topLeftX = (imageViewSize.width - width) * 0.5
            return CGRect(x: topLeftX, y: 0, width: width, height: imageViewSize.height)
        } else {
            let scaleFactor = imageViewSize.width / imageSize.width
            let height = imageSize.height * scaleFactor
            let topLeftY = (imageViewSize.height - height) * 0.5
            
            return CGRect(x: 0, y: topLeftY, width: imageViewSize.width, height: height)
            
        }
    }
}


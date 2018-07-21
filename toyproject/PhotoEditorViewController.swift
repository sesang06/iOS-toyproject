//
//  PhotoEditorViewController.swift
//  toyproject
//
//  Created by polycube on 2018. 7. 15..
//  Copyright © 2018년 sesang06. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Photos

enum FinderPoint {
    case UpperRight
    case UpperLeft
    case LowerRight
    case LowerLeft
}

class PhotoEditorViewController : UIViewController {
//    func setNavigationBar() {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
//
//        navBar.setItems([navItem], animated: false)
//        self.view.addSubview(navBar)
//    }

    func updateMask(){
        let path = UIBezierPath(rect: view.bounds)
        let path2 = UIBezierPath(rect: finderView.frame)
//        path2.usesEvenOddFillRule = true
        path.append(path2)
        headerImageViewMaskLayer.fillRule = kCAFillRuleEvenOdd
        headerImageViewMaskLayer.path = path.cgPath
        
    }
    var headerImageViewMaskLayer : CAShapeLayer!
    func addHeaderImageViewMaskLayer() {
        headerImageViewMaskLayer = CAShapeLayer()
        headerImageViewMaskLayer.fillColor = UIColor.gray.cgColor
        headerImageViewMaskLayer.opacity = 0.5
        headerImageViewMaskLayer.fillRule = kCAFillRuleEvenOdd
        
        maskView.layer.mask = headerImageViewMaskLayer
        maskView.layoutIfNeeded()
    }
    let scrollView : UIScrollView = {
        let sv = UIScrollView()
        sv.maximumZoomScale = 10
        sv.minimumZoomScale = 1
        sv.bouncesZoom = false
        sv.bounces = false
        return sv
    }()
    let finderView : UIView = {
        let v = UIView()
        return v
    }()
    let maskView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        return v
    }()
    let upperRightCornerView : UIView = {
        let v = UIView()
        v.addTopBorder()
        v.addTrailingBorder()
        return v
    }()
    
    let upperLeftCornerView : UIView = {
        let v = UIView()
        v.addTopBorder()
        v.addLeadingBorder()
        return v
    }()
    
    
    let lowerRightCornerView : UIView = {
        let v = UIView()
        v.addBottomBorder()
        v.addTrailingBorder()
        return v
    }()
    
    let lowerLeftCornerView : UIView = {
        let v = UIView()
        v.addBottomBorder()
        v.addLeadingBorder()
        return v
    }()
    var content : PostContent? {
        didSet {
            let targetSize = CGSize(width: view.frame.width , height : view.frame.width )
            let imageManager = PHImageManager()
            
            let options = PHImageRequestOptions()
//            options.version = .original
            options.deliveryMode = .highQualityFormat
            options.resizeMode = .exact
            options.isSynchronous = true
//            imageManager.requestImageForAsset(asset as! PHAsset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.Default, options: options, resultHandler: { (pickedImage, info) in
//
//                self.yourImageview.image = pickedImage // you can get image like this way
//                
//            })
//            imageManager.requestImage(for: (self.content?.asset!)!, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options) { (image, _) in
//                self.photoImageView.image = image
//            }
//            imageManager.requestImageData(for: (self.content?.asset!)!, options: options) { data, _, _ , _ in
//                if let data = data {
//                    self.photoImageView.image = UIImage(data: data)
//                }
//            }
//
            imageManager.requestImage(for: (self.content?.asset!)!, targetSize: targetSize, contentMode: .aspectFit, options: nil) { (image, _) in
                self.photoImageView.image = image
            }

        }
    }
    let photoImageView : UIImageView =  {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    @objc func actionDismiss(sender : Any){
        self.dismiss(animated: true, completion: nil)
    }
    func setUpNavigationBar(){
    
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "사진 편집"
        let dissmissButon = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(actionDismiss))
        self.navigationItem.leftBarButtonItem = dissmissButon
        
    }
    func setUpView(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.trailing.equalTo(view)
            make.leading.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(view)
        }
        scrollView.backgroundColor = UIColor.blue
        scrollView.delegate = self
        
        scrollView.addSubview(photoImageView)
     
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.trailing.equalTo(scrollView)
            make.leading.equalTo(scrollView)
        }
         finderView.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width-20, height: self.view.frame.size.height - 200)
        scrollView.addSubview(maskView)
        
        let realfinderView = UIView()
        scrollView.addSubview(realfinderView)
        maskView.addSubview(finderView)
        realfinderView.snp.makeConstraints { (make) in
            make.top.equalTo(finderView)
            make.bottom.equalTo(finderView)
            make.leading.equalTo(finderView)
            make.trailing.equalTo(finderView)
        }
        
        maskView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
            
        }
        for i in 1...2 {
            let lineView = UIView()
            lineView.backgroundColor = UIColor.white
            realfinderView.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.top.equalTo(realfinderView)
                make.bottom.equalTo(realfinderView)
                make.width.equalTo(1)
                if (i == 0){
                    make.leading.equalTo(realfinderView)
                    
                } else {
                    make.trailing.equalTo(realfinderView.snp.trailing).multipliedBy( Float(i) / 3)
                    
                }
                
            }
        }
        
        for i in 1...2 {
            let lineView = UIView()
            lineView.backgroundColor = UIColor.white
            realfinderView.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.height.equalTo(1)
                
                make.leading.equalTo(realfinderView)
                make.trailing.equalTo(realfinderView)
                if (i==0 ) {
                    make.top.equalTo(realfinderView)
                }else{
                    make.bottom.equalTo(realfinderView).multipliedBy( Float(i) / 3)
                }
            }
        }
        let length = 30
        realfinderView.addSubview(upperLeftCornerView)
        upperLeftCornerView.snp.makeConstraints { (make) in
            make.top.equalTo(realfinderView)
            make.leading.equalTo(realfinderView)
            make.height.equalTo(length)
            make.width.equalTo(length)

        }
        
        realfinderView.addSubview(upperRightCornerView)
        upperRightCornerView.snp.makeConstraints { (make) in
            make.top.equalTo(realfinderView)
            make.trailing.equalTo(realfinderView)
            make.height.equalTo(length)
            make.width.equalTo(length)
        }
        
        realfinderView.addSubview(lowerLeftCornerView)
        lowerLeftCornerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(realfinderView)
            make.leading.equalTo(realfinderView)
            make.height.equalTo(length)
            make.width.equalTo(length)
        }
        realfinderView.layer.borderColor = UIColor.white.cgColor
        realfinderView.layer.borderWidth = 1
        realfinderView.addSubview(lowerRightCornerView)
        lowerRightCornerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(realfinderView)
            make.trailing.equalTo(realfinderView)
            make.height.equalTo(length)
            make.width.equalTo(length)

        }
       view.bringSubview(toFront: scrollView)
    }
    func setUpGesture(){
        let lowerRightPan = UIPanGestureRecognizer(target: self, action: #selector(handleLowerRightPanGesture))
        lowerRightCornerView.addGestureRecognizer(lowerRightPan)
        lowerRightPan.delegate = self
        let upperRightPan = UIPanGestureRecognizer(target: self, action: #selector(handleUpperRightPanGesture))
        upperRightCornerView.addGestureRecognizer(upperRightPan)
        upperRightPan.delegate = self
        let lowerLeftPan = UIPanGestureRecognizer(target: self, action: #selector(handleLowerLeftPanGesture))
        lowerLeftCornerView.addGestureRecognizer(lowerLeftPan)
        lowerLeftPan.delegate = self
        let upperLeftPan = UIPanGestureRecognizer(target: self, action: #selector(handleUpperLeftPanGesture))
        upperLeftCornerView.addGestureRecognizer(upperLeftPan)
        upperLeftPan.delegate = self
    }
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
     //   setNavigationBar()
        setUpNavigationBar()
        addHeaderImageViewMaskLayer()
        setUpView()
        updateMask()
        setUpGesture()
    }
    var startRect : CGRect?
    let const : CGFloat = 30 * 3
    
}
extension PhotoEditorViewController {
    @objc func handleUpperRightPanGesture(recognizer: UIPanGestureRecognizer) {
        
        if (recognizer.state == UIGestureRecognizerState.began){
            startRect = finderView.frame
        }
        
        if (recognizer.state == UIGestureRecognizerState.changed){
            let location = recognizer.location(in: self.view)
            let translation = recognizer.translation(in: self.view)
            print(location)
            print(translation)
            
            if  let startRect = startRect {
                finderView.frame = CGRect(x:  startRect.origin.x , y: min(startRect.maxY - const, startRect.origin.y + translation.y), width: max (startRect.width + translation.x, const), height:  max(startRect.height - translation.y, const))
                updateMask()
                //    setMask(with: finderView.frame, in: photoImageView)
                
            }
        }
    }
    
    @objc func handleUpperLeftPanGesture(recognizer: UIPanGestureRecognizer) {
        
        if (recognizer.state == UIGestureRecognizerState.began){
            startRect = finderView.frame
        }
        
        if (recognizer.state == UIGestureRecognizerState.changed){
            let location = recognizer.location(in: self.view)
            let translation = recognizer.translation(in: self.view)
            print(location)
            print(translation)
            if  let startRect = startRect {
                
                finderView.frame = CGRect(x: min( startRect.origin.x + translation.x , startRect.maxX - const) , y: min ( startRect.origin.y + translation.y,startRect.maxY-const) , width: max(startRect.width - translation.x, const), height: max(startRect.height - translation.y, const))
                updateMask()
                
            }
        }
    }
    
    
    @objc func handleLowerRightPanGesture(recognizer: UIPanGestureRecognizer) {
        
        if (recognizer.state == UIGestureRecognizerState.began){
            startRect = finderView.frame
        }
        
        if (recognizer.state == UIGestureRecognizerState.changed){
            let location = recognizer.location(in: self.view)
            let translation = recognizer.translation(in: self.view)
            print(location)
            print(translation)
            if  let startRect = startRect {
                if (startRect.width - translation.x <= const){
                    
                }
                finderView.frame = CGRect(x: startRect.origin.x , y: startRect.origin.y, width: max (startRect.width + translation.x, const), height: max (startRect.height + translation.y , const))
                updateMask()
                //    setMask(with: finderView.frame, in: photoImageView)
                
            }
        }
    }
    
    @objc func handleLowerLeftPanGesture(recognizer: UIPanGestureRecognizer) {
        
        if (recognizer.state == UIGestureRecognizerState.began){
            startRect = finderView.frame
        }
        
        if (recognizer.state == UIGestureRecognizerState.changed){
            let location = recognizer.location(in: self.view)
            let translation = recognizer.translation(in: self.view)
            print(location)
            print(translation)
            if  let startRect = startRect {
                finderView.frame = CGRect(x: min(startRect.maxX - const, startRect.origin.x + translation.x ), y: startRect.origin.y, width: max (startRect.width - translation.x, const), height: max( startRect.height + translation.y, const))
                updateMask()
                
            }
        }
    }
    
}
extension PhotoEditorViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
}
extension PhotoEditorViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
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
            
        }
        return CGRect.zero
    }
}

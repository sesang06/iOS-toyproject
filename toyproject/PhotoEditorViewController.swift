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
//
    
    override func viewDidAppear(_ animated: Bool) {
        //...생략
        updateHeaderImageViewMask()
    }
    var kHeaderImageViewHeight: CGFloat = 250.0
    let kHeaderImageViewCutAway: CGFloat = 60.0
    func updateHeaderImageViewMask() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: photoImageView.bounds.size.width, y: 0))
        path.addLine(to: CGPoint(x: photoImageView.bounds.size.width, y: photoImageView.bounds.size.height))
        path.addLine(to: CGPoint(x: 0, y: photoImageView.bounds.size.height-kHeaderImageViewCutAway))
        
        let path2 = UIBezierPath()
        
        path2.move(to: CGPoint(x: 40, y:40))
        path2.addLine(to: CGPoint(x: photoImageView.bounds.size.width-40, y: 40))
        path2.addLine(to: CGPoint(x: photoImageView.bounds.size.width-40, y: photoImageView.bounds.size.height-40))
        path2.addLine(to: CGPoint(x: 40, y: photoImageView.bounds.size.height-40-kHeaderImageViewCutAway))
        
        path2.usesEvenOddFillRule = true
        path.append(path2)
        headerImageViewMaskLayer.fillRule = kCAFillRuleEvenOdd
        headerImageViewMaskLayer.path = path.cgPath
    }
    func updateMask(){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: maskView.bounds.size.width, y: 0))
        path.addLine(to: CGPoint(x: maskView.bounds.size.width, y: maskView.bounds.size.height))
        path.addLine(to: CGPoint(x: 0, y: maskView.bounds.size.height))
        
        let path2 = UIBezierPath()
        
        path2.move(to: CGPoint(x: finderView.frame.minX, y: finderView.frame.minY))
        path2.addLine(to: CGPoint(x: finderView.frame.minX, y: finderView.frame.maxY))
        path2.addLine(to: CGPoint(x: finderView.frame.maxX, y: finderView.frame.maxY))
        path2.addLine(to: CGPoint(x: finderView.frame.maxX, y: finderView.frame.minY))
        
        path2.usesEvenOddFillRule = true
        path.append(path2)
        headerImageViewMaskLayer.fillRule = kCAFillRuleEvenOdd
        headerImageViewMaskLayer.path = path.cgPath
        
    }
    var headerImageViewMaskLayer : CAShapeLayer!
    func addHeaderImageViewMaskLayer() {
        headerImageViewMaskLayer = CAShapeLayer()
//        let color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        headerImageViewMaskLayer.fillColor = UIColor.gray.cgColor
        headerImageViewMaskLayer.opacity = 0.5
        
        maskView.layer.mask = headerImageViewMaskLayer
    }
    let finderView : UIView = {
        let v = UIView()
     //   v.backgroundColor = UIColor.black
      //  v.alpha = 0.5
        
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
//        v.addTopLine()
//        v.addLeadingLine()
   //     v.backgroundColor = UIColor.yellow
        return v
    }()
    
    let upperLeftCornerView : UIView = {
        let v = UIView()
        v.addTopBorder()
        v.addLeadingBorder()
//        v.addTopLine()
//        v.addTrailingLine()
        //v.backgroundColor = UIColor.yellow
        return v
    }()
    
    
    let lowerRightCornerView : UIView = {
        let v = UIView()
        v.addBottomBorder()
        v.addTrailingBorder()
//        v.addBottomLine()
//        v.addLeadingLine()
        //v.backgroundColor = UIColor.yellow
        return v
    }()
    
    let lowerLeftCornerView : UIView = {
        let v = UIView()
        v.addBottomBorder()
        v.addLeadingBorder()
//        v.addBottomLine()
//        v.addTrailingLine()
//       // v.backgroundColor = UIColor.yellow
        return v
    }()
    var content : PostContent? {
        didSet {
            let targetSize = CGSize(width: view.frame.width , height : view.frame.width )
            let imageManager = PHImageManager()
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
        view.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
        }
        //photoImageView.mask = finderView
         finderView.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width-20, height: self.view.frame.size.height - 200)
        view.addSubview(maskView)
        
        let realfinderView = UIView()
        view.addSubview(realfinderView)
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
       // setMask(with: finderView.frame, in: photoImageView)
        
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
//            make.height.equalTo(realfinderView).dividedBy(3)
//            make.width.equalTo(realfinderView).dividedBy(3)
            make.top.equalTo(realfinderView)
            make.leading.equalTo(realfinderView)
            make.height.equalTo(length)
            make.width.equalTo(length)

        }
        
        let upperLeftPan = UIPanGestureRecognizer(target: self, action: #selector(handleUpperLeftPanGesture))
        upperLeftCornerView.addGestureRecognizer(upperLeftPan)
        
        realfinderView.addSubview(upperRightCornerView)
        upperRightCornerView.snp.makeConstraints { (make) in
//            make.height.equalTo(realfinderView).dividedBy(3)
//            make.width.equalTo(realfinderView).dividedBy(3)
            make.top.equalTo(realfinderView)
            make.trailing.equalTo(realfinderView)
            make.height.equalTo(length)
            make.width.equalTo(length)
        }
        
        let upperRightPan = UIPanGestureRecognizer(target: self, action: #selector(handleUpperRightPanGesture))
        upperRightCornerView.addGestureRecognizer(upperRightPan)
        
        realfinderView.addSubview(lowerLeftCornerView)
        lowerLeftCornerView.snp.makeConstraints { (make) in
//            make.height.equalTo(realfinderView).dividedBy(3)
//            make.width.equalTo(realfinderView).dividedBy(3)
            make.bottom.equalTo(realfinderView)
            make.leading.equalTo(realfinderView)
            make.height.equalTo(length)
            make.width.equalTo(length)

        }
        realfinderView.layer.borderColor = UIColor.white.cgColor
        realfinderView.layer.borderWidth = 1
      //  realfinderView.addBottomBorder()
        realfinderView.addSubview(lowerRightCornerView)
        lowerRightCornerView.snp.makeConstraints { (make) in
//            make.height.equalTo(realfinderView).dividedBy(3)
//            make.width.equalTo(realfinderView).dividedBy(3)
            make.bottom.equalTo(realfinderView)
            make.trailing.equalTo(realfinderView)
            make.height.equalTo(length)
            make.width.equalTo(length)

        }
//        view.addSubview(maskView)
//        maskView.snp.makeConstraints { (make) in
//            make.top.equalTo(view)
//            make.bottom.equalTo(view)
//            make.trailing.equalTo(view)
//            make.leading.equalTo(view)
//        }
        
//
       addHeaderImageViewMaskLayer()
        updateHeaderImageViewMask()
        
    }
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
     //   setNavigationBar()
        setUpNavigationBar()
        setUpView()
    }
    var startRect : CGRect?
    
}
extension PhotoEditorViewController {
    func setMask(with hole : CGRect, in view : UIView){
        let mutablePath = CGMutablePath()
        mutablePath.addRect(view.bounds)
        mutablePath.addRect(hole)
        let mask = CAShapeLayer()
        mask.path = mutablePath
        mask.fillRule = kCAFillRuleEvenOdd
        view.layer.mask = mask
    }
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
                finderView.frame = CGRect(x: startRect.origin.x , y: startRect.origin.y + translation.y, width: startRect.width + translation.x, height: startRect.height - translation.y)
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
                finderView.frame = CGRect(x: startRect.origin.x + translation.x, y: startRect.origin.y + translation.y, width: startRect.width - translation.x, height: startRect.height - translation.y)
                updateMask()
                
            }
        }
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

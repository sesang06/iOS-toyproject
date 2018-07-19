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
        v.backgroundColor = UIColor.black
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
        v.backgroundColor = UIColor.yellow
        return v
    }()
    
    let upperLeftCornerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.yellow
        return v
    }()
    
    
    let lowerRightCornerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.yellow
        return v
    }()
    
    let lowerLeftCornerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.yellow
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
        view.addSubview(finderView)
        //photoImageView.mask = finderView
         finderView.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width-20, height: self.view.frame.size.height - 20)
        view.addSubview(maskView)
        
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
            finderView.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.top.equalTo(finderView)
                make.bottom.equalTo(finderView)
                make.width.equalTo(1)
                make.trailing.equalTo(finderView.snp.trailing).multipliedBy( Float(i) / 3)
            }
        }
        
        for i in 1...2 {
            let lineView = UIView()
            lineView.backgroundColor = UIColor.white
            finderView.addSubview(lineView)
            lineView.snp.makeConstraints { (make) in
                make.height.equalTo(1)
                
                make.leading.equalTo(finderView)
                make.trailing.equalTo(finderView)
                make.bottom.equalTo(finderView).multipliedBy( Float(i) / 3)
            }
        }
        view.addSubview(upperLeftCornerView)
        upperLeftCornerView.snp.makeConstraints { (make) in
            make.height.equalTo(finderView).dividedBy(3)
            make.width.equalTo(finderView).dividedBy(3)
            make.top.equalTo(finderView)
            make.leading.equalTo(finderView)
        }
        
        let upperLeftPan = UIPanGestureRecognizer(target: self, action: #selector(handleUpperLeftPanGesture))
        upperLeftCornerView.addGestureRecognizer(upperLeftPan)
        
        finderView.addSubview(upperRightCornerView)
        upperRightCornerView.snp.makeConstraints { (make) in
            make.height.equalTo(finderView).dividedBy(3)
            make.width.equalTo(finderView).dividedBy(3)
            make.top.equalTo(finderView)
            make.trailing.equalTo(finderView)
            
        }
        
        let upperRightPan = UIPanGestureRecognizer(target: self, action: #selector(handleUpperRightPanGesture))
        upperRightCornerView.addGestureRecognizer(upperRightPan)
        
        view.addSubview(lowerLeftCornerView)
        lowerLeftCornerView.snp.makeConstraints { (make) in
            make.height.equalTo(finderView).dividedBy(3)
            make.width.equalTo(finderView).dividedBy(3)
            make.bottom.equalTo(finderView)
            make.leading.equalTo(finderView)
        }
        
        
        view.addSubview(lowerRightCornerView)
        lowerRightCornerView.snp.makeConstraints { (make) in
            make.height.equalTo(finderView).dividedBy(3)
            make.width.equalTo(finderView).dividedBy(3)
            make.bottom.equalTo(finderView)
            make.trailing.equalTo(finderView)
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
                
            }
        }
    }
}

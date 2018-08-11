import UIKit
import SnapKit
import AVFoundation
class VideoDetailViewController : UIViewController {
    var content : VideoContent?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white


     
        
        let videoPlayerView = VideoPlayerView()
        
        view.addSubview(videoPlayerView)
        videoPlayerView.snp.makeConstraints { (make) in
            make.top.trailing.leading.equalTo(view)
            make.height.equalTo(videoPlayerView.snp.width).multipliedBy( 9.0 / 16.0)
        }

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGestureRecognizer)
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//
//            view.frame = keyWindow.frame
//
//        }, completion: { (completedAnimation) in
//            //maybe we'll do something here later...
//
//            UIApplication.shared.setStatusBarHidden(true, with: .fade)
//        })

//        if let keyWindow = UIApplication.shared.keyWindow {
//            let view = UIView(frame: keyWindow.frame)
//            view.backgroundColor = UIColor.white
//
//            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
//
//            //16 x 9 is the aspect ratio of all HD videos
//            let height = keyWindow.frame.width * 9 / 16
//            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
//
//            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
//            view.addSubview(videoPlayerView)
//
//            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
//            view.addGestureRecognizer(panGestureRecognizer)
//            keyWindow.addSubview(view)
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//
//                view.frame = keyWindow.frame
//
//            }, completion: { (completedAnimation) in
//                //maybe we'll do something here later...
//
//                UIApplication.shared.setStatusBarHidden(true, with: .fade)
//            })
//        }
    }

    @objc func panGestureRecognizerAction(gesture : UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        view.frame.origin.y = translation.y
        print(translation)
        if gesture.state == .ended {
            let velocity = gesture.velocity(in: view)
            if velocity.y >= 1500 {
                self.dismiss(animated: true, completion: nil)
            }else {
             
                UIView.animate(withDuration: 0.4) {
                    self.view.frame.origin.y = 0;
                }
            }
        }
    }
    
}

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: UIControlState())
        button.tintColor = .white
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        
        return button
    }()
    
    var isPlaying = false
    
    @objc func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: UIControlState())
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: UIControlState())
        }
        
        isPlaying = !isPlaying
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: UIControlState())
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        
        return slider
    }()
    
    @objc func handleSliderChange() {
        print(videoSlider.value)
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                //perhaps do something later here
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        setupGradientLayer()
        
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        controlsContainerView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalTo(self)
        }
        controlsContainerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
        }
        
        controlsContainerView.addSubview(pausePlayButton)
        
        
        pausePlayButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
            make.width.height.equalTo(50)
        }
        
        controlsContainerView.addSubview(videoLengthLabel)
        
        videoLengthLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-8)
            make.bottom.equalTo(self).offset(-2)
            make.width.equalTo(50)
            make.height.equalTo(24)
        }
        controlsContainerView.addSubview(currentTimeLabel)
        
        currentTimeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.bottom.equalTo(self).offset(-2)
            make.width.equalTo(50)
            make.height.equalTo(24)
            
        }
        controlsContainerView.addSubview(videoSlider)
        
        videoSlider.snp.makeConstraints { (make) in
            make.trailing.equalTo(videoLengthLabel.snp.leading)
            make.bottom.equalTo(self)
            make.leading.equalTo(currentTimeLabel.snp.trailing)
            make.height.equalTo(50)
        }
        
        backgroundColor = .black
    }
    weak var playerLayer : AVPlayerLayer?
    weak var player: AVPlayer?
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = self.frame
    }
    fileprivate func setupPlayerView() {
        //warning: use your own video url here, the bandwidth for google firebase storage will run out as more and more people use this file
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer!)
            
            playerLayer?.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            //track player progress
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                let minutesString = String(format: "%02d", Int(seconds / 60))
                
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                //lets move the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)
                    
                }
                
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        print("Showing video player animation....")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            //16 x 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
            }, completion: { (completedAnimation) in
                //maybe we'll do something here later...
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}

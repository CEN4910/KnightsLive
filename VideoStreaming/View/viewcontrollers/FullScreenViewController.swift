//
//  FullScreenViewController.swift
//  VideoStreaming
//
//  Created by Emmanuel on 01/20/19.

import UIKit
import AVKit
import AVFoundation

class FullScreenViewController: UIViewController {

    @IBOutlet weak var buttonFullScreenExit: UIButton!
    
    @IBOutlet weak var imageViewFullScreenExit: UIImageView!
    
    
    
    @IBOutlet weak var buttonPause: UIButton!
    
    @IBOutlet weak var imageViewPause: UIImageView!
    
    
    @IBOutlet var viewVideoStream: UIView!
    
    
    // let videoURL = AppController.videoStreamURL
    
    let videoURL = videoStreamURL//"http://poccloud.purplestream.in/shalomkids/ngrp:shalomkids_all/playlist.m3u8"
    
    
    let avPlayer = AVPlayer() // Object of the Class AVPlayer
    var avPlayerLayer: AVPlayerLayer! // Object of the Class AVPlayerLayer
    
    
    var timer1:Timer? // Timer for Delay to hide Pause button
    
    var timer2:Timer? // Timer for Delay to hide Pause button
    
    
    var videoPaused:Bool = false // To check the video pause flag
    
    var isExpanded:Bool = false
    
    var videoPlayerViewCenter:CGPoint? = nil
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        
        playerLiveVideoStream() // Call the method to play the live stream
        
        
        // To Play the video in Landscape only - Locking Portrait
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewVideoTapAction))
        self.viewVideoStream.addGestureRecognizer(tapGesture)
        viewVideoStream.isUserInteractionEnabled = true
        
        hidePlayPauseButton()
        
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        avPlayer.play() // Start the playback
        
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
        
        
        if videoPaused == true {
            
            avPlayer.isMuted = false
            avPlayer.pause() // Start the playback
            
            
        }
            
        else if videoPaused == false{
            
            
            avPlayer.isMuted = false
            avPlayer.play() // Start the playback
            
            
            
        }
        
        
        //    transformViewToLansdcape()
        
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.none)
        
        print("VIEW DISAPPEARED")
        
        
        // avPlayer.replaceCurrentItem(with: nil)
        
        avPlayer.isMuted = true
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        if videoPaused == true {
            
            print("PAUSED")
            
            imageViewPause.image = UIImage(named: "ic_play.png")
            
            
        }
        else if videoPaused == false {
            print("PLAY")
            
            imageViewPause.image = UIImage(named: "ic_pause.png")
            
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        // Layout subviews manually
        avPlayerLayer.frame = view.frame
        
        
        //        avPlayerLayer.frame = viewVideoStream.bounds
        //
        //        print("avPlayerLayer WIDTH = \(avPlayerLayer.frame.size.width)")
        //        print("avPlayerLayer HEIGHT = \(avPlayerLayer.frame.size.height)")
        //
        //
        //        print("viewVideoStream WIDTH = \(viewVideoStream.frame.size.width)")
        //        print("viewVideoStream HEIGHT = \(viewVideoStream.frame.size.height)")
        //
        //        avPlayerLayer.frame.size.width = self.view.frame.width
        
        
        
        
        
        
    }
    
    override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.landscapeRight
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeRight //return the value as per the required orientation
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if size.width > size.height {
            
            print("LANDSCAPE")
        }
        else{
            
            print("PORTRAIT")
            
            let value = UIInterfaceOrientation.landscapeRight.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            
            
        }
        
    }
    
    // Button Actions
    
    @IBAction func buttonPlayPauseAction(_ sender: Any) {
        
        
        if videoPaused == false {
            
            avPlayer.pause()
            
            videoPaused = true
            
            // Video is now playing
            
            imageViewPause.image = UIImage(named: "ic_play.png")
            
            
            
            
            
            
            
            
        }
        else if videoPaused == true {
            
            // Video is now paused
            
            avPlayer.play()
            
            videoPaused = false
            
            
            imageViewPause.image = UIImage(named: "ic_pause.png")
            
            
            //timer1?.fire()
            
            timer2 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.hidePlayPauseButton), userInfo: nil, repeats: false)
            
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    @IBAction func buttonFullScreenExitAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    // Custom Methods
    
    
    func playerLiveVideoStream(){
        
        
        // An AVPlayerLayer is a CALayer instance to which the AVPlayer can
        // direct its visual output. Without it, the user will see nothing.
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        // let url = NSURL(string: "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")
        
        let url = NSURL(string: videoURL)
        
        
        let playerItem = AVPlayerItem(url: url! as URL)
        avPlayer.replaceCurrentItem(with: playerItem)
        
        
        
        
        
    }
    
    
    @objc func viewVideoTapAction(sender: UITapGestureRecognizer? = nil) {
        
        
        
        showPlayPauseButton()
        
        
        
        if videoPaused == true {
            
            print("PLAY STATUS = \(videoPaused)")
            if timer1 != nil {
                
                timer1?.invalidate()
                timer1 = nil
                
            }
            
        }
        else{
            
            timer1 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.adjustUIElements), userInfo: nil, repeats: false)
            
        }
        
        
        
    }
    
    
    
    // Hide Play/Pause button
    
    
    @objc func hidePlayPauseButton()
    {
        
        
        buttonPause.isHidden = true
        imageViewPause.isHidden = true
        
        buttonFullScreenExit.isHidden = true
        imageViewFullScreenExit.isHidden = true
        
        
        
    }
    
    
    @objc func adjustUIElements(){
        
        
        if videoPaused == true {
            
            // showPlayPauseButton()
            
        }
        else if videoPaused == false {
            
            hidePlayPauseButton()
            
        }
        
    }
    
    // Show Play/Pause button
    
    func showPlayPauseButton()
    {
        
        
        buttonPause.isHidden = false
        imageViewPause.isHidden = false
        
        buttonFullScreenExit.isHidden = false
        imageViewFullScreenExit.isHidden = false
        
        
    }
    
    
    
    
    func transformViewToLansdcape(){
        var rotationDir : Int
        if(UIDevice.current.orientation.isLandscape){
            rotationDir = 1
        }else{
            rotationDir = -1
        }
        var transform = self.view.transform
        //90 for landscapeLeft and 270 for landscapeRight
        transform = transform.rotated(by: (rotationDir*270).degreesToRadians)
        self.view.transform = transform
    }
    
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(Int(self)) * .pi / 180
    }
}


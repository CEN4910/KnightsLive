//
//  StreamViewController.swift
//  VideoStreaming
//
//  Created by Emmanuel on 01/20/19.
import UIKit
import youtube_ios_player_helper
import AVKit
import AVFoundation


class StreamViewController: UIViewController ,VGPlayerDelegate,VGPlayerViewDelegate{
    
    //outlets of headings
    
    @IBOutlet weak var titleHeading: UILabel!
    @IBOutlet weak var titleAuthor: UILabel!
    
    @IBOutlet weak var tableViewStream: UITableView!
    
    
    @IBOutlet weak var videoViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleviewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewVideoStream: UIView!
    
    @IBOutlet weak var titleLogo: UIImageView!
    
    @IBOutlet weak var viewTitleBar: UIView!
    
    
    var scheduleProgramList = [Schedule]()
    
    
    var videoStreamUrl : String = ""
    
    var avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    
    var playerItem:AVPlayerItem!
    
    var paused:Bool = false
    var pauseButtonTapped:Bool = false
    
    var videoPaused:Bool = false
    
    
    
    var isExpanded:Bool = false
    
    var videoPlayerViewCenter:CGPoint? = nil
    
    var videoPlayerDefaultFrame:CGRect? = nil
    
    var player : VGPlayer?
    
    
    var alreadyClicked : Bool = false
    
    var videoStreamId:String?
    
    static var currentScheduleList = [Schedule]()
    
    
    var todayScheduleList = [Schedule]()
    var todayEventList = [Event]()
    
    var weekDay:String = ""
    var weekDayIndex:Int = 0
    
    var fromplaypause : Bool = false
    
    var timer1:Timer? // Timer for Delay to hide Pause button
    
    var timer2:Timer? // Timer for Delay to hide Pause button
    
    var initalContentViewFrame : CGRect! = nil
    
    //Variables
    
    // Declaring and initializing the Week Array
    var weekArray:[String] = [NSLocalizedString("day1", comment: "Day of the week"),NSLocalizedString("day2", comment: "Day of the week"),NSLocalizedString("day3", comment: "Day of the week"),NSLocalizedString("day4", comment: "Day of the week"),NSLocalizedString("day5", comment: "Day of the week"),NSLocalizedString("day6", comment: "Day of the week"),NSLocalizedString("day7", comment: "Day of the week")]
    
    //    var weekArray:[String] = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    
    var orientationChanged : Bool = false
    
    var updater :Int!
    
    var orientationchanged : Bool = false
    
    
    var playPauseButton = UIButton()
    let myFirstButton = UIButton()
    var Toggle : Bool = false
    var Toggleplaypause : Bool = false
    var screenTapped_Flag : Bool = false
    var loadingdone:Bool = false
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLogo.image = #imageLiteral(resourceName: "logo")
        setupUI()
        // Do any additional setup after loading the view.
        
        tableViewStream.delegate = self
        tableViewStream.dataSource = self
        
        //  self.viewVideoStream.delegate = self
        
        videoStreamId = videoStreamUrl
        
        //  videoStreamId = "http://poccloud.purplestream.in/shalomkids/ngrp:shalomkids_all/playlist.m3u8"
        
        
        viewTitleBar.backgroundColor = hexToUiColor().hexStringToUIColor(hex: unselectedDaySelectionColor)
        
        //        playVideoStream()
        
        
        StartPlayingWhenloadingCompleted()
        
        
        weekDayIndex = getWeekDayIndex(week: getDayInWeek())
        
        
        self.todayEventList = scheduleProgramList[self.weekDayIndex].events
        self.tableViewStream.reloadData()
        
        
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewVideoTapAction))
        //        self.viewVideoStream.addGestureRecognizer(tapGesture)
        //        viewVideoStream.isUserInteractionEnabled = true
        
        hidePlayPauseButton()
        
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateSchedule), userInfo: nil, repeats: true)
        
        
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
        
        
        // self.viewVideoStream.playVideo()
        
        if videoPaused == true {
            
            avPlayer.isMuted = false
            avPlayer.pause() // Start the playback
            
        }
            
        else if videoPaused == false{
            
            avPlayer.isMuted = false
            avPlayer.play() // Start the playback
            
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        
        
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.none)
        
        
        
        print("VIEW DISAPPEARED")
        
        
        // avPlayer.replaceCurrentItem(with: nil)
        
        avPlayer.isMuted = true
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        updateSchedule()
        
    }
    
    //    func updateSchedule()
    //    {
    //
    //
    //        print("vineeth current time is",Date().localDateString())
    //        let dateString = String(describing: Date().localDateString())
    //        let df = DateFormatter()
    //        df.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    //        var stringFromDate = dateString
    //
    //
    //
    //        let timeOnly = stringFromDate.components(separatedBy: " ")[1]
    //
    //
    //
    //
    //        let currentHour = Int(timeOnly.components(separatedBy: ":")[0])
    //        let currentMinute = Int(timeOnly.components(separatedBy: ":")[1])
    //        let currentTimeZone = stringFromDate.components(separatedBy: " ")[2]
    //
    //
    //        for i in 0 ... todayEventList.count - 1
    //        {
    //
    //
    //
    //            let showTimeStart = todayEventList[i].showTimeStart
    //            let showTimeEnd = todayEventList[i].showTimeEnd
    //
    //            let showTimeStartComponents = showTimeStart.components(separatedBy: " ")
    //            let showTimeEndComponents = showTimeEnd.components(separatedBy: " ")
    //
    //            let showTimeStartHours = Int(showTimeStartComponents[0].components(separatedBy: ":")[0])
    //            let showTimeStartMinutes = Int(showTimeStartComponents[0].components(separatedBy: ":")[1])
    //            let showTimeStartTimeZone = showTimeStartComponents[1]
    //
    //
    //            let showTimeEndHours = Int(showTimeEndComponents[0].components(separatedBy: ":")[0])
    //            let showTimeEndMinutes = Int(showTimeEndComponents[0].components(separatedBy: ":")[1])
    //            let showTimeEndTimeZone = showTimeEndComponents[1]
    //
    //
    //            if let timeStartHours = showTimeStartHours
    //            {
    //                if let timeEndHours = showTimeEndHours
    //                {
    //                    if let timeStartMinutes = showTimeStartMinutes
    //                    {
    //                        if let timeEndMinutes = showTimeEndMinutes
    //                        {
    //                            if(currentTimeZone == showTimeStartTimeZone)
    //                            {
    //                                if((timeStartHours <= currentHour!) && (timeEndHours >= currentHour!))
    //                                {
    //                                    if((timeStartMinutes <= currentMinute!) && (timeEndMinutes >= currentMinute!))
    //                                    {
    //                                        updater = i
    //                                        break
    //                                    }
    //                                }
    //                            }
    //
    //                        }
    //                    }
    //                }
    //            }
    //
    //
    //
    //        }
    //
    //    }
    
    
    
    
    
    @objc func updateSchedule()
    {
        
        
        for i in 0...todayEventList.count - 1
        {
            let componentsFirst = todayEventList[i].showTimeStart.characters.split { $0 == " " } .map { (x) -> String in return String(x) }
            let componentssecond = todayEventList[i].showTimeEnd.characters.split { $0 == " " } .map { (x) -> String in return String(x) }
            
            
            let showTimeStartTimeZone = componentsFirst[1]
            let showTimeEndTimeZone = componentssecond[1]
            
            
            if componentsFirst != [] &&  componentssecond != []
            {
                let componentsFirstFirst = componentsFirst[0].characters.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }
                let hoursFirst = componentsFirstFirst[0]
                let minutesFirst = componentsFirstFirst[1]
                print("hoursFirst,minutesFirst ",hoursFirst,minutesFirst)
                
                let componentssecondsecond = componentssecond[0].characters.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }
                let hoursFirst2 = componentssecondsecond[0]
                let minutesFirst2 = componentssecondsecond[1]
                
                
                let today = NSDate()
                let dateFormatter = DateFormatter()
                let dateFormat = "hh:mm"
                dateFormatter.dateFormat = dateFormat
                let stringDate = dateFormatter.string(from: today as Date)
                
                let dateString = String(describing: Date().localDateString())
                let currentTimeZone = dateString.components(separatedBy: " ").last
                
                
                
                let componensOriginal = stringDate.characters.split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! }
                
                
                if(currentTimeZone == showTimeStartTimeZone)
                {
                
                if String(hoursFirst) <= String(describing: componensOriginal[0]) && String(minutesFirst) <= String(describing: componensOriginal[1]) && String(hoursFirst2) >= String(componensOriginal[0]) && String(minutesFirst2) >= String(componensOriginal[1])
                {
                    updater = i
                    print(" date : ", stringDate,String(hoursFirst),String(minutesFirst),updater)
                    tableViewStream.reloadData()
                    return
                    
                }
                else
                {
                    if String(hoursFirst) <= String(describing: componensOriginal[0]) && String(minutesFirst) <= String(describing: componensOriginal[1]) && String(hoursFirst2) > String(componensOriginal[0])
                    {
                        updater = i
                        print(" date : second :  ", stringDate,String(hoursFirst),String(minutesFirst),updater)
                        tableViewStream.reloadData()
                        return
                        
                    }
                    
                }
        
            }
            }
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        
    }
    
    
    //
    //    func viewVideoTapAction(sender: UITapGestureRecognizer? = nil) {
    //
    //
    //
    //        showPlayPauseButton()
    //
    //
    //        if videoPaused == true {
    //
    //            print("PLAY STATUS = \(videoPaused)")
    //            if timer1 != nil {
    //
    //                timer1?.invalidate()
    //                timer1 = nil
    //
    //            }
    //
    //        }
    //        else{
    //
    //            timer1 = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.adjustUIElements), userInfo: nil, repeats: false)
    //
    //        }
    //
    //    }
    
    @IBAction func buttonPlayPauseAction(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func buttonFullScreenAction(_ sender: Any) {
        
        
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if self.loadingdone == true && screenTapped_Flag == true
        {
            //                addPlayPauseButton()
            
            if !Toggleplaypause
            {
                
                //                myFirstButton.setImage(#imageLiteral(resourceName: "pausewhitecircleoutline"), for: .normal)
                Toggleplaypause = true
                
            }
            else
            {
                
                //                myFirstButton.setImage(#imageLiteral(resourceName: "playpausewhitcircleOutline"), for: .normal)
                Toggleplaypause = false
                
            }
        }
    }
    
    // Dummy Button Action
    
    
    func addPlayPauseButton()
    {
        
        myFirstButton.setImage(#imageLiteral(resourceName: "pausewhitecircleoutline"),for: .normal)
        myFirstButton.frame = CGRect(x: (self.player?.displayView.bounds.width)!/2.2 , y:  (self.player?.displayView.bounds.height)!/2.5 , width: 64 ,height: 45)
        myFirstButton.addTarget(self, action: #selector(playPauseToggle), for: .touchUpInside)
        self.player?.displayView.addSubview(myFirstButton)
    }
    
    
    func addPlayPauseButtonOnOrientationChanges()
    {
        myFirstButton.frame = CGRect(x: (self.player?.displayView.bounds.width)!/2.2 , y:  (self.player?.displayView.bounds.height)!/2.5 , width: 64 ,height: 45)
        myFirstButton.addTarget(self, action: #selector(playPauseToggle), for: .touchUpInside)
        self.player?.displayView.addSubview(myFirstButton)
    }
    
    
    @objc func playPauseToggle()
    {
        if !Toggleplaypause
        {
            
            self.player?.play()
            
            
            
            //            myFirstButton.setImage(#imageLiteral(resourceName: "pausewhitecircleoutline"), for: .normal)
            Toggleplaypause = true
        }
        else
        {
            self.player?.pause()
            
            //            myFirstButton.setImage(#imageLiteral(resourceName: "playpausewhitcircleOutline"), for: .normal)
            
            Toggleplaypause = false
        }
        
    }
    
    @objc func pressed(sender: UIButton!)
    {
        
        addPlayPauseButtonOnOrientationChanges()
        
        player?.displayView.topView.isHidden = true
        
        //        player?.displayView.enterFullscreen()
        
        //        player?.displayView.bottomView.layer.opacity = 0.5
        
        //        player?.displayView.bottomView.isHidden = true
        
        screenTapped_Flag = true
        myFirstButton.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            
            self.myFirstButton.isHidden = true
            
            
        })
        
        
    }
    
    
    @IBAction func buttonFullScreenActionDummy(_ sender: Any) {
        
        
    }
    
    func StartPlayingWhenloadingCompleted()
    {
        let url = URL(string:  videoStreamURL)//StreamViewController.videoStreamId)
        if url != nil
        {
            player = VGPlayer(URL: url!)
        }
        player?.delegate = self
        view.addSubview((player?.displayView)!)
        player?.backgroundMode = .proceed
        player?.play()
        player?.displayView.delegate = self
        player?.displayView.titleLabel.text = ""
        player?.displayView.closeButton.isHidden = true
        player?.displayView.volumeSlider.isHidden = true
        player?.displayView.timeSlider.isHidden = true
        player?.displayView.timeLabel.isHidden = true
        player?.displayView.titleLabel.text = ""
        player?.displayView.playButtion.isHidden = false
        
        player?.displayView.singleTapGesture.addTarget(self, action: #selector(pressed))
        self.navigationController?.isNavigationBarHidden = true
        
        self.player?.displayView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            
            if !AppController.UserInterfaceIdiomIPad
            {
                if UIScreen.main.bounds.height == 812
                {
                    make.top.equalTo(strongSelf.view.snp.top).inset(88)
                }
                else
                {
                    make.top.equalTo(strongSelf.view.snp.top).inset(64)
                }
            }
            else
            {
                make.top.equalTo(strongSelf.view.snp.top).inset(70)
            }
            
            make.left.equalTo(strongSelf.view.snp.left)
            make.right.equalTo(strongSelf.view.snp.right)
            make.height.equalTo(strongSelf.view.snp.width).multipliedBy(9.0/16.0) // you can 9.0/16.0
        }
        
    }
    
    
    
    public func isVideoPlaying() -> Bool {
        
        if ((avPlayer.rate != 0) && (avPlayer.error == nil)) {
            
            // player is playing
            
            return true
            
        }
        else{
            
            return false
        }
        
        
    }
    
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        
    }
    
    
    public func playVideoStream(){
        
        
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        viewVideoStream.layer.insertSublayer(avPlayerLayer, at: 0)
        
        // let url = NSURL(string: "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8")
        
        let url = NSURL(string: videoStreamId!)
        
        playerItem = AVPlayerItem(url: url! as URL)
        avPlayer.replaceCurrentItem(with: playerItem)
        
    }
    
    
    
    func hidePlayPauseButton()
    {
        
        
        
        
        
    }
    
    
    func adjustUIElements(){
        
        
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
        
        
        
        
    }
    
    
    // Navigate to FullScreenViewController
    
    
    func navigateToFullScreen()
    {
        
        
        
        
    }
    
    
    
    
    func fullScreenPressed(){
        
        
        
    }
    
    
    
    public func getDayInWeek() -> String {
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
        let dayInWeek = dateFormatter.string(from: date as Date)//"Sunday"
        
        
        return dayInWeek
        
    }
    
    
    
    
    public func getWeekDayIndex(week:String) -> Int {
        
        var weekIndex:Int = -1
        
        
        switch week {
            
            
        case "Sunday":
            weekIndex = 0
            break
            
        case "Monday":
            weekIndex = 1
            break
            
        case "Tuesday":
            
            weekIndex = 2
            break
            
            
        case "Wednesday":
            weekIndex = 3
            break
            
            
        case "Thursday":
            weekIndex = 4
            break
            
        case "Friday":
            weekIndex = 5
            break
            
        case "Saturday":
            weekIndex = 6
            break
        case "dimanche":
            weekIndex = 0
            break
            
        case "lundi":
            weekIndex = 1
            break
            
        case "mardi":
            
            weekIndex = 2
            break
            
        case "mercredi":
            weekIndex = 3
            break
            
        case "jeudi":
            weekIndex = 4
            break
            
        case "vendredi":
            weekIndex = 5
            break
            
        case "samedi":
            weekIndex = 6
            break
            
        default:
            
            break
            
        }
        return weekIndex
        
        
    }
    
    
    
}

extension StreamViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableViewStream.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StreamTableViewCell
        
        
        if let currentTimeIndicatorIndex = updater
        {
            if indexPath.row == currentTimeIndicatorIndex
            {
                let event:Event = todayEventList[indexPath.row]
                cell.labelProgramName.text = event.showTitle
                cell.labelProgramTime.text = event.showTimeStart
                cell.secondaryLabel.text = event.showDescription
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = hexToUiColor().hexStringToUIColor(hex: dayTextColor)
                
                
            }
            else
            {
                
                let event:Event = todayEventList[indexPath.row]
                cell.labelProgramName.text = event.showTitle
                cell.labelProgramTime.text = event.showTimeStart
                cell.secondaryLabel.text = event.showDescription
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = hexToUiColor().hexStringToUIColor(hex: daySelectionColor)
                
                
            }
        }
        else
        {
            let event:Event = todayEventList[indexPath.row]
            cell.labelProgramName.text = event.showTitle
            cell.labelProgramTime.text = event.showTimeStart
            cell.secondaryLabel.text = event.showDescription
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = hexToUiColor().hexStringToUIColor(hex: daySelectionColor)
            
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.todayEventList.count
        
        
    }
    
    
}

//pvt methods
extension StreamViewController
{
    func setupUI()
    {
        
    }
}




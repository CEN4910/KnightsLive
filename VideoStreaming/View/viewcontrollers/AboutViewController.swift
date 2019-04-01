//
//  AboutViewController.swift
//  VideoStreaming
//
//  Created by Emmanuel on 01/20/19.

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var webSiteButton: UIButton!
    @IBOutlet weak var faceBookbutton: UIButton!
    
    @IBOutlet weak var websiteimage: UIImageView!
    @IBOutlet weak var youtubeImage: UIImageView!
    @IBOutlet weak var facebookimage: UIImageView!
    @IBOutlet weak var twitterimage: UIImageView!
    @IBOutlet weak var instagramImage: UIImageView!
    
    @IBOutlet weak var SecondaryLabel: UILabel!
    @IBOutlet weak var MainTitle: UILabel!
    @IBOutlet weak var aboutCollectionView: UICollectionView!
    
    @IBOutlet weak var titleLogo: UIImageView!
    var ImageViewArray:NSArray = []
    var count = 0
    @IBOutlet weak var titleview: UIView!
    
    var visibleSite:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        
        titleLogo.image = #imageLiteral(resourceName: "logo")
        
        titleview.backgroundColor = hexToUiColor().hexStringToUIColor(hex: unselectedDaySelectionColor)
      if  facebookLink != ""
      {
        faceBookbutton.isHidden = true
        facebookimage.isHidden = true
        visibleSite.insert(facebookLink, at: count)
        count = count + 1
        ImageViewArray = ImageViewArray.adding(#imageLiteral(resourceName: "facebook")) as NSArray
      }
        
      if websiteLink != ""
      {
        websiteimage.isHidden = true
        webSiteButton.isHidden = true
        visibleSite.insert(websiteLink, at: count)
        count = count + 1
        ImageViewArray = ImageViewArray.adding(#imageLiteral(resourceName: "website")) as NSArray


      }
        
      if youtubeLink != ""
      {
        youtubeImage.isHidden = true
        youtubeButton.isHidden = true
        visibleSite.insert(youtubeLink, at: count)
        count = count + 1
        ImageViewArray = ImageViewArray.adding(#imageLiteral(resourceName: "youtube")) as NSArray

        
      }
        
      if  twitterLink != ""
      {
        twitterimage.isHidden = true
        twitterButton.isHidden = true
        visibleSite.insert(twitterLink, at: count)
        count = count + 1
        ImageViewArray = ImageViewArray.adding(#imageLiteral(resourceName: "twitter")) as NSArray

      }
        
      if  instagramLink != ""
      {
        instagramImage.isHidden = true
        instagramButton.isHidden = true
        visibleSite.insert(instagramLink, at: count)
        count = count + 1
        ImageViewArray = ImageViewArray.adding(#imageLiteral(resourceName: "instagram")) as NSArray

      }
        
        emailLabel.textColor = hexToUiColor().hexStringToUIColor(hex: tableTextColor)
        phoneLabel.textColor = hexToUiColor().hexStringToUIColor(hex: tableTextColor)
        websiteLabel.textColor = hexToUiColor().hexStringToUIColor(hex: tableTextColor)
        MainTitle.textColor = hexToUiColor().hexStringToUIColor(hex: tableTextColor)
        SecondaryLabel.textColor = hexToUiColor().hexStringToUIColor(hex: tableTextColor)
        
        if email == ""
        {
            emailLabel.isHidden = true
        }
        if phone == ""
        {
            phoneLabel.isHidden = true
           
        }
        if website == ""
        {
            websiteLabel.isHidden = true
        }

        if About_Main_Title == ""
        {
            MainTitle.isHidden = true
        }
        else
        {
            MainTitle.text = titleText

        }

        if About_Secondary_Title == ""
        {
            SecondaryLabel.isHidden = true
        }
        else
        {
            SecondaryLabel.text = authorName
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.none)
        
        
    }
    
    
  
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
//    {
//        return UIInterfaceOrientationMask.portrait //return the value as per the required orientation
//    }
//    
//    override var shouldAutorotate: Bool
//    {
//        return false
//    }
    
  
    
    
    // Button actions
    
    
    @IBAction func buttonFacebookAction(_ sender: Any) {
        
        
        let facebook = facebookLink
        let facebookUrl = NSURL(string: facebook)
        if UIApplication.shared.canOpenURL(facebookUrl! as URL)
        {
            UIApplication.shared.openURL(facebookUrl! as URL)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://www.facebook.com/")! as URL)
        }
        
        
        
        
    }
    
    
    @IBAction func buttonWebsiteAction(_ sender: Any) {
        
        let website = websiteLink
        let websiteUrl = NSURL(string: website)
        if UIApplication.shared.canOpenURL(websiteUrl! as URL)
        {
            UIApplication.shared.openURL(websiteUrl! as URL)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            //   UIApplication.shared.openURL(NSURL(string: "https://www.youtube.com/")! as URL)
        }
        
    }
    
    
    @IBAction func buttonYoutubeAction(_ sender: Any) {
        
        let youtube = youtubeLink
        let youtubeUrl = NSURL(string: youtube)
        if UIApplication.shared.canOpenURL(youtubeUrl! as URL)
        {
            UIApplication.shared.openURL(youtubeUrl! as URL)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://www.youtube.com/")! as URL)
        }
      
    }
    
    
    @IBAction func buttonTwitterAction(_ sender: Any) {
        
        
        let twitter = twitterLink
        let twitterUrl = NSURL(string: twitter)
        if UIApplication.shared.canOpenURL(twitterUrl! as URL)
        {
            UIApplication.shared.openURL(twitterUrl! as URL)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://twitter.com")! as URL)
        }
       
        
    }
    
    
    @IBAction func buttonInstagramAction(_ sender: Any) {
        
        let instagram = instagramLink
        let instagramUrl = NSURL(string: instagram)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.openURL(instagramUrl! as URL)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/")! as URL)
        }
   
    }
    func buttonSiteOpenAction(index : Int) {
        
        let sampleUrl = visibleSite[index]
        let instagramUrl = NSURL(string: sampleUrl as! String)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.openURL(instagramUrl! as URL)
            
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "https://www.google.com/")! as URL)
        }
        
    }

}

//private function
extension AboutViewController
{
    func setupUi()
    {
        emailLabel.text = email
        phoneLabel.text = phone
        websiteLabel.text = website
    }
}
extension AboutViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aboutCollectionViewCell = aboutCollectionView.dequeueReusableCell(withReuseIdentifier: "AboutCollectionViewCell", for: indexPath) as! AboutCollectionViewCell
        
         aboutCollectionViewCell.iconImageView.tintColor = UIColor.white
         let image = (ImageViewArray[indexPath.row] as AnyObject).withRenderingMode(.alwaysTemplate)
         aboutCollectionViewCell.iconImageView.tintColor = UIColor.white
         aboutCollectionViewCell.iconImageView.image = image
         aboutCollectionViewCell.iconImageView.backgroundColor = UIColor.clear
        
        
        return aboutCollectionViewCell
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ImageViewArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        print("you selected \(indexPath.row)")
        
        switch (indexPath.row)
        {
        case 0: buttonSiteOpenAction(index: indexPath.row)
            break
        case 1: buttonSiteOpenAction(index: indexPath.row)
            break
        case 2: buttonSiteOpenAction(index: indexPath.row)
            break
        case 3: buttonSiteOpenAction(index: indexPath.row)
            break
        case 4: buttonSiteOpenAction(index: indexPath.row)
            break
        default : break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize: CGSize? = nil
        if AppController.UserInterfaceIdiom == AppController.DEVICE_IPHONE
        {
            cellSize = CGSize(width: (UIScreen.main.bounds.size.width / 2) / CGFloat(count), height: aboutCollectionView.bounds.size.height)
        }
        else
        {
            cellSize = CGSize(width: (UIScreen.main.bounds.size.width / 2) / CGFloat(count + 1), height: aboutCollectionView.bounds.size.height)

        }
        //0.624
        return cellSize!
    }

}


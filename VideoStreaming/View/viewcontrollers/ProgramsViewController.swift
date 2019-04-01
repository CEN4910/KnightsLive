//
//  ProgramsViewController.swift
//  VideoStreaming
//
//  Created by Emmanuel on 01/20/19.
import UIKit

class ProgramsViewController: UIViewController {

    
    @IBOutlet weak var titleHead: UILabel!
    @IBOutlet weak var titleAuthor: UILabel!
    
    // Outlets
    
    @IBOutlet weak var collectionViewWeeks: UICollectionView!
    
    @IBOutlet weak var tableViewPrograms: UITableView!
    
    @IBOutlet weak var titleLogo: UIImageView!
    var weekDay:String = ""
    var weekDayIndex:Int = 0
    
    var scheduleList = [Schedule]()
    var eventList = [Event]()
    
    var selectedDayIndex:Int = 0
    
    var selectedDay:[Bool] = [false,false,false,false,false,false,false]
    
    var scheduleProgramList = [Schedule]()
    
    
    @IBOutlet weak var titleView: UIView!
    
    
    
    //Variables
    
    // Declaring and initializing the Week Array
    
    var weekArray:[String] = [NSLocalizedString("day1", comment: "Day of the week"),NSLocalizedString("day2", comment: "Day of the week"),NSLocalizedString("day3", comment: "Day of the week"),NSLocalizedString("day4", comment: "Day of the week"),NSLocalizedString("day5", comment: "Day of the week"),NSLocalizedString("day6", comment: "Day of the week"),NSLocalizedString("day7", comment: "Day of the week")]
    
    //var weekArray:[String] = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
            titleLogo.image = #imageLiteral(resourceName: "logo")

        titleView.backgroundColor = hexToUiColor().hexStringToUIColor(hex: unselectedDaySelectionColor)
        collectionViewWeeks.dataSource = self
        collectionViewWeeks.delegate = self
        
        tableViewPrograms.dataSource = self
        tableViewPrograms.delegate = self
        
        
        // Get the Day in Week
        
        weekDayIndex = getWeekDayIndex(week: getDayInWeek())
        print(weekDayIndex)
        
        self.eventList = self.scheduleProgramList[self.weekDayIndex].events
        
        self.tableViewPrograms.reloadData()
        
        tableViewPrograms.backgroundColor = hexToUiColor().hexStringToUIColor(hex: daySelectionColor)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Get the Week day from the Today's date
    
    public func getDayInWeek() -> String {
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
        print(date)
        let dayInWeek = dateFormatter.string(from: date as Date)//"Sunday"
        
        print(dayInWeek)
        
        return dayInWeek
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("fsdfds")
        
        for i in 0 ... selectedDay.count - 1 {
            
            selectedDay[i] = false
            
            
        }
        
        
        collectionViewWeeks.reloadData()
        
        
        weekDay = getDayInWeek() //Get the Day in the Week
        
        weekDayIndex = getWeekDayIndex(week: weekDay) // Get the Day of Index in the week
        
        //  selectedDay[weekDayIndex] = true
        
        
        titleView.backgroundColor = hexToUiColor().hexStringToUIColor(hex: tabSelectionColor)
        
        print("INDE = \(weekDayIndex)")
        
        setScrollToWeekDay(weekIndex: weekDayIndex)
        
        tableViewPrograms.backgroundColor = hexToUiColor().hexStringToUIColor(hex: daySelectionColor)

        
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
    
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.portrait //return the value as per the required orientation
//    }
//    
//    override var shouldAutorotate: Bool {
//        return false
//    }
    
    
    public func getWeekDayIndex(week:String) -> Int {
        
        var weekIndex:Int = -1
       print (week)
        
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
    
    
    // Set the Scroll position to the Today's date
    
    public func setScrollToWeekDay(weekIndex:Int){
        
        
        
        let index = IndexPath(item:weekIndex , section: 0)
        
        selectedDay[weekIndex] = true
        
        collectionViewWeeks.reloadData()
        collectionViewWeeks.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        
        
        
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

extension ProgramsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let weekCell = collectionViewWeeks.dequeueReusableCell(withReuseIdentifier: "weekCell", for: indexPath) as! WeeksCollectionViewCell
        
        weekCell.labelWeekName.text = weekArray[indexPath.row]
        
        
        if selectedDay[indexPath.row] == true  {
            
            weekCell.labelWeekName.textColor = hexToUiColor().hexStringToUIColor(hex: dayTextColor)//UIColor.white
            // weekCell.viewWeekSelection.backgroundColor =  hexToUiColor().hexStringToUIColor(hex: "#29ADEF") //
            
            weekCell.viewWeekSelection.backgroundColor =  hexToUiColor().hexStringToUIColor(hex: unselectedDaySelectionColor)
            
             weekCell.labelWeekName.textColor = hexToUiColor().hexStringToUIColor(hex: programcurrentdateColor)
        }
        else{
            
            //  weekCell.labelWeekName.textColor = hexToUiColor().hexStringToUIColor(hex: "#29ADEF")
            
            weekCell.labelWeekName.textColor = hexToUiColor().hexStringToUIColor(hex: unselectedDayTextColor)
            
            
            weekCell.viewWeekSelection.backgroundColor = hexToUiColor().hexStringToUIColor(hex: unselectedDaySelectionColor)
            
            
            
            
        }
        
        
        return weekCell
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return weekArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Selected Week \(weekArray[indexPath.row])")
        
        
        let index = IndexPath(item:indexPath.row , section: 0)
        collectionView.reloadData()
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        
        
        selectedDayIndex = index.row
        
        self.eventList = scheduleProgramList[self.selectedDayIndex].events
        
        self.tableViewPrograms.reloadData()
        
        
        
        for i in 0 ... selectedDay.count - 1 {
            
            selectedDay[i] = false
            
            
        }
        
        
        
        selectedDay[selectedDayIndex] = true
        collectionView.reloadData()
      
        
    }
   
    
}

extension ProgramsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let programCell = tableViewPrograms.dequeueReusableCell(withIdentifier: "programCell", for: indexPath) as! StreamTableViewCell
        
        programCell.selectionStyle = .none
        
        
        let event:Event = eventList[indexPath.row]
        
        programCell.labelProgramName.text = event.showTitle
        programCell.labelProgramTime.text = event.showTimeStart
     
        return programCell
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.eventList.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
      
        
    }
    
    
}

//pvt methods
extension ProgramsViewController
{
    func setupUI()
    {

//        self.titleHead.text = titleText//NSLocalizedString("title", comment: "title of the App")
//        self.titleAuthor.text = authorName//NSLocalizedString("authorName", comment: "title author of the App")
    }
}




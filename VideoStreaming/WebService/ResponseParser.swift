//
//  ResponseParser.swift
//
//  Created by Emmanuel on 01/20/19.

import Foundation
import UIKit
import SwiftyJSON
import CoreLocation

class ResponseParser: NSObject {
    
    //MARK:- USER
    
//    
    private func parseProgramSchedule(json:JSON, completionHandler handler:WebServiceCompletionHandler)
        
    {
        let scheduleArraylist =  json.dictionaryValue["schedule"]?.arrayValue.map { (scheduleObj) -> Schedule in
            
            let schedule = Schedule()
            schedule.day = (scheduleObj.dictionaryValue["day"]?.stringValue)!
            
            
            schedule.events = (scheduleObj.dictionaryValue["events"]?.arrayValue.map { ( EventModelObject)-> Event  in
                
                let eventModelTemp = Event()
                
                eventModelTemp.showTimeStart = EventModelObject["show_time_start"].stringValue
                eventModelTemp.showTimeEnd = EventModelObject["show_time_end"].stringValue
                eventModelTemp.showTitle = EventModelObject["show_title"].stringValue
                eventModelTemp.duration = EventModelObject["duration"].stringValue
                eventModelTemp.showDescription = EventModelObject["show_description"].stringValue
                
                
                return eventModelTemp
                
                
                })!
            

            return schedule
        }
        
        handler(true, nil, scheduleArraylist as AnyObject?, nil)
        
    }
    
    
    
//
//    private func parsecatagory(json:JSON, completionHandler handler:WebServiceCompletionHandler)
//        
//    {
//        
//        
//        let CatagoryModelListArray =  json.arrayValue.map { (CatagoryModel) -> CatagoryListModel in
//            
//            let CatagoryModelObjecttemp = CatagoryListModel()
//            
//            CatagoryModelObjecttemp.id = CatagoryModel.dictionaryValue["id"]?.intValue
//            CatagoryModelObjecttemp.content = CatagoryModel.dictionaryValue["content"]?.stringValue
//            CatagoryModelObjecttemp.title = CatagoryModel.dictionaryValue["title"]?.stringValue
//            CatagoryModelObjecttemp.date = CatagoryModel.dictionaryValue["date"]?.stringValue
//            CatagoryModelObjecttemp.author = CatagoryModel.dictionaryValue["author"]?.stringValue
//            CatagoryModelObjecttemp.image = CatagoryModel.dictionaryValue["image"]?.stringValue
//            CatagoryModelObjecttemp.favorite = CatagoryModel.dictionaryValue["favorite"]?.boolValue
//            CatagoryModelObjecttemp.url = CatagoryModel.dictionaryValue["url"]?.stringValue
//            
//            CatagoryModelObjecttemp.catagory = (CatagoryModel.dictionaryValue["category"]?.arrayValue.map { ( CatagoryModelObjectcatagory)-> catagorymodel  in
//                
//                let catagorymodeltemp = catagorymodel()
//                
//                catagorymodeltemp.term_id = CatagoryModelObjectcatagory["term_id"].intValue
//                
//                catagorymodeltemp.name = CatagoryModelObjectcatagory["name"].stringValue
//                
//                
//                return catagorymodeltemp
//                
//                })!
//            
//            return CatagoryModelObjecttemp
//            
//        }
//        
//        handler(true, nil, CatagoryModelListArray as AnyObject?, nil)
//        
//    }
//    
    

    
    
    
    
    
        private func parseRadio(json:JSON, completionHandler handler:WebServiceCompletionHandler)
        {
            print("PARSING api URL")
            let  StremModelItemObject = StremModel()
    
            print(json[0])
    
            StremModelItemObject.URL = (json.dictionaryValue["channel_url"]?.stringValue)!
            handler(true, nil, StremModelItemObject as AnyObject?, nil)
    
    
        }
    
        //MARK:- Basic parser method to parse the Skelton of the response
    
    func parseWithResponse(json:JSON, serviceMethodType methodType:ServiceMethodType, completionHandler handler:WebServiceCompletionHandler,statusCode:Int)
    {
        
        //        self.parseRestaurantCategoryList(json: json, completionHandler:handler)
        
        //        if let errorCode = json[WS_Param_Key_Status].string
        //        {
        //            if errorCode == "success"
        if statusCode == 200
        {
            // Success and Data available ....
            
            switch methodType
                
            {
                
                
            case .programSchedule:
                self.parseProgramSchedule(json: json, completionHandler: handler)
                
            case .streamFromApi:
                self.parseRadio(json: json, completionHandler:handler)

            default: break
                
            }
        }
        else
        {
            if let message = json[WS_Param_Key_Message].string
            {
                print("Parsing not executed  #1")
                
                handler(false, message , nil, nil)
            }
                //                else if  errorCode == "hold" {
                //                
                //                    parsePostComment(json: json, completionHandler: handler)
                //                    handler(true, nil, nil, nil)
                //
                //                }
            else
            {
                let customError = NSError(domain:WS_Error_DataFormat, code: WS_ErrorCode_DataFormat, userInfo: nil)
                
                print("Parsing not executed  #2")
                
              /*
                if(methodType == .postCommenturl)
                {
                    
                    parsePostComment(json: json, completionHandler: handler)
                    handler(true, nil, nil, customError)
                    
                }
                else{
                    handler(false, nil, nil, nil)
                }
 
 */
                
                
                
                
            }
        }
        //        }
        //        else
        //        {
        //            print("Parsing not executed  #3")
        //            
        //            switch methodType
        //                
        //            {
        //
        //                
        //            default: break
        //                
        //            }
        
        
        //            let customError = NSError(domain:WS_Error_DataFormat, code: WS_ErrorCode_DataFormat, userInfo: nil)
        //            handler(false, nil, nil, customError)
    }
    
    
}

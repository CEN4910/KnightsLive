//
//  WebserviceConstant.swift
//  ShalomKids
//
//  Created by Abin on 16/12/17.
//  Copyright © 2017 Webandcrafts. All rights reserved.
//

import Foundation

//
//  WebserviceConstant.swift
//  ShalomTidings
//
//  Created by Webandcrafts on 28/10/17.
//  Copyright © 2017 Webandcrafts. All rights reserved.
//


import Foundation
import UIKit

//MARK:- Web service enums

enum HttpMethod {
    
    case get
    case post
}


enum ServiceMethodType
    
{
    case none
    case programSchedule
    case streamFromApi

}

var baseUrl =   API_BASE_URL 


//var scheduleUrl = "5a9010f5300000413e248d0a"







//MARK:- Web service completion handler closures


public typealias downloaderCompletionHandler = ((_ status:Bool, _ message:String?, _ responseObject:AnyObject?, _ error:NSError?) -> ())


typealias WebServiceCompletionHandler = (_ status:Bool, _ message:String?, _ responseObject:AnyObject?, _ error:NSError?) -> Void

//MARK:- Parameter constants

// Common API parameters used

// Keys
let WS_Param_Key_ApiKey = "api_key"
let WS_Param_Key_ContentType = "Content-Type"

let errorCode = "ErrCode"
let WS_Param_Key_Message = "msg"
let WS_Param_Key_Data = "Data"
let WS_Param_Key_Status = "status"


let WS_Param_Key_DeviceToken = "device_token"
let WS_Param_Key_VendorID = "vendor_id"
let WS_Param_Key_DeviceType = "device_type"

let WS_Param_Key_Login_SessionToken = "SessionToken"
let WS_Param_Key_SessionToken = "Authorization"

// values
let WS_ContentType = "application/json"
let WS_ApiKey = "123"

let WS_Param_DeviceType = 1

// Error parameters

let WS_ErrorCode_NoData = 999001
let WS_Error_NoData = "No data available"

let WS_ErrorCode_DataFormat = 999002
let WS_Error_DataFormat = "Data format error. Data contract breakage"

let WS_ErrorCode_UnKnown = 999003
let WS_Error_UnKnown = "Unknown error. But response obtained"

let noInternetConnectivityErrorCode = 999004
let noInternetConnectivityError = "No internet connectivity"

// HTTP Success code

let WS_HTTP_SuccessCode = 200
//HTTP Created code

let WS_HTTP_CreatedCode = 201
// HTTP Error codes

let WS_HTTP_ErrorCode_BadRequest = 400
let WS_HTTP_ErrorCode_UnAuthorizedAccess = 401
let WS_HTTP_ErrorCode_Forbidden = 403
let WS_HTTP_ErrorCode_ResourceNotFound = 404
let WS_HTTP_ErrorCode_TimeOut = 408
let WS_HTTP_ErrorCode_Other = 999999

let WS_HTTP_Error_BadRequest = "The server cannot or will not process the request due to an apparent client error"
let WS_HTTP_Error_UnAuthorizedAccess = "Access Server Permission denied"
let WS_HTTP_Error_Forbidden = "The request was a valid request, but the server is refusing to respond to it"
let WS_HTTP_Error_ResourceNotFound = "The requested resource could not be found but may be available in the future. Subsequent requests by the client are permissible"
let WS_HTTP_Error_TimeOut = "The server timed out waiting for the request"
let WS_HTTP_Error_Other = "HTTP error, other than general, frequent and popular errors"

// User Defaults parmeters
let WS_SessionTokenKey = "Authorization"
//MARK:- Service utility class


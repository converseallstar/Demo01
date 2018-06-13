//
//  BaseRequest.swift
//  KKMJ
//
//  Created by jimmy on 2018/6/5.
//  Copyright © 2018年 VCredit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum APIRequestError: Error
{
    case network
    case convert
    case notSend
    case alamofire(Error)
    case invalidWithMessage(String)
}

enum APIesponseSerialization: Error
{
    case JSON
    case XML
    case String
}

class BaseRequest<T>: NSObject
{
    typealias SuccessClosure = (_ closure: T) -> Void
    typealias FailedClosure = (_ closure: APIRequestError) -> Void
    typealias CompleteClosure = () -> Void
    typealias Parameters = [String: Any]
    
    var successClosure : SuccessClosure?
    var failedClosure : FailedClosure?
    var completeClosure : CompleteClosure?
    var requestParameters : Parameters = [:]
    
    override init()
    {
        super.init()
    }
    
    @discardableResult
    open func execute() -> BaseRequest
    {
        return execute(nil)
    }
    
    @discardableResult
    open func execute(_ successClosure : SuccessClosure?) -> BaseRequest
    {
        self.successClosure = successClosure
        
        guard willStart() else {
            DispatchQueue.main.async {
                print("==== http not send ===== \(self)")
                self.failedClosure?(.notSend)
                self.completeClosure?()
            }
            return self
        }
        
        Alamofire.SessionManager.default.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let request = Alamofire.request(getBaseUrl() + getHttpResource(), method: getRequestMethod(), parameters:requestParameters)
        
        if self.getAPIesponseSerialization() == .JSON
        {
            request.responseJSON { response in
                if case let .success(value) = response.result
                {
                    if let data = self.onReceieveJson(JSON(value))
                    {
                        self.successClosure?(data)
                    }
                    else
                    {
                        self.failedClosure?(.convert)
                    }
                }
                else if case let .failure(err) = response.result
                {
                    print("==== http error: \(response.response?.statusCode ?? 0)")
                    self.failedClosure?(.alamofire(err))
                }
                
                self.completeClosure?()
            }
        }
        
        return self
    }
    
    func willStart() -> Bool
    {
        return true
    }
    
    func getBaseUrl() -> String
    {
        return "http://static.youshikoudai.com/";
    }
    
    func getRequestMethod() -> HTTPMethod
    {
        return .get;
    }
    
    func getHttpResource() -> String
    {
        return ""
    }
    
    func getParameters() -> Parameters
    {
        return requestParameters
    }
    
    func onReceieveJson(_ data : JSON) -> T?
    {
        if let value = data as? T
        {
            return value
        }
        
        return nil
        //fatalError("Subclasses need to implement the `onReceieve()` method.")
    }
    
    func getAPIesponseSerialization() -> APIesponseSerialization
    {
        return .JSON
    }
}

//block
extension BaseRequest
{
    @discardableResult open func onSuccess(_ closure : @escaping SuccessClosure) -> BaseRequest
    {
        self.successClosure = closure
        
        return self
    }
    
    @discardableResult open func onFailed(_ closure : @escaping FailedClosure) -> BaseRequest
    {
        self.failedClosure = closure
        
        return self
    }
    
    @discardableResult open func onComplete(_ closure : @escaping CompleteClosure) -> BaseRequest
    {
        self.completeClosure = closure
        
        return self
    }
}

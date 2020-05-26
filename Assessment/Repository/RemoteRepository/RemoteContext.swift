//
//  RemoteContext.swift
//  Assessment
//
//  Created by Heema Boss on 5/26/20.
//  Copyright © 2020 Ibraheem. All rights reserved.
//

import Foundation
import Alamofire

typealias Handler<T> = (Result<T>) -> Void

enum ContentType: String{
    case propertyList = "application/x-plist"
    case json = "application/json"
    case urlEncoded = "application/x-www-form-urlencoded"
}

final class RemoteContext {
    
    //MARK: - Properties
    private var sessionManager: SessionManager!
    var baseURL: String!
    
    //MARK: - Initializers
    
    /// Initialize session manager and Alamofire configurations
    init(baseURL: String){
        self.baseURL = baseURL
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        
        configuration.httpAdditionalHeaders?.updateValue("application/json", forKey: "Accept")
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    /// Creates an HTTP request to a given endpoint address
       ///
       /// - Parameters:
       ///   - endPoint: Endpoint
       ///   - parameters: [String: Any], Optional
       ///   - completion: A callback function invoked when the operation is completed.
      func request(endPoint: EndPointProtocol, parameters:Parameters?, completion: @escaping Handler<Any>){
          let urlRequest = buildURlRequest(endPoint: endPoint, params: parameters)
          sendRequest(reqestUrl: urlRequest) { (result) in
              switch result{
                  
              case .success(let response):
                  guard let wsResponse = response as? DataResponse<Data> else{
                      completion(.success(Data()))
                      return
                  }
                  if let wsData = wsResponse.data {
                      do{
                        _ = try JSONEncoder().encode(wsData)
                          completion(.success(wsResponse.data))
                      } catch{
                          completion(.success(wsData))
                      }
                  }
              case .failure(let error):
                  completion(.failure(error))
              }
          }//End sendRequest
      }
      
    
    /// Helper method to build an HTTP request.
    ///
    /// - Parameters:
    ///   - endPoint: Endpoint object.
    ///   - params: Http request parameter as [String: Any], optional.
    /// - Returns: An Http request object of type URLRequestConvertible.
    private func buildURlRequest(endPoint: EndPointProtocol, params: Parameters?) -> URLRequestConvertible{
        let relativePath = baseURL + endPoint.address
        let url = URL(string: relativePath)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        
        var encoding: ParameterEncoding!
        
        if let headers = endPoint.headers {
            headers.keys.forEach({ (key) in
                urlRequest.setValue(headers[key]!, forHTTPHeaderField: key )
            })
            
            if let contentType = headers["Content-Type"] {
                switch contentType {
                case ContentType.json.rawValue:
                    encoding = JSONEncoding.default
                case ContentType.propertyList.rawValue:
                    encoding = PropertyListEncoding.default
                case ContentType.urlEncoded.rawValue:
                    encoding = URLEncoding.default
                default:
                    encoding = JSONEncoding.default
                }
            }else{
                encoding = JSONEncoding.default
            }
        }
        if endPoint.httpMethod == .get || endPoint.httpMethod == .delete{
            encoding = URLEncoding.default
        }
        return try! encoding.encode(urlRequest, with: params)
    }
    
    /// Helper method to send an Http request to a given Endpoint.
    ///
    /// - Parameters:
    ///   - endPoint: Endpoint object
    ///   - parameters: Http request parameter as [String: Any], optional.
    ///   - completion: A callback function
    private func sendRequest (reqestUrl: URLRequestConvertible, completion: @escaping Handler<Any> ) {
        sessionManager.request(reqestUrl).validate().responseData { [weak self](response) in
            switch response.result {
            case .success:
                completion(.success(response))
            case .failure(let responseError as NSError):
                let error = self?.buildError(response: response, responseError: responseError)
                completion(.failure(error!))
            }
        }//End sessionManager.request
        
    }
    
    func buildError(response: DataResponse<Data>, responseError: NSError?) -> NSError?{
        let userInfo: [String : Any] = [
            NSLocalizedDescriptionKey :  "unknown Error" ,
            NSLocalizedFailureReasonErrorKey : "unknown Error"
        ]
        let error = NSError(domain: "RemoteDataSourceDomain", code: 400, userInfo: userInfo)
        
        guard let statusCode = response.response?.statusCode else{
            return responseError
        }
        
        if Array(300..<600).contains(statusCode){
            return error
        }
        
        return responseError
    }
}

//
//  ApiEndPoints.swift
//  Assessment
//
//  Created by Heema Boss on 5/26/20.
//  Copyright © 2020 Ibraheem. All rights reserved.
//

import Foundation
import Alamofire

let baseUrl = "https://api.nytimes.com/svc/mostpopular/v2/"


//MARK: - ApiHeaderKey
enum ApiHeaderKey: String {
    case contentType = "Content-Type"
    case apiKey = "api-key"
}

//MARK: - ApiEndPoints
public enum ApiEndPoints: String{
    
    ///Get
    case emailed = "emailed/7.json?api-key=3fQy9ALGZGEVkeSBqvmG3suslIWYkebl"

}

//MARK: - Endpoint
struct EndPoint: EndPointProtocol {
    
    //MARK: - Properties
    var address: String
    var httpMethod: HTTPMethod
    var headers: [String:String]?
    
    //MARK: - Initializers
    /// Initializes an Endpoint object.
    ///
    /// - Parameters:
    ///   - address: ApiEndPoint Enum
    ///   - httpMethod: HTTPMethod
    ///   - headers: [[String: String]], Optional with nil as default value.
    init(address: ApiEndPoints, httpMethod: HTTPMethod, headers: [String:String]? = nil) {
        self.address = address.rawValue
        self.httpMethod = httpMethod
        self.headers = headers
    }
    
    init(address: String, httpMethod: HTTPMethod, headers: [String:String]? = nil) {
        self.address = address
        self.httpMethod = httpMethod
        self.headers = headers
    }
}


//MARK: - Endpoint
protocol EndPointProtocol {
    var address: String { get set }
    var httpMethod: HTTPMethod { get set }
    var headers: [String:String]? { get set }
}


//
//  ServiceConnector.swift
//  WorkshopFixir
//
//  Created by Ky Nguyen on 12/28/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
import Alamofire

struct ServiceConnector {
    static fileprivate var connector = AlamofireConnector()
    static private func getHeaders() -> [String: String]? {
        return ["Content-Type": "application/json",
                "X-Device-Id": "mobile_app"
        ]
    }
    private static func getUrl(from api: String) -> URL? {
        let baseUrl = "your_root_url"
        let apiUrl = api.contains("http") ? api : baseUrl + api
        return URL(string: apiUrl)
    }
    
    static private func request(_ api: String,
                                method: HTTPMethod,
                                params: [String: Any]? = nil,
                                headers: [String: String]?,
                                success: @escaping (_ result: AnyObject, _ data: Data?) -> Void,
                                fail: ((_ error: Error) -> Void)? = nil) {
        let finalHeaders = headers ?? getHeaders()
        let apiUrl = getUrl(from: api)
        connector.request(withApi: apiUrl,
                          method: method,
                          params: params,
                          header: finalHeaders,
                          success: success,
                          fail: fail)
    }
    
    static func get(_ api: String,
                    params: [String: Any]? = nil,
                    headers: [String: String]?,
                    success: @escaping (_ result: AnyObject, _ data: Data?) -> Void,
                    fail: ((_ error: Error) -> Void)? = nil) {
        request(api, method: .get, params: params, headers: headers, success: success, fail: fail)
    }
    
    static func put(_ api: String,
                    params: [String: Any]? = nil,
                    headers: [String: String]?,
                    success: @escaping (_ result: AnyObject, _ data: Data?) -> Void,
                    fail: ((_ error: Error) -> Void)? = nil) {
        request(api, method: .put, params: params, headers: headers, success: success, fail: fail)
    }
    
    static func post(_ api: String,
                     params: [String: Any]? = nil,
                     headers: [String: String]?,
                     success: @escaping (_ result: AnyObject, _ data: Data?) -> Void,
                     fail: ((_ error: Error) -> Void)? = nil) {
        request(api, method: .post, params: params, headers: headers, success: success, fail: fail)
    }
    
    static func delete(_ api: String,
                       params: [String: Any]? = nil,
                       headers: [String: String]?,
                       success: @escaping (_ result: AnyObject, _ data: Data?) -> Void,
                       fail: ((_ error: Error) -> Void)? = nil) {
        request(api, method: .delete, params: params, headers: headers, success: success, fail: fail)
    }
}


struct AlamofireConnector {
    func request(withApi api: URL?,
                 method: HTTPMethod,
                 params: [String: Any]? = nil,
                 header: [String: String]? = nil,
                 success: @escaping (_ result: AnyObject, _ data: Data?) -> Void,
                 fail: ((_ error: Error) -> Void)?) {
        
        guard let api = api else { return }
        let encoding: ParameterEncoding = method == .get ? URLEncoding.httpBody : JSONEncoding.default
        Alamofire.request(api, method: method,
                          parameters: params, encoding: encoding,
                          headers: header)
            .responseJSON { (returnData) in
                self.response(response: returnData,
                              withSuccessAction: success,
                              failAction: fail)
        }
    }
    
    func response(response: DataResponse<Any>,
                  withSuccessAction success: @escaping (_ result: AnyObject, _ data: Data?) -> Void,
                  failAction fail: ((_ error: Error) -> Void)?) {
        let url = response.request?.url?.absoluteString ?? ""
        print(url)
        
        if let statusCode = response.response?.statusCode {
            // handle status code here: 401 -> show logout; 500 -> server error
        }
        
        if let error = response.result.error {
            fail?(error)
            return
        }
        
        guard let result = response.result.value else {
            // handle unknown error
            return
        }
        
        // handle special error convention from server
        // ...
        
        success(result as AnyObject, response.data)
    }
}

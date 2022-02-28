//
//  BaseUrlApi.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation

protocol BaseUrlApiProtocol {
    func call<T: Decodable>(url: URLComponents?,
                            method: BaseUrlApi.HTTPMethods,
                            headers: [String: String],
                            body: Data?,
                            completion: @escaping (T?, BaseUrlApi.ApiError?) -> Void)
}


class BaseUrlApi: NSObject, URLSessionDelegate, BaseUrlApiProtocol {

    func call<T: Decodable>(url: URLComponents?, method: HTTPMethods = .get, headers: [String: String] = [:],
                            body: Data? = nil, completion: @escaping (T?, ApiError?) -> Void  ) {
        guard let components = url,
              let url = components.url
        else {
            completion(nil, .invalidUrl)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)

        self.performCall(request: request, session: session, completion: completion)
    }


    private func performCall<T: Decodable>(request: URLRequest, session: URLSession, completion: @escaping (T?, ApiError?) -> Void, finish: Bool = false ) {

        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, .network(error))
                return
            }

            guard let data = data else {
                completion(nil,.emptyData)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 504 else {
                completion(nil, .timeout)
                return
            }

            self.decode(data: data, completion: completion)
         }.resume()
    }

}

extension BaseUrlApi {
    private func decode<T: Decodable>(data: Data, completion: (T?, ApiError?) -> Void) {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: data)
            print("CBY:: DECODED OK")
            completion(decoded, nil)
        } catch {
            print("CBY:: DECODED ERROR")
            print(String(data: data, encoding: .utf8))
            completion(nil, .decoded)
        }
    }
}

extension BaseUrlApi {
    enum ApiError: Equatable {
        static func == (lhs: BaseUrlApi.ApiError, rhs: BaseUrlApi.ApiError) -> Bool {
            switch (lhs, rhs) {
            case(.decoded, .decoded): return true
            case(.invalidUrl, .invalidUrl): return true
            case(.network, .network): return true
            case(.emptyData, .emptyData): return true
            case(.timeout, .timeout): return true

            default: return false
            }
        }

        case decoded
        case invalidUrl
        case network(Error)
        case emptyData
        case timeout
    }
}


extension BaseUrlApi {
    enum HTTPMethods: String {
        case get =  "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
}

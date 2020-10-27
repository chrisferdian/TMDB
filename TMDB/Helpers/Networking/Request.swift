//
//  Request.swift
//  TMDB
//
//  Created by TMLI IT DEV on 25/10/20.
//

import Foundation
typealias Headers = Dictionary<String, String>
typealias Response<Value: Decodable> = (_ completionHandler: @escaping(Result<Value, Error>) -> Void) -> Void

enum HTTPMethods: String {
    case get = "GET", post = "POST", delete = "DELETE", put = "PUT"
}

@propertyWrapper
internal struct Request<Value> where Value: Decodable {
    
    private var request: URLRequest
    private var endPoint: String?

    private let queryParams: [String: String] = [
        "api_key": "a42b168856dcc7d96b4321bee09e82b3"
    ]
    
    init(
        url: String,
        id: String? = nil,
        method: HTTPMethods = .get,
        body: Data? = nil,
        urlParam: [String: String]? = nil,
        headers: Headers? = nil
    ) {
        self.endPoint = url
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3\(self.endPoint ?? "")"
        urlComponents.setQueryItems(with: queryParams)
        
        guard let url = urlComponents.url else {
            precondition(false, "Must add a valid url.")
        }
        
        var aRequest = URLRequest(url: url)
        aRequest.httpMethod = method.rawValue
        aRequest.httpBody = body
        headers?.forEach { aRequest.setValue($1, forHTTPHeaderField: $0) }
        aRequest.allowsCellularAccess = true
        
        self.request = aRequest
    }
    
    var wrappedValue: Response<Value> {
        get {
            return { completion in
                print("*****REQUEST TO : \(String(describing: self.request.url))")
                URLSession.shared
                    .dataTask(with: self.request) { data, _, error in
                        if error != nil {
                            return completion(.failure(error!))
                        }
                        let decoder = JSONDecoder()
                        do {
                            let info = try decoder.decode(Value.self, from: data ?? .init())
                            completion(.success(info))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    .resume()
            }
        }
    }
    
    mutating func setParameters(body: [String: String]) {
        var tempBody = body
        tempBody["api_key"] = "a42b168856dcc7d96b4321bee09e82b3"
        
        var components = URLComponents(url: self.request.url!, resolvingAgainstBaseURL: false)
        components?.setQueryItems(with: tempBody)
        self.request.url = components?.url
    }
    
    mutating func addUrlComponent(component: String) {
        request.url?.appendPathComponent(component)
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}

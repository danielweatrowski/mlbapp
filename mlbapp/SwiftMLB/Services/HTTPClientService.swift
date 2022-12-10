//
//  HTTPClientService.swift
//  yusicapp
//
//  Created by Daniel Weatrowski on 9/16/22.
//

import Foundation

enum HTTPError: Error {
    case decodeFailure
    case invalidURL
    case noResponse
    case badRequest
    case badResponse
    case unauthorized
    case notFound
    case noData
    case forbidden
    case internalServerError(_ statusCode: Int)
    case unexpectedStatusCode(_ statusCode: Int)
    case unknown
}

extension HTTPError: CustomStringConvertible {
    public var description: String {
        switch (self) {
        default: return "Something went wrong."
        }
    }
}

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

protocol HTTPRequestProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var query: String? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

protocol HTTPClient {
    func load(_ request: HTTPRequestProtocol) async throws -> Data
    func load<T: Decodable>(request: HTTPRequestProtocol, responseType: T.Type) async -> Result<T, HTTPError>
    func load<T: Decodable>(request: HTTPRequestProtocol, responseType: T.Type, completion: @escaping ((Result<T, HTTPError>) -> (Void)))
}

extension HTTPClient {
    
    func load(_ request: HTTPRequestProtocol) async throws -> Data {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        
        guard let url = urlComponents.url else {
            throw HTTPError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if let body = request.body {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
        
        guard let response = response as? HTTPURLResponse else {
            throw HTTPError.badResponse
        }
        
        switch response.statusCode {
        case 200...299:
            return data
        case 500...599:
            throw HTTPError.internalServerError(response.statusCode)
        case 400:
            throw HTTPError.badRequest
        case 401:
            throw HTTPError.unauthorized
        case 403:
            throw HTTPError.forbidden
        case 404:
            throw HTTPError.notFound
        default:
            throw HTTPError.unexpectedStatusCode(response.statusCode)
        }
    }

    func load<T: Decodable>(request: HTTPRequestProtocol, responseType: T.Type) async -> Result<T, HTTPError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        if let body = request.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseType, from: data) else {
                    return .failure(.decodeFailure)
                }
                return .success(decodedResponse)
            case 500...599:
                return .failure(.internalServerError(response.statusCode))
            case 400:
                return .failure(.badRequest)
            case 401:
                return .failure(.unauthorized)
            case 403:
                return .failure(.forbidden)
            case 404:
                return .failure(.notFound)
            default:
                return .failure(.unexpectedStatusCode(response.statusCode))
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    func load<T: Decodable>(request: HTTPRequestProtocol, responseType: T.Type, completion: @escaping ((Result<T, HTTPError>) -> (Void))) {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        if let body = request.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body,
                                                              options: [])
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.unknown))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseType,
                                                                      from: data) else {
                    completion(.failure(.decodeFailure))
                    return
                }
                completion(.success(decodedResponse))
            case 500...599:
                completion(.failure(.internalServerError(response.statusCode)))
            case 400:
                completion(.failure(.badRequest))
            case 401:
                completion(.failure(.unauthorized))
            case 403:
                completion(.failure(.forbidden))
            case 404:
                completion(.failure(.notFound))
            default:
                completion(.failure(.unexpectedStatusCode(response.statusCode)))
            }
        }
        dataTask.resume()
    }
}

struct HTTPClientService: HTTPClient {
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func load(_ request: HTTPRequestProtocol) async throws -> Data {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
                
        guard let url = urlComponents.url else {
            throw HTTPError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if let body = request.body {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        let (data, response) = try await session.data(for: urlRequest, delegate: nil)
        
        guard let response = response as? HTTPURLResponse else {
            throw HTTPError.badResponse
        }
        
        switch response.statusCode {
        case 200...299:
            return data
        case 500...599:
            throw HTTPError.internalServerError(response.statusCode)
        case 400:
            throw HTTPError.badRequest
        case 401:
            throw HTTPError.unauthorized
        case 403:
            throw HTTPError.forbidden
        case 404:
            throw HTTPError.notFound
        default:
            throw HTTPError.unexpectedStatusCode(response.statusCode)
        }
    }
    
    func load<T: Decodable>(request: HTTPRequestProtocol, responseType: T.Type) async -> Result<T, HTTPError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        if let body = request.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseType, from: data) else {
                    return .failure(.decodeFailure)
                }
                return .success(decodedResponse)
            case 500...599:
                return .failure(.internalServerError(response.statusCode))
            case 400:
                return .failure(.badRequest)
            case 401:
                return .failure(.unauthorized)
            case 403:
                return .failure(.forbidden)
            case 404:
                return .failure(.notFound)
            default:
                return .failure(.unexpectedStatusCode(response.statusCode))
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    func load<T: Decodable>(request: HTTPRequestProtocol, responseType: T.Type, completion: @escaping ((Result<T, HTTPError>) -> (Void))) {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        urlComponents.query = request.query
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        if let body = request.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body,
                                                              options: [])
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.unknown))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseType,
                                                                      from: data) else {
                    completion(.failure(.decodeFailure))
                    return
                }
                completion(.success(decodedResponse))
            case 500...599:
                completion(.failure(.internalServerError(response.statusCode)))
            case 400:
                completion(.failure(.badRequest))
            case 401:
                completion(.failure(.unauthorized))
            case 403:
                completion(.failure(.forbidden))
            case 404:
                completion(.failure(.notFound))
            default:
                completion(.failure(.unexpectedStatusCode(response.statusCode)))
            }
        }
        dataTask.resume()
    }
}

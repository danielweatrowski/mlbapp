//
//  HTTPClientService.swift
//  yusicapp
//
//  Created by Daniel Weatrowski on 9/16/22.
//

import Foundation
import OSLog

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
        urlComponents.queryItems = request.queryItems

                
        guard let url = urlComponents.url else {
            throw HTTPError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if let body = request.body {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        Logger.log(request: request)
        
        let (data, response) = try await session.data(for: urlRequest, delegate: nil)
        
        Logger.log(request: request, response: response)
        
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
        urlComponents.queryItems = request.queryItems
        
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

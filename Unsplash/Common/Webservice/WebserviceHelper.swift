//
//  WebserviceHelper.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 03/04/21.
//

import Foundation

enum NetworkError: Error {
    case incorrectData(Data)
    case incorrectURL
    case badRequest(Data)
    case unauthorized
    case internalServerError
    case parsingError
    case accessForbidden
    case unknown
    // TODOD: Can specify error string here...
//    func errorMsg() -> String{
//        switch self {
//        case .incorrectURL:
//            return ""
//
//
//        default:
//            <#code#>
//        }
//    }
}

typealias WebServiceCompletionBlock = (Result<Data?, Error>) -> Void

/// Helper class to prepare request(adding headers & clubbing base URL) & perform API request.
class WebserviceHelper {

        
    @discardableResult public static func requestAPI(forUrl urlString:String, completion: @escaping WebServiceCompletionBlock) -> URLSessionDataTask? {
                
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.incorrectURL))
            return nil
        }
        print("URL is \(url)")
        var request = URLRequest(url: url)
        request.timeoutInterval = 20.0
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": "Client-ID " + "\(AppConstants.kAccessKey)"]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.unknown))
                return
            }
            guard let httpStatus = response as? HTTPURLResponse else { return }
            switch httpStatus.statusCode {
            case 200, 201:
                completion(.success(data))
            case 400:
                completion(.failure(NetworkError.badRequest(data)))
            case 401:
                completion(.failure(NetworkError.unauthorized))
            case 403:
                completion(.failure(NetworkError.accessForbidden))
            case 500:
                completion(.failure(NetworkError.internalServerError))
            default:
                completion(.failure(NetworkError.incorrectData(data)))
            }
        }
        task.resume()
        return task
    }
    
    
    
    
}



class JSONResponseDecoder {

    typealias JSONDecodeCompletion<T> = (T?, Error?) -> Void

    static func decodeFrom<T: Decodable>(_ responseData: Data, returningModelType: T.Type, completion: JSONDecodeCompletion<T>) {
        
        let decoded = try! JSONSerialization.jsonObject(with: responseData, options: [])
        print(decoded)
        
        do {
            let model = try JSONDecoder().decode(returningModelType, from: responseData)
            completion(model, nil)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: ", context)
            completion(nil, DecodingError.dataCorrupted(context))
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: ", context.debugDescription, "\n codingPath:", context.codingPath)
            completion(nil, DecodingError.keyNotFound(key, context))
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found: ", context.debugDescription, "\n codingPath:", context.codingPath)
            completion(nil, DecodingError.valueNotFound(value, context))
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch: ", context.debugDescription, "\n codingPath:", context.codingPath)
            completion(nil, DecodingError.typeMismatch(type, context))
        } catch {
            print("error: ", error.localizedDescription)
            completion(nil, error)
        }
    }

}

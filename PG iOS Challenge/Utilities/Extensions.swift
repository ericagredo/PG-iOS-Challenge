//
//  '.swift
//  PG iOS Challenge
//
//  Created by Eric Agredo on 3/23/22.
//

import SwiftUI
import SwiftSoup

extension URLSession {
    
    func data(from urlRequest: URLRequest) async throws -> (Data, URLResponse) {
            try await withCheckedThrowingContinuation { continuation in
                let task = self.dataTask(with: urlRequest) { data, response, error in
                    guard let data = data, let response = response else {
                        let error = error ?? URLError(.badServerResponse)
                        return continuation.resume(throwing: error)
                    }
                    
                    continuation.resume(returning: (data, response))
                }
                
                task.resume()
            }
        }
    
    
    func decode<T: Decodable>(
        _  type: T.Type = T.self,
        from urlRequest: URLRequest,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws -> T {
        let (data, _) = try await data(from: urlRequest)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}


extension String {
    func changeHTMLText() -> String {
        var tmp = self
        do {
            let doc: Document = try SwiftSoup.parse(self)
            
            let text: String = try doc.body()!.text() // "An example link"
            tmp = text
            
        } catch let Exception.Error(type, message) {
            print(type)
            print(message)
        } catch {
            print("error")
        }
        return tmp
    }
}

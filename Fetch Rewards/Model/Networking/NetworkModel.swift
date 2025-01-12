

import Foundation

//Inspiration: https://www.swiftbysundell.com/articles/creating-generic-networking-apis-in-swift/
struct NetworkModel {
    
    var session: URLSession
    
    //I'm using dependancy injection to allow for testability
    init(with session: URLSession = URLSession.shared){
        self.session = session
    }
    
    func makeRequest<T:Codable>(at url: URL, completion: @escaping ((T?, Error?) -> Void)){
        let task = session.dataTask(with: url) { data, response, error in
            //TODO: Consider checking data, response, and error if valid network response is recevied instead of force unwrapping the data
            
            let responseObject = try? JSONDecoder().decode(T.self, from: data!)
            completion(responseObject, nil)
        }
        task.resume()
    }
    
    func getURL(for endpoint: EndPoint) -> URL? {
        var urlComponent = URLComponents()
        urlComponent.host = endpoint.host
        urlComponent.scheme = endpoint.scheme
        urlComponent.path = endpoint.path
        urlComponent.queryItems = endpoint.queryItems
        return urlComponent.url
    }
}

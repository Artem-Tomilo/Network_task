//
//  NetworkService.swift
//  Test_task
//
//  Created by Артем Томило on 28.10.22.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    private var hasMore = 1
    
    func loadData(from: Int, to: Int, _ completion: @escaping ([User]) -> Void) {
        let request = URLRequest(url: URL(string: "https://en8717w8khxi59n.m.pipedream.net/?page=0")!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            print(response.statusCode)
            
            let jsonDecoder = JSONDecoder()
            let result = try? jsonDecoder.decode(Users.self, from: data)
            
            guard let result = result else {
                print("Can not decode response")
                return
            }
            
            guard self.hasMore == 1 else { return }
            
            var users = [User]()
            
            if to > result.users.count {
                users = Array(result.users[from..<result.users.count])
                self.hasMore = 0
            } else {
                users = Array(result.users[from..<to])
            }
            
            DispatchQueue.main.async {
                completion(users)
            }
        }
        task.resume()
    }
}

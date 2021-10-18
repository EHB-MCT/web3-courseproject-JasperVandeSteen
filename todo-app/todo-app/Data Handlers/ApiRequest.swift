//
//  ApiRequest.swift
//  todo-app
//
//  Created by student on 14/10/2021.
//

import Foundation

enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct ApiRequest {
    
    let resourceURL: URL
    init() {
        let resourceString = "https://todo-backend-sprint1.herokuapp.com/TodoJasper"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save (_ todoToSave:Todo, completion: @escaping(Result<Todo, APIError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(todoToSave)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data,
                    let response = response as? HTTPURLResponse,
                    error == nil else {
                        // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
                }

                guard (200 ... 299) ~= response.statusCode else {
                    // check for http errors
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                    return
                }

                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
                
                /*
                do {
                    let todoData = try JSONDecoder().decode(Todo.self, from: data)
                    completion(.success(todoData))
                }catch{
                    completion(.failure(.decodingProblem))
                }
                 */
            }

            task.resume()
            
        }catch{
            completion(.failure(.encodingProblem))
        }
        
    }
    
    
    
    /*
    let resourceURL: URL
    init() {
        let resourceString = "https://todo-backend-sprint1.herokuapp.com/Todos"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func save (_ todoToSave:Todo, completion: @escaping(Result<Todo, APIError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(todoToSave)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                
                do {
                    let todoData = try JSONDecoder().decode(Todo.self, from: jsonData)
                    completion(.success(todoData))
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
        
    }
    */
}

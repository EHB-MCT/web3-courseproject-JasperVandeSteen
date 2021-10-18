//
//  Todo.swift
//  todo-app
//
//  Created by student on 11/10/2021.
//

import Foundation

struct Todo: Codable{
    var _id: String!
    var Todo: String!
    
    init(todo: String) {
        self.Todo = todo
    }
}

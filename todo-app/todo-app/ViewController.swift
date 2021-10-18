//
//  ViewController.swift
//  todo-app
//
//  Created by student on 05/10/2021.
//

import UIKit

class ViewController: UIViewController {
    var Tdata: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData { (Todos) in
            for todo in Todos {
                self.Tdata.append(todo.Todo)
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "transferData", sender: nil)
            }
        }
    }
    
    private func getData(completionHandler: @escaping ([Todo]) -> Void) {
        let url = URL(string: "https://todo-backend-sprint1.herokuapp.com/Todos")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }

            do {
                let TodoData = try JSONDecoder().decode([Todo].self, from: data)

                completionHandler(TodoData)
            }
            catch {
                let error = error
                print(error)
            }


        }.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! TableViewController
        vc.modalPresentationStyle = .fullScreen
        vc.todos = self.Tdata
    }
}


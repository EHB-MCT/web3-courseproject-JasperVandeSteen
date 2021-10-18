//
//  TableViewController.swift
//  todo-app
//
//  Created by student on 05/10/2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var todos: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Data transfer functions
    
    /*
    @IBAction func cancelSegue(_ sender: UIStoryboardSegue) {
        //placeholer for cancel segue
    }
    
    @IBAction func doneSegue(_ sender: UIStoryboardSegue) {
        //placeholer for done segue
    }
    */
    
    @IBAction func sendTodo(_ sender: Any) {
        let alertController = UIAlertController(title: "New Todo", message: "Enter a new todo", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Your Task todo..."
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: {
            
            action in guard let text = alertController.textFields?.first?.text else { print("Not text available"); return}
            
            let todo = Todo(todo: text)
            
            let postRequest = ApiRequest()
            postRequest.save(todo, completion: {result in
                switch result {
                case .success(let todo):
                    print("Todo has been added")
                case .failure(let error):
                    print("Something went wrong: \(error)")
                }
            })
            self.tableView.reloadData()
            
        }))
        
        self.present(alertController, animated: true)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.todos[indexPath.row]
        cell.detailTextLabel?.text = "Jasper"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

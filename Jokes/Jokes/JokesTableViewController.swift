//
//  JokesTableViewController.swift
//  Jokes
//
//  Created by Thomas Cacciatore on 7/6/21.
//

import UIKit

class JokesTableViewController: UITableViewController {
    

    let jokesController = JokesController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jokesController.jokes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath)

        let joke = jokesController.jokes[indexPath.row]
        cell.textLabel?.text = joke.words
        

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "JokeSegue" {
            let destinationVC = segue.destination as? JokesViewController
            destinationVC?.jokesController = self.jokesController
        }
    }
    

}

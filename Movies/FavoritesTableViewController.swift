//
//  FavoritesTableViewController.swift
//  Movies
//
//  Created by Alikhan Tuxubayev on 17.02.2021.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    var favMovies: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favMovies = UserDefaults.standard.stringArray(forKey: "Movie") ?? []
        tableView.reloadData()

        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoriteTableViewCell
        cell.titleLabel.text = favMovies[indexPath.row]

        return cell
    }
   
    

}

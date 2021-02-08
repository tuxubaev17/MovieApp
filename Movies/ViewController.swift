//
//  ViewController.swift
//  Movies
//
//  Created by Alikhan Tuxubayev on 2/8/21.
//

import UIKit

class ViewController: UITableViewController {

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        getMovies()
    }
    
    func getMovies(){
        let api_token = "6c78da2cf41529284dc65d510d302bca"
        let url = URL(string: "https://api.themoviedb.org/4/list/1?api_key=\(api_token)")
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "cahe-control": "no-cache"
        ]
        
        let session = URLSession.shared
        session.dataTask(with: request) { (rawdata, response, error) in
        
            if let error = error {
                print(#function, "error", error.localizedDescription)
                return
            }
            guard let data =  rawdata,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print(#function, "error", "\(String(describing: rawdata))")
                return
            }
            guard let moviesJSON = json["results"] as? [[String: Any]] else {
                return
            }
            
            for movie in moviesJSON {
                do {
                    let parsedMovie = try Movie(json: movie)
                    self.movies.append(parsedMovie)
                }catch {
                    print("Error")
                }
            }
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }.resume()
}

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        cell.dateLabel.text = movies[indexPath.row].date
        cell.nameLabel.text = movies[indexPath.row].name
        
        let poster_path = URL(string: "https://image.tmdb.org/t/p/w500" + self.movies[indexPath.row].posterPath)
        
        var task: URLSessionTask? = nil
        if let url = poster_path {
            task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
                if data != nil {
                    var image: UIImage? = nil
                    if let data = data {
                        image = UIImage(data: data)
                    }
                    if image != nil {
                        DispatchQueue.main.async(execute: {
                            let updateCell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell
                            if updateCell != nil {
                                updateCell?.posterImageView.image = image
                            }
                        })
                    }
                }
            })
        }
        task?.resume()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
       guard let detailVC = main.instantiateViewController(identifier: "detailVC") as? DetailViewController else { return }
        detailVC.movieTitle = movies[indexPath.row].name
        detailVC.movieID = movies[indexPath.row].id
        detailVC.movieDescription = movies[indexPath.row].overview!
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


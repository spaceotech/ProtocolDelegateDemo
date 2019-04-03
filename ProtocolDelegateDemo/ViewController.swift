//
//  ViewController.swift
//  BlogProtocolDelegate
//
//  Created by SOTSYS215 on 07/03/19.
//  Copyright © 2019 SOTSYS215. All rights reserved.
//

import UIKit

//MARK: movie information structure created
struct movieInformation {
    let poster: String
    let name: String
    let releaseDate: String
}

//MARK: Inherit protocol
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MovieTableViewCellProtocol {

    //MARK: tableview outlet created
    @IBOutlet weak var movieTableView: UITableView!
    
    // array of structure
    var movieInfo: [movieInformation] = []

    // movie details create
    var avengerDetail: movieInformation = movieInformation(poster: "avengers-4", name: "Avengers-4", releaseDate: "3 May 2019")
    var starwarsDetail: movieInformation = movieInformation(poster: "star-wars", name: "Star Wars: Episode IX", releaseDate: "20 December 2019")
    var wonderWomanDetail: movieInformation = movieInformation(poster: "wonder-woman", name: "Wonder Woman 2", releaseDate: "1 November 2019")
    
    //attributes for attributed string
    let myAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //movie details added into the array of structure
        movieInfo.append(avengerDetail)
        movieInfo.append(starwarsDetail)
        movieInfo.append(wonderWomanDetail)
        
        // tableview datasource and delegate method
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        movieTableView.allowsSelection = false
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.count
    }
    
    //MARK: check movie is like or unliked
    func movieLiked(_ sender: MovieTableViewCell, isLiked: Bool) {
        //fetch tapped indexpath
        guard let tappedIndexPath = movieTableView.indexPath(for: sender) else {
            return
        }
        
        // Access Cell and update like dislike
        let cell = movieTableView.cellForRow(at: tappedIndexPath) as! MovieTableViewCell
        if isLiked {
            cell.btnLike.setImage(UIImage(named: "icon_liked"), for: .normal)
            cell.btnUnlike.setImage(UIImage(named: "icon_dislike"), for: .normal)
        } else {
            cell.btnUnlike.setImage(UIImage(named: "icon_disliked"), for: .normal)
            cell.btnLike.setImage(UIImage(named: "icon_like"), for: .normal)
        }
        
       
        //MARK: alert values set and call
        let strLike = NSMutableAttributedString(string: isLiked ? "You liked " : "You disliked ")
        let strMovieName = NSMutableAttributedString(string: movieInfo[tappedIndexPath.row].poster, attributes: myAttributes)
        
        let strMovie = NSMutableAttributedString(string: " movie")

        strLike.append(strMovieName)
        strLike.append(strMovie)
        let alertMsg = strLike
        displayAlert(msg: alertMsg)
    }
    
    //MARK: setup alert controller
    func displayAlert(msg: NSMutableAttributedString) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.setValue(msg, forKey: "attributedMessage")

        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        cell.imgPoster.image = UIImage(named: movieInfo[indexPath.row].poster)
        cell.lblName.text = movieInfo[indexPath.row].name
        cell.lblReleaseDate.text = movieInfo[indexPath.row].releaseDate
      
        cell.delegate = self
        return cell
    }
}

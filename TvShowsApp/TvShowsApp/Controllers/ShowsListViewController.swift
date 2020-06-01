//
//  ShowsListViewController.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import UIKit

class ShowsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
        }
    }
    let CELL_HEIGHT = 160
    var shows = [Show]()
    
    // MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTvShows()
    }
    
    func fetchTvShows() {
        AlamofireAdapter().fetchShows { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.shows = data.data
                self?.tableView.reloadData()
            case .failure(let error): print(error)
            }
        }
    }
}


extension ShowsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CELL_HEIGHT)
    }
}

extension ShowsListViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCellID", for: indexPath) as! ShowTableViewCell
        cell.show = shows[indexPath.row]
        return cell
    }

}

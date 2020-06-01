//
//  ShowsListViewController.swift
//  TvShowsApp
//
//  Created by MacBook on 01/06/2020.
//  Copyright © 2020 Teodora Garasanin. All rights reserved.
//

import UIKit

class ShowsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var shows = [Show]()
    
    // MARK: - View Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        fetchTvShows()
    }
    
    func fetchTvShows() {
        AlamofireAdapter().fetchShows { [weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    let model = try? JSONDecoder().decode(ShowModel.self, from: data)
                    self?.shows = model?.data as! [Show]
                    self?.tableView.reloadData()
                    
                } catch(let error) {
                    print(error)
                }
                
            case .failure(let error): ()
            }
        }
    }
}


extension ShowsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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

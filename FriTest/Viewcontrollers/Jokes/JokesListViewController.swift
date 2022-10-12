//
//  JokesListViewController.swift
//  FriTest
//
//  Created by Ali Gutierrez on 10/11/22.
//

import UIKit

class JokesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var jokes = Set<Joke>()
    var viewModel = JokesViewModel()
    let count = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        fetchJokes()
    }
    
    private func fetchJokes() {
        let requestGroup = DispatchGroup()
        var count = 0
        
        for _ in  count ..< 25 {
            requestGroup.enter()
            viewModel.fetchJokes { joke in
                self.jokes.insert(joke)
                count = self.jokes.count
                requestGroup.leave()
            }
        }
        
        requestGroup.notify(queue: .main) {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc
    private func refresh() {
        jokes = Set<Joke>()
        tableView.reloadData()
        fetchJokes()
    }
    
    private func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.register(JokesTableViewCell.nib, forCellReuseIdentifier: JokesTableViewCell.identifier)
    }
}


extension JokesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
}

extension JokesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JokesTableViewCell.identifier,
                                                       for: indexPath) as? JokesTableViewCell else {
            fatalError("cell not dequeued properly")
        }
        
        let jokesArray: [Joke] = Array(jokes)
        let joke = jokesArray[indexPath.row]

        cell.configure(with: joke)

        return cell
    }
}

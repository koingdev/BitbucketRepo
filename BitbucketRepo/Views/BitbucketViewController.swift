//
//  BitbucketViewController.swift
//  BitbucketRepo
//
//  Created by KoingDev on 9/2/20.
//  Copyright © 2020 koing.dev. All rights reserved.
//

import UIKit

class BitbucketViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private let viewModel = BitbucketViewModel()
    private var dataSource: [Bitbucket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        Queue.background {
            self.viewModel.fetch { [weak s = self] dataSource in
                s?.dataSource = dataSource
                Queue.main {
                    s?.tableView.reloadData()
                }
            }
        }
    }

}

////////////////////////////////////////////////////////////////
//MARK: - TableView Delegate & DataSource
////////////////////////////////////////////////////////////////

extension BitbucketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BitbucketTableViewCell.self), for: indexPath) as? BitbucketTableViewCell else { return UITableViewCell() }
        cell.configure(bitbucket: dataSource[indexPath.row])
        return cell
    }
}


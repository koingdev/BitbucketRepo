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
    private lazy var nextPageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next Page", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.isHidden = true
        return button
    }()
    
    private let viewModel = BitbucketViewModel()
    private var dataSource: [Bitbucket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        Queue.background {
            self.viewModel.fetch { [weak s = self] dataSource in
                Queue.main {
                    s?.dataSource = dataSource
                    s?.tableView.reloadData()
                    s?.nextPageButton.isHidden = false
                }
            }
        }
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // Footer
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        nextPageButton.frame = footer.frame
        nextPageButton.addTarget(self, action: #selector(nextPagePressed), for: .touchUpInside)
        footer.addSubview(nextPageButton)
        tableView.tableFooterView = footer
    }
    
    @objc func nextPagePressed() {
        Queue.background {
            self.viewModel.fetchMore { [weak self] nextPageDataSource in
                guard let s = self else { return }
                Queue.main {
                    s.dataSource.append(contentsOf: nextPageDataSource)
                    s.tableView.reloadData()
                    s.nextPageButton.isHidden = !s.viewModel.hasNextPage
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


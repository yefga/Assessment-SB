/// Copyright © 2021. SBTCryptoApp. All rights reserved.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
///
///  TopListsViewController.swift
///  SBTCryptoApp
///
///  Created by Yefga on 09/07/21.


import UIKit

class TopListsViewController: ListTableViewController {

    var presenter: TopListsViewToPresenterProtocol?
        
    private(set) var limit: Int = 10
    private(set) var page: Int = 1
    
    let tableCell: UITableViewCell = TopListsTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.fetchTopLists(limit: limit, page: page)
        
    }
    
    func setupUI() {
        self.title = "Top Lists"
        
        self.prepareTableView(style: .plain)
        
        self.tableView.register(UINib(nibName: tableCell.identifier, bundle: nil), forCellReuseIdentifier: tableCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
 
}


extension TopListsViewController: TopListsPresenterToViewProtocol {
    
    func showLoading() {
        self.showActivityIndicatorView()
    }
    
    func refresh() {
        self.hideActivityIndicatorView()
        self.tableView.reloadData()
    }
}

extension TopListsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension TopListsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.totalItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell.identifier, for: indexPath) as! TopListsTableViewCell
        
        if let items = presenter?.listItems {
            cell.configure(item: items[indexPath.row])
        }
        
        return cell
    }

}

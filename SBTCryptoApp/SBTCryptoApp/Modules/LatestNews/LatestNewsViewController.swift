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
///  LatestNewsViewController.swift
///  SBTCryptoApp
///
///  Created by Yefga on 11/07/21.
///  Using Swift 5.0
///  Running on macOS 11.4
///

import UIKit

class LatestNewsViewController: ListTableViewController {

    var presenter: LatestNewsViewToPresenterProtocol?
    
    let tableCell: UITableViewCell = LatestNewsTableViewCell()
    let refreshControl = UIRefreshControl()
    let footerActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.fetchNews()
    }
    
    func setupUI() {
        self.title = "News"
        
        self.prepareTableView(style: .plain)
        self.tableView.register(UINib(nibName: tableCell.identifier,
                                      bundle: nil), forCellReuseIdentifier: tableCell.identifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.tableView.frame.width,
                                              height: 80))
        self.tableView.tableFooterView = footerView
        
        footerView.addSubview(footerActivityIndicatorView)
        self.footerActivityIndicatorView.center = footerView.center
        self.footerActivityIndicatorView.hidesWhenStopped = true
        self.footerActivityIndicatorView.color = .black
    }
   
    @objc private func refresh() {
        self.presenter?.refreshNews()
    }
}


extension LatestNewsViewController: LatestNewsPresenterToViewProtocol {
    
    func showLoading(_ type: LoadingType) {
        switch type {
        case .initial:
            self.showActivityIndicatorView()
        case .more:
            self.footerActivityIndicatorView.startAnimating()
        case .refresh:
            refreshControl.beginRefreshing()
        }
    }
    
    func hideLoading(_ type: LoadingType) {
        switch type {
        case .initial:
            self.hideActivityIndicatorView()
        case .more:
            self.footerActivityIndicatorView.stopAnimating()
        case .refresh:
            refreshControl.endRefreshing()
        }
        self.tableView.reloadData()
    }
    
    func gotAnError(_ message: String) {
        self.view.makeToast(message)
    }
}

extension LatestNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let items = presenter?.listItems {
            self.presenter?.openLink(urlString: items[indexPath.row].url ?? "https://stockbit.com")
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

extension LatestNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.totalItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell.identifier, for: indexPath) as! LatestNewsTableViewCell
        
        if let items = presenter?.listItems {
            cell.configure(item: items[indexPath.row])
        }
        
        return cell
    }
}

extension LatestNewsViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height))
        
        if offset > 0 {
            self.presenter?.loadMore()
        }
    }
}

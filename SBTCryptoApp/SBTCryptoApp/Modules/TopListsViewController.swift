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

class TopListsViewController: UIViewController {

    var presenter: TopListsViewToPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var limit: Int = 1
    private(set) var page: Int = 1
    
    init() {
        super.init(nibName: "TopListsViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchTopLists(limit: limit, page: page)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
 
}


extension TopListsViewController:  TopListsPresenterToViewProtocol {
    
    func showLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.color = .black
        self.tableView.backgroundView = activityIndicator
        
        self.tableView.separatorStyle = .none
    }
}

extension TopListsViewController: UITableViewDelegate {
    
}

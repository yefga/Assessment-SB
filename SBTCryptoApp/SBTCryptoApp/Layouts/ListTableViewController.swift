//
//  ListTableViewController.swift
//  SBTCryptoApp
//
//  Created by Yefga on 11/07/21.
//

import UIKit

class ListTableViewController: UIViewController {
    
    var activityIndicatorView: UIActivityIndicatorView!
    var tableView: UITableView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    func prepareTableView(style: UITableView.Style){
        tableView = UITableView(frame: CGRect(x: 0,
                                              y: 0, width: view.frame.width,
                                              height: view.frame.height), style: style)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .interactive
        tableView.tableFooterView = UIView(frame: .zero)
        
        view.addSubview(tableView)
    }
    
    func showActivityIndicatorView() {
        let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.activityIndicatorView = indicatorView
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.color = .black
        self.tableView.backgroundView = self.activityIndicatorView
        
        self.activityIndicatorView.startAnimating()
        self.tableView.separatorStyle = .none
    }
    
    func hideActivityIndicatorView() {
        self.activityIndicatorView.stopAnimating()
        self.tableView.separatorStyle = .singleLine
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder:) has not ben implemented")
    }
    
}

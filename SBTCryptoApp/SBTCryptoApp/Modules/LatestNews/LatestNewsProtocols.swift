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
///  LatestNewsProtocols.swift
///  SBTCryptoApp
///
///  Created by Yefga on 11/07/21.
///  Using Swift 5.0
///  Running on macOS 11.4
///

import Foundation

//MARK: Presenter
protocol LatestNewsViewToPresenterProtocol: AnyObject {

    var view: LatestNewsPresenterToViewProtocol?{ get set }
    var interactor: LatestNewsPresenterToInteractorProtocol? {get set}
    var router: LatestNewsPresenterToRouterProtocol? {get set}

    var initialOfCurrency: String { get set }
    var listItems: [News] { get set}
    var totalItems: Int { get }
    /// Add here your methods to communicate between VIEW -> PRESENTER
    func fetchNews()
    func refreshNews()
    func loadMore()
    func openLink(urlString: String)
    
}

//MARK: View
protocol LatestNewsPresenterToViewProtocol: AnyObject {
    
    /// Add here your methods to communicate between PRESENTER -> VIEW
    func showLoading(_ type: LoadingType)
    func hideLoading(_ type: LoadingType)
    func gotAnError(_ message: String)
}

//MARK: Interactor - Input
protocol LatestNewsPresenterToInteractorProtocol: AnyObject {
    
    /// Add here your methods to communicate between PRESENTER -> INTERACTOR
    
    var presenter: LatestNewsInteractorToPresenterProtocol?  { get set }
    func fetchNews(by InitialOfCurrency: String, type: LoadingType)

}

//MARK: Interactor - Output
protocol LatestNewsInteractorToPresenterProtocol: AnyObject {

    /// Add here your methods to communicate between INTERACTOR -> PRESENTER    
    func getItems(items: [News]?, type: LoadingType)
    func gotFailed(_ data: Data?, error: Error)
}

//MARK: Router
protocol LatestNewsPresenterToRouterProtocol: AnyObject {
    
    /// Add here your methods to communicate between PRESENTER -> ROUTER (WIREFRAME)
    func createModule()-> LatestNewsViewController
    func openLink(urlString: String)
}

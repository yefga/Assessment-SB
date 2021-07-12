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
///  LatestNewsPresenter.swift
///  SBTCryptoApp
///
///  Created by Yefga on 11/07/21.
///  Using Swift 5.0
///  Running on macOS 11.4
///

import Foundation

class LatestNewsPresenter: LatestNewsViewToPresenterProtocol {
    
    weak var view: LatestNewsPresenterToViewProtocol?
    
    var interactor: LatestNewsPresenterToInteractorProtocol?
    
    var router: LatestNewsPresenterToRouterProtocol?
    
    private var storedItems: [News] = []

    var initialOfCurrency: String = ""
    
    var listItems: [News] = []
    
    var totalItems: Int {
        return listItems.count
    }
    
    func fetchNews() {
        view?.showLoading(.initial)
        interactor?.fetchNews(by: initialOfCurrency, type: .initial)
    }
    
    func refreshNews() {
        self.storedItems.removeAll()
        self.listItems.removeAll()
        
        view?.showLoading(.refresh)
        interactor?.fetchNews(by: initialOfCurrency, type: .refresh)
    }
    
    func loadMore() {
        view?.showLoading(.more)

        var itemRequested: Int = 10
        
        if listItems.count + 10 < storedItems.count {
            itemRequested = 10
        } else {
            itemRequested = storedItems.count - (listItems.count + 1)
        }
        
        if listItems.count < storedItems.count {
            let loadedItems = Array(storedItems[listItems.count...listItems.count + itemRequested])
            loadedItems.forEach { item in
                if !listItems.contains(item) {
                    self.listItems.append(item)
                }
            }
        }
        
        view?.hideLoading(.more)

    }
    
    
    func openLink(urlString: String) {
        router?.openLink(urlString: urlString)
    }
}

extension LatestNewsPresenter: LatestNewsInteractorToPresenterProtocol {
  
    func getItems(items: [News]?, type: LoadingType) {
        if let items = items {
            items.forEach { news in
                if !self.storedItems.contains(news) {
                    self.storedItems.append(news)
                }
            }
            
            self.storedItems = self.storedItems.sorted(by: { news1, news2 in
                news1.id! < news1.id!
            })
            
            self.listItems = Array(storedItems.prefix(10))
            
            view?.hideLoading(type)
        }
    }
    
    func gotFailed(_ data: Data?, error: Error) {
        if let data = data {
            view?.gotAnError(data.description)
        } else {
            view?.gotAnError(error.localizedDescription)
        }
    }
}

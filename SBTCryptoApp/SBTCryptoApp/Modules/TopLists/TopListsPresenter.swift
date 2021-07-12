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
///  TopListsPresenter.swift
///  SBTCryptoApp
///
///  Created by Yefga on 09/07/21.


import Foundation

class TopListsPresenter: TopListsViewToPresenterProtocol {
    
    weak var view: TopListsPresenterToViewProtocol?
    
    var interactor: TopListsPresenterToInteractorProtocol?
    
    var router: TopListsPresenterToRouterProtocol?

    private var items: [CryptoCurrency] = []
    private var page: Int = 0
    
    var totalItems: Int {
        return items.count
    }
    
    var listItems: [CryptoCurrency] {
        return items
    }
    
    var currentPage: Int {
        return page
    }
    
    var errorMessage: String = ""
    
    func fetchTopLists(limit: Int, page: Int, type: LoadingType) {
        
        view?.showLoading(type)

        self.interactor?.fetchTopLists(limit: minimumLimitRequest,
                                       page: type == .more ? self.page + 1 : page,
                                       type: type)
        
    }
    
    func goToLatestNews(_ InitialOfCurrency: String) {
        self.router?.goToLatestNews(InitialOfCurrency)
    }
    
}

extension TopListsPresenter: TopListsInteractorToPresenterProtocol {
    
    func getItems(items: [CryptoCurrency]?, message: String?, type: LoadingType) {
        
        if type == .refresh {
            self.items.removeAll()
        }
        
        if type == .more {
            self.page += 1
        } else {
            self.page = 1
        }
        
        if let items = items {
            items.forEach { item in
                if !items.isEmpty && !self.items.contains(item) {
                    self.items.append(item)
                }
            }
            
        } else if let errorMessage = message, errorMessage.lowercased() != "success" {
            self.errorMessage = errorMessage
            self.view?.gotAnError(errorMessage)
        }
        
        view?.hideLoading(type)
        
    }
    
    func gotFailed(_ data: Data?, _ error: Error) {
        self.errorMessage = error.localizedDescription
        self.view?.gotAnError(errorMessage)
    }
}

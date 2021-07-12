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
///  LatestNewsInteractor.swift
///  SBTCryptoApp
///
///  Created by Yefga on 11/07/21.
///  Using Swift 5.0
///  Running on macOS 11.4
///

import Alamofire
import AlamofireObjectMapper

class LatestNewsInteractor: LatestNewsPresenterToInteractorProtocol {
    
    weak var presenter: LatestNewsInteractorToPresenterProtocol?
    
    func fetchNews(by InitialOfCurrency: String, type: LoadingType) {
        Alamofire.Session.default.request(NetworkRouter.latestNews(categories: InitialOfCurrency)).validate().responseObject { (response: AFDataResponse<MapArray<News>>) in
            switch response.result {
                case .success(let result):
                    if let items = result.data {
                        self.presenter?.getItems(items: items, type: type)
                    }
                    
                case .failure(let error):
                    self.presenter?.gotFailed(response.data, error: error)
            }
        }
    }
    
}

//
//  HomeScreenInteractor.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation


class HomeScreenInteractor: ImagesScreenInputInteractorProtocol{
    
    weak var presenter: ImageScreenOutputInteractorOutputProtocol?

    func fetchImages(forPageNum pageNum: Int) {
        let url = String(format: "%@?page=%d", AppConstants.kCollectionPhotosURL, pageNum)
        WebserviceHelper.requestAPI(forUrl: url) { (response) in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData!, returningModelType: [ImageModel].self, completion: {[weak self] (apiResponse, error) in
                    guard let strongSelf = self else {
                        return
                    }
                    if let response = apiResponse {
                        DispatchQueue.main.async {
                            strongSelf.presenter?.didFetchImages(forPageNum: pageNum, andImages: response)
                        }
                    }
                })
            case .failure( _):
                break
            }
        }
    }
    
    func searchImages(withKeyword keyword: String, withPageNum pageNum: Int) {
        guard let encodedText = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let url = String(format: "%@?query=%@&page=%d", AppConstants.kSearchPhotosURL,encodedText, pageNum)
        WebserviceHelper.requestAPI(forUrl: url) { (response) in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData!, returningModelType: SearchResultModel.self, completion: {[weak self] (apiResponse, error) in
                    guard let strongSelf = self else {
                        return
                    }
                    if let response = apiResponse {
                        DispatchQueue.main.async {
                            strongSelf.presenter?.didFetchImages(forPageNum: pageNum, andImages: response.results)
                        }
                    }
                })
            case .failure( _):
                break
            }
        }
        
    }
    
    
    
    
}

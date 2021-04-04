//
//  HomeScreenInteractor.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation


class HomeScreenInteractor: HomeScreenInputInteractorProtocol{
    
    weak var presenter: HomeScreenOutputInteractorProtocol?
    
    func fetchImagesFromServer(forPageNum pageNum: Int) {
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
        
}

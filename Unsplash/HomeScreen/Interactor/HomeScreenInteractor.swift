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
        var urlComps = URLComponents(string: AppConstants.kSearchPhotosURL)
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "query", value: encodedText))
        queryItems.append(URLQueryItem(name: "page", value: String(pageNum)))
        if let filters = FilterModel.getFilters() {
            for i in 0..<filters.count {
                let selectedGroup = filters[i]
                for j in 0..<selectedGroup.items!.count{
                    let selectedFilter = filters[i].items![j]
                    if selectedFilter.isApplied == true && selectedFilter.value != nil{
                        queryItems.append(URLQueryItem(name: selectedGroup.queryParam!, value: selectedFilter.value))
                        break
                    }
                }
            }
        }
        urlComps?.queryItems = queryItems
        print(urlComps?.string)
        
        
       // let url = String(format: "%@?query=%@&page=%d", AppConstants.kSearchPhotosURL,encodedText, pageNum)
        WebserviceHelper.requestAPI(forUrl: urlComps!.string!) { (response) in
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

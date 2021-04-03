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
        var isFilterReset = true
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
            isFilterReset = checkIfFiltersBeingReset(forFilters: filters)
        }
        urlComps?.queryItems = queryItems
        print(urlComps?.string)
        
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
                            let itemscount = response.results?.count ?? 0
                            
                            // when there are no items
                            if itemscount == 0{
                                if isFilterReset{
                                    strongSelf.presenter?.filterButtonStatus(toShow: false, imageToShow: nil)
                                } else{
                                    strongSelf.presenter?.filterButtonStatus(toShow: true, imageToShow: AppConstants.sortAppliedIcon)
                                }
                            }// when there are items
                            else{
                                if isFilterReset {
                                    strongSelf.presenter?.filterButtonStatus(toShow: true, imageToShow: AppConstants.sortIcon)
                                } else{
                                    strongSelf.presenter?.filterButtonStatus(toShow: true, imageToShow: AppConstants.sortAppliedIcon)
                                }
                            }
                        }
                    }
                })
            case .failure( _):
                break
            }
        }
        
    }
    
    
    func checkIfFiltersBeingReset(forFilters currentFilter:[FilterModel]) -> Bool{
        if let defaultFilters = FilterModel.getDefaultFilters() {
            for i in 0..<defaultFilters.count{
                if defaultFilters[i] != currentFilter[i]{
                    return false
                }
            }
        }
        return true
    }
   
    
    
}

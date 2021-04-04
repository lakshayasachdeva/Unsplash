//
//  AdvancedSearchInteractorTests.swift
//  UnsplashTests
//
//  Created by Lakshaya Sachdeva on 05/04/21.
//

import XCTest
@testable import Unsplash

class AdvancedSearchInteractorTests: XCTestCase {
    
    var sut: AdvancedSearchInputInteractorProtocol?
    var mockInteractorOutputProtocol: MockAdvancedSearchOutputInteractor?

    override func setUp() {
        sut = AdvancedSearchInteractor()
        mockInteractorOutputProtocol = MockAdvancedSearchOutputInteractor()
        sut?.presenter = mockInteractorOutputProtocol
    }
    
    override func tearDown() {
        sut = nil
        mockInteractorOutputProtocol = nil
    }
    
    func test_WhenBlackAndWhiteIsApplied_shouldReturnBlackAndWhite_pass(){
        
        // ARRANGE
        let expectedItem = FilterItem(name: "Black and white", value: "black_and_white", isApplied: true)
        
        // ACT
        sut?.modifyFilters(withChangedItem: 1, forGroup: 1, toCurrentFilter: FilterModel.getDefaultFilters()!)
        
        // ASSERT
        XCTAssertEqual(mockInteractorOutputProtocol!.appliedFilters![1].items![1], expectedItem)
    }
    
    func test_whenAnyColorIsApplied_shouldReturnAnyColor_pass(){
        
        // ARRANGE
        let expectedItem = FilterItem(name: "Any color", value: nil, isApplied: true)
        
        // ACT
        sut?.modifyFilters(withChangedItem: 0, forGroup: 1, toCurrentFilter: FilterModel.getDefaultFilters()!)
        
        // ASSERT
        XCTAssertEqual(mockInteractorOutputProtocol!.appliedFilters![1].items![0], expectedItem)
    }
    
    
    func test_WhenSortByRelevanceIsApplied_shouldReturnSortByRelevance_pass(){
        
        // ARRANGE
        let expectedItem = FilterItem(name: "Relevance", value: "relevant", isApplied: true)
        
        // ACT
        sut?.modifyFilters(withChangedItem: 0, forGroup: 0, toCurrentFilter: FilterModel.getDefaultFilters()!)
        
        // ASSERT
        XCTAssertEqual(mockInteractorOutputProtocol!.appliedFilters![0].items![0], expectedItem)
    }
    
    func test_WhenSortByLatestIsApplied_shouldReturnSortByLatest_pass(){
        
        // ARRANGE
        let expectedItem = FilterItem(name: "Newest", value: "latest", isApplied: true)
        
        // ACT
        sut?.modifyFilters(withChangedItem: 1, forGroup: 0, toCurrentFilter: FilterModel.getDefaultFilters()!)
        
        // ASSERT
        XCTAssertEqual(mockInteractorOutputProtocol!.appliedFilters![0].items![1], expectedItem)
    }
    
    func test_WhenAnyOrientedIsApplied_shouldReturnAnyOrientation_pass(){
        
        // ARRANGE
        let expectedItem = FilterItem(name: "Any", value: nil, isApplied: true)
        
        // ACT
        sut?.modifyFilters(withChangedItem: 0, forGroup: 2, toCurrentFilter: FilterModel.getDefaultFilters()!)
        
        // ASSERT
        XCTAssertEqual(mockInteractorOutputProtocol!.appliedFilters![2].items![0], expectedItem)
    }
    
    func test_WhenLandscapeOrientedIsApplied_shouldReturnLandscapeOrientation_pass(){
        
        // ARRANGE
        let expectedItem = FilterItem(name: "Landscape", value: "landscape", isApplied: true)
        
        // ACT
        sut?.modifyFilters(withChangedItem: 1, forGroup: 2, toCurrentFilter: FilterModel.getDefaultFilters()!)
        
        // ASSERT
        XCTAssertEqual(mockInteractorOutputProtocol!.appliedFilters![2].items![1], expectedItem)
    }
    
    func test_WhenPortraitOrientedIsApplied_shouldReturnPortraitOrientation_pass(){
        
        // ARRANGE
        let expectedItem = FilterItem(name: "Portrait", value: "portrait", isApplied: true)
        
        // ACT
        sut?.modifyFilters(withChangedItem: 2, forGroup: 2, toCurrentFilter: FilterModel.getDefaultFilters()!)
        
        // ASSERT
        XCTAssertEqual(mockInteractorOutputProtocol!.appliedFilters![2].items![2], expectedItem)
    }
    
    func test_WhenSquareOrientedIsApplied_shouldReturnSquareOrientation_pass(){
        
        // ARRANGE
        let expectedItem = FilterItem(name: "Square", value: "squarish", isApplied: true)
        
        // ACT
        sut?.modifyFilters(withChangedItem: 3, forGroup: 2, toCurrentFilter: FilterModel.getDefaultFilters()!)
        
        // ASSERT
        XCTAssertEqual(mockInteractorOutputProtocol!.appliedFilters![2].items![3], expectedItem)
    }
    
    func test_whenResetFilterIsApplied_shouldReturnDefaultFilters_pass(){
        // ARRANGE
        let defaultFilters = FilterModel.getDefaultFilters()
        
        // ACT
        sut?.resetAllFilters()
        
        // ASSERT
        XCTAssertEqual(mockInteractorOutputProtocol!.appliedFilters![0], defaultFilters![0])
    }

    func test_whenHitOnApplyFilters_filtersShouldBeSaved_pass(){
        // ARRANGE
        let defaultFilters = FilterModel.getDefaultFilters()
        
        // ACT
        sut?.saveAppliedFilters(withData: defaultFilters!)
        
        // ACT
        XCTAssertTrue(mockInteractorOutputProtocol!.isFiltersSaved)
                
    }
}



class MockAdvancedSearchOutputInteractor: AdvancedSearchOuputInteractorProtocol{
    
    var appliedFilters: [FilterModel]?
    var isFiltersSaved = false
    
    func didFetchSavedFilters(withFilters filters: [FilterModel]?) {
        appliedFilters = filters
    }
    
    func didModifyFilters(filters data: [FilterModel]?, forGroup group: Int) {
        appliedFilters = data
    }
    
    func didResetFilters(filters data: [FilterModel]?) {
        appliedFilters = data
    }
    
    func didSaveFilters() {
        isFiltersSaved = true
    }
    
    
}

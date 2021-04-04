//
//  ImagesModelEntityTests.swift
//  UnsplashTests
//
//  Created by Lakshaya Sachdeva on 05/04/21.
//

import XCTest
@testable import Unsplash

class ImagesModelEntityTests: XCTestCase  {

    func testEntitySetGet(){
        
        let imageEntity = ImageModel(urls: ImageURLData(thumb: "https://google.com", full: nil))
        XCTAssertEqual(imageEntity.urls?.thumb, "https://google.com")
        XCTAssertNil(imageEntity.urls?.full)
        XCTAssertNotNil(imageEntity.urls?.thumb)
    }

}

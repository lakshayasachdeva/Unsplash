//
//  ImageModel.swift
//  Unsplash
//
//  Created by Lakshaya Sachdeva on 02/04/21.
//

import Foundation

struct ImageModel: Codable {
    let urls: ImageURLData?
}

struct ImageURLData: Codable{
    let thumb: String?
    let full: String?
}

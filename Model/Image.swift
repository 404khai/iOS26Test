//
//  Image.swift
//  iOS26Test
//
//  Created by admin on 5/28/26.
//

import SwiftUI

struct ImageModel: Identifiable{
    var id: UUID = .init()
    var image: String
}

var images: [ImageModel] = (1...6).map { ImageModel(image: "Image\($0)") }

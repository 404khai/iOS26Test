//
//  Image.swift
//  iOS26Test
//
//  Created by admin on 5/28/26.
//

import SwiftUI

struct ImageModel: Identifiable, Hashable {
    var id: UUID = .init()
    var image: String
    var title: String
    var category: String
    var metadataLine: String
    var summary: String
}

var images: [ImageModel] = [
    ImageModel(
        image: "Image1",
        title: "Mercenary Enrollment",
        category: "Manhwa",
        metadataLine: "Action • School • Thriller",
        summary: "A former child soldier returns to civilian life and tries to protect the only family he has left."
    ),
    ImageModel(
        image: "Image2",
        title: "Latna Saga",
        category: "Fantasy",
        metadataLine: "Adventure • Action • Isekai",
        summary: "A reluctant hero is pulled into a harsh world where survival, leveling, and fate are tightly linked."
    ),
    ImageModel(
        image: "Image3",
        title: "The World After the Fall",
        category: "Sci-Fi",
        metadataLine: "Fantasy • Survival • Mystery",
        summary: "After the tower collapses, one man chooses to keep climbing and uncover what the world really is."
    ),
    ImageModel(
        image: "Image4",
        title: "Player",
        category: "Action",
        metadataLine: "Fantasy • Game • Adventure",
        summary: "A normal student is thrown into a game-like world and forced to grow stronger with every battle."
    ),
    ImageModel(
        image: "Image5",
        title: "Ordeal",
        category: "Superhero",
        metadataLine: "Action • Drama • Fantasy",
        summary: "Gifted fighters and powerful bloodlines collide in a world where strength comes with a heavy cost."
    ),
    ImageModel(
        image: "Image6",
        title: "Surviving the Game",
        category: "Thriller",
        metadataLine: "Action • Dark Fantasy • Survival",
        summary: "Each choice has consequences as the protagonist faces escalating dangers in a brutal world."
    )
]

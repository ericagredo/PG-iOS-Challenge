//
//  ItemModel.swift
//  PG iOS Challenge
//
//  Created by Eric Agredo on 3/23/22.
//

import Foundation

struct Item: Codable, Identifiable{
    var id: Int
    var type: String
    var title: String?
    var url: URL?
    var kids: [Int]?
    var by: String?
    var text: String?
}

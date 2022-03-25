//
//  CommentsViewModel.swift
//  PG iOS Challenge
//
//  Created by Eric Agredo on 3/24/22.
//

import SwiftUI

class CommentsViewModel: ObservableObject {
    @Published var comments = [Item]()
    @Published var replies = [Item]()
    
    @MainActor
    func getComments(ids: [Int]) async {
        do {
            for id in ids {
                let url = URL(string: Constants.getItem + "\(id).json")!
                let request = URLRequest(url: url)
                let item = try await URLSession.shared.decode(Item.self, from: request)
                if !comments.contains(where: { checker in
                    checker.id == item.id
                }) {
                    comments.append(item)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getReplies(ids: [Int]) async -> [Item] {
        var tmp = [Item]()
        do {
            replies.removeAll()
            for id in ids {
                let url = URL(string: Constants.getItem + "\(id).json")!
                let request = URLRequest(url: url)
                let item = try await URLSession.shared.decode(Item.self, from: request)
                tmp.append(item)
            }
        } catch {
            print(error)
        }
        
        return tmp
    }
}

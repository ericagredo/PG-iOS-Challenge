//
//  StoryViewModel.swift
//  PG iOS Challenge
//
//  Created by Eric Agredo on 3/23/22.
//

import SwiftUI

struct Story: Identifiable{
    var id: String
    var items: [Item]
}

class StoryViewModel: ObservableObject{
    @Published var items = [Item]()
    
    func getStories() async{
        let url = URL(string: Constants.topStoriesUrl)!
        let request = URLRequest(url: url)
        do{
            
            let ids = try await URLSession.shared.decode([Int].self,from: request)
            await convertToItems(ids: ids)
        }catch{
            print(error)
        }
    }
    @MainActor
    func convertToItems(ids: [Int]) async {
        
        do{
            for id in ids {
                let url = URL(string: Constants.getItem + "\(id).json")!
                let request = URLRequest(url: url)
                let item = try await URLSession.shared.decode(Item.self,from: request)
                if !items.contains(where: { checker in
                    checker.id == item.id
                }){
                    
                    items.append(item)
                }
            }
        }catch{
            print(error)
        }
    }
}

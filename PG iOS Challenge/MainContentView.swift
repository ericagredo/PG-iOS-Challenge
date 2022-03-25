//
//  ViewController.swift
//  PG iOS Challenge
//
//  Created by Eric Agredo on 3/22/22.
//
import SwiftUI

struct HomeView: View {
    @StateObject var vm = StoryViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.items) { item in
                    NavigationLink {
                        ItemView(item: item)
                    } label: {
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(item.title ?? "")
                                .font(.system(.headline, design: .rounded))
                            Text("By: " + (item.by ?? ""))
                                .font(.system(.subheadline, design: .rounded))
                        }
                        .padding(.all, 8)
                    }
                }
            }
            .navigationBarTitle("Top stories")
            .onAppear {
                Task {
                    await vm.getStories()
                }
            }
        }
    }
}

struct ItemView: View {
    var item: Item
    @State var progressShowing = true
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(item.title ?? "")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
            if let url = item.url {
                Text(.init("Source: [click here](\(url.absoluteString))"))
                    .font(.system(.callout, design: .rounded))
            } else {
                Text(item.text?.changeHTMLText() ?? "")
            }
            Text("Comments:")
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.semibold)
            
            ZStack {
                ActivityIndicator(isAnimating: progressShowing)
                Comments(item: item, progressShowing: $progressShowing)
            }
        }
        .padding(.horizontal, 16)
    }
}




struct Replies: View {
    var items: [Int]
    @ObservedObject var vm: CommentsViewModel
    @State var replies = [Item]()
    var body: some View {
        VStack {
            if replies.count == 0 {
                ActivityIndicator(isAnimating: true)
            } else {
                List {
                    ForEach(replies, id: \.id) { item in
                        Text(item.text?.changeHTMLText() ?? "")
                    }
                }
            }
        }
        .navigationBarTitle(Text("Replies"))
        
        .onAppear {
            Task {
                replies = await vm.getReplies(ids: items)
            }
        }
    }
}

struct Comments: View {
    var item: Item
    
    @Binding var progressShowing: Bool
    @StateObject var vm = CommentsViewModel()
    var body: some View {
        List {
            ForEach(vm.comments, id: \.id) { comment in
                
                VStack {
                    Text(comment.text?.changeHTMLText() ?? "")
                        .fixedSize(horizontal: false, vertical: true)
                        
                    if let children = comment.kids {
                        NavigationLink {
                            Replies(items: children, vm: vm)
                        } label: {
                            Text("Replies")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            Task {
                await vm.getComments(ids: item.kids ?? [Int]())
                progressShowing = false
            }
        }
    }
}

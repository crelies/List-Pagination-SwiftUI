//
//  ListPaginationExampleView.swift
//  SwiftUI-List-Pagination
//
//  Created by Christian Elies on 03.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct ListPaginationExampleView: View {
    @State private var items: [String] = Array(0...24).map { "Item \($0)" }
    @State private var page: Int = 0
    private let pageSize: Int = 25
    
    var body: some View {
        NavigationView {
            List(items) { item in
                VStack(alignment: .leading) {
                    Text(item)
                    
                    if self.items.isLastItem(item) {
                        Divider()
                        Text("Loading ...")
                            .padding(.vertical)
                    }
                }.onAppear {
                    self.listItemAppears(item)
                }
            }
            .navigationBarTitle("List of items")
            .navigationBarItems(trailing: Text("Page index: \(page)"))
        }
    }
}

extension ListPaginationExampleView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if items.isLastItem(item) {
            /*
                Simulated async behaviour:
                Creates items for the next page and
                appends them to the list after a short delay
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.page += 1
                let moreItems = self.getMoreItems(forPage: self.page, pageSize: self.pageSize)
                self.items.append(contentsOf: moreItems)
            }
        }
    }
}

extension ListPaginationExampleView {
    /*
        In a real app you would probably fetch data
        from an external API.
     */
    private func getMoreItems(forPage page: Int,
                              pageSize: Int) -> [String] {
        let maximum = ((page * pageSize) + pageSize) - 1
        let moreItems: [String] = Array(items.count...maximum).map { "Item \($0)" }
        return moreItems
    }
}

#if DEBUG
struct ListPaginationExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ListPaginationExampleView()
    }
}
#endif

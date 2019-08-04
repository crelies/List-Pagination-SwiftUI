//
//  RandomAccessCollection+isLastItem.swift
//  SwiftUI-List-Pagination
//
//  Created by Christian Elies on 04.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

extension RandomAccessCollection where Self.Element: Identifiable {
    func isLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard !isEmpty else {
            return false
        }
        
        guard let itemIndex = firstIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 1
    }
}

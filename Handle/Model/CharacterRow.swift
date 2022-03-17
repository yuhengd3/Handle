//
//  CharacterRow.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import Foundation

struct CharacterRow: Identifiable {
    var id: Int
    private(set) var row: [CharacterBlock]
    
    init(_ r: [CharacterBlock]) {
        id = 0
        row = r
        for i in row.indices {
            id += (i + 1) * row[i].id
        }
    }
}

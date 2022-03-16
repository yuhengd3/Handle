//
//  CharacterBlock.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import Foundation

struct CharItem {
    var character: String
    var initial: String
    var final: String
    var tone: String
}

struct CharacterBlock {
    enum Status {
        case incorrect
        case incorrectPosition
        case correct
    }
    
    var charItem: CharItem
    
    var charStatus = Status.incorrect
    var initialStatus = Status.incorrect
    var finalStatus = Status.incorrect
    var toneStatus = Status.incorrect
}


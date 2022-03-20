//
//  CharacterRow.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import Foundation

struct WordItem {
    var word: [CharItem]
    
    func compare(_ answer: WordItem, row: Int) -> CharacterRow {
        assert(self.word.count == answer.word.count, "compare function two items have different length")
        
        var _word: [CharItem] = self.word
        var _answer: [CharItem] = self.word
        var arr = [CharacterBlock]()
        
        for i in 0..<_word.count {
            var charBlock = CharacterBlock(id: row * 4 + i, charItem: _word[i])
            if (_word[i].character == answer.word[i].character) {
                charBlock.charStatus = .correct
                _word[i].character = ""
                _answer[i].character = "$$"
            }
            if (_word[i].initial == answer.word[i].initial) {
                charBlock.initialStatus = .correct
                _word[i].initial = ""
                _answer[i].initial = "$$"
            }
            if (_word[i].final == answer.word[i].final) {
                charBlock.finalStatus = .correct
                _word[i].final = ""
                _answer[i].final = "$$"
            }
            if (_word[i].tone == answer.word[i].tone) {
                charBlock.toneStatus = .correct
                _word[i].tone = ""
                _answer[i].tone = "$$"
            }
            arr.append(charBlock)
        }
        for i in 0..<_word.count {
            for j in 0..<_word.count {
                if j == i {
                    continue
                }
                if (_word[i].character == _answer[j].character) {
                    arr[i].charStatus = .incorrectPosition
                    _word[i].character = ""
                    _answer[j].character = "$$"
                }
                if (_word[i].initial == _answer[j].initial) {
                    arr[i].initialStatus = .incorrectPosition
                    _word[i].initial = ""
                    _answer[j].initial = "$$"
                }
                if (_word[i].final == _answer[j].final) {
                    arr[i].finalStatus = .incorrectPosition
                    _word[i].final = ""
                    _answer[j].final = "$$"
                }
                if (_word[i].tone == _answer[j].tone) {
                    arr[i].toneStatus = .incorrectPosition
                    _word[i].tone = ""
                    _answer[j].tone = "$$"
                }
            }
        }
        
        return CharacterRow(arr)
    }
}

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

//
//  CharacterRowView.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import SwiftUI

struct CharacterRowView: View {
    var charRow: CharacterRow
    
    var body: some View {
        HStack {
//            ForEach(charRow) { charBlock in
//                CharacterBlockView(charBlock: charBlock)
//            }
            CharacterBlockView(charBlock: charRow.row[0])
            CharacterBlockView(charBlock: charRow.row[1])
            CharacterBlockView(charBlock: charRow.row[2])
            CharacterBlockView(charBlock: charRow.row[3])
        }
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static func getRow() -> [CharacterBlock] {
        var li = [CharacterBlock]()
        let char0 = CharItem(character: "我", initial: "w", final: "o", tone: "ˇ")
        let char1 = CharItem(character: "心", initial: "x", final: "in", tone: "¯")
        let char2 = CharItem(character: "飞", initial: "f", final: "ei", tone: "¯")
        let char3 = CharItem(character: "扬", initial: "y", final: "ang", tone: "´")
        li.append(CharacterBlock(id: 0, charItem: char0, charStatus: .incorrect, initialStatus: .incorrect, finalStatus: .incorrectPosition, toneStatus: .correct))
        li.append(CharacterBlock(id: 1, charItem: char1, charStatus: .incorrect, initialStatus: .incorrect, finalStatus: .correct, toneStatus: .incorrect))
        li.append(CharacterBlock(id: 2, charItem: char2, charStatus: .correct, initialStatus: .correct, finalStatus: .correct, toneStatus: .correct))
        li.append(CharacterBlock(id: 3, charItem: char3, charStatus: .incorrect, initialStatus: .correct, finalStatus: .incorrectPosition, toneStatus: .correct))
        return li
    }
    
    static var previews: some View {
        CharacterRowView(charRow: CharacterRow(getRow()))
    }
}

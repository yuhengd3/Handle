//
//  CharacterBlock.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import SwiftUI

struct CharacterBlockView: View {
    static func chooseColor(_ status: CharacterBlock.Status) -> Color {
        switch status {
        case .correct:
            return Color("Keppel")
        case .incorrectPosition:
            return Color("FuzzyWuzzy")
        default:
            return .black
        }
    }
    
    let charBlock: CharacterBlock
    
    var body: some View {
        if charBlock.charStatus == .correct {
            ZStack {
                Rectangle()
                    .fill()
                    .foregroundColor(Color("Keppel"))
                VStack(spacing: 0) {
                    ZStack {
                        // inital + final
                        HStack(spacing: 0) {
                            Text(charBlock.charItem.initial)
                                .foregroundColor(.white)
                            Text(charBlock.charItem.final)
                                .foregroundColor(.white)
                        }
                        VStack {
                            // tone
                            Text(charBlock.charItem.tone)
                                .foregroundColor(.white)
                            Spacer()
                                .frame(height: 5)
                        }
                    }
                    Text(charBlock.charItem.character)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 80, height: 80, alignment: .top)
        } else {
            ZStack {
                Rectangle()
                    .fill()
                    .foregroundColor(Color("CharBackground"))
                VStack(spacing: 0) {
                    ZStack {
                        // inital + final
                        HStack(spacing: 0) {
                            Text(charBlock.charItem.initial)
                                .foregroundColor(CharacterBlockView.chooseColor(charBlock.initialStatus))
                            Text(charBlock.charItem.final)
                                .foregroundColor(CharacterBlockView.chooseColor(charBlock.finalStatus))
                        }
                        VStack {
                            // tone
                            Text(charBlock.charItem.tone)
                                .foregroundColor(CharacterBlockView.chooseColor(charBlock.toneStatus))
                            Spacer()
                                .frame(height: 5)
                        }
                    }
                    Text(charBlock.charItem.character)
                        .font(.largeTitle)
                        .foregroundColor(CharacterBlockView.chooseColor(charBlock.charStatus))
                }
            }
            .frame(width: 80, height: 80, alignment: .top)
        }
    }
}

struct CharacterBlock_Previews: PreviewProvider {
    static let xin = CharItem(character: "心", initial: "x", final: "in", tone: "¯")
    static let xinBlock = CharacterBlock(charItem: xin, charStatus: .incorrect, initialStatus: .incorrect, finalStatus: .incorrectPosition, toneStatus: .correct)
    static let fei = CharItem(character: "飞", initial: "f", final: "ei", tone: "¯")
    static let feiBlock = CharacterBlock(charItem: fei, charStatus: .correct, initialStatus: .correct, finalStatus: .correct, toneStatus: .correct)
    
    static var previews: some View {
        CharacterBlockView(charBlock: xinBlock)
            .previewLayout(.fixed(width: 100, height: 100))
        CharacterBlockView(charBlock: feiBlock)
            .previewLayout(.fixed(width: 100, height: 100))
    }
}

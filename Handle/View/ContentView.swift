//
//  ContentView.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import SwiftUI

struct ContentView: View {
    var repo: [CharacterRow]
    @State private var input: String = ""
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Button(action: {
                    print("button1 pressed")
                }, label: {
                    Image(systemName: "questionmark.circle")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding()
                })
                Spacer()
                Text("Handle")
                    .font(.largeTitle)
                    .foregroundColor(Color("HoneyYellow"))
                Spacer()
                Button(action: {
                    print("button2 pressed")
                }, label: {
                    Image(systemName: "arrowtriangle.forward.circle")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding()
                })
            }
            
            Divider()
            ScrollView {
                VStack {
                    Spacer()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    ForEach(repo) { row in
                        CharacterRowView(charRow: row)
                    }
                    
                    EmptyRowView()
                }
            }
            Spacer()
            ZStack {
                Rectangle()
                    .fill()
                    .frame(height: 52, alignment: .bottom)
                    .padding([.leading, .trailing], 26)
                    .foregroundColor(Color("CharBackground"))
                TextField("输入四字词语", text: $input)
                    .fixedSize()
                    .frame(width: 300, height: 40)
                    
            }
            Spacer()
                .fixedSize(horizontal: false, vertical: true)
            Button(action: {
                print("bottom button pressed")
                // call function
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 40, alignment: .bottom)
                    Text("Enter")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            })
            
            Spacer()
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(repo: getRepo())
    }
    
    static func getRepo() -> [CharacterRow] {
        var repo = [CharacterRow]()
        let row = CharacterRow(getRow())
        for _ in 0..<3 {
            repo.append(row)
        }
        return repo
    }
    
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
}

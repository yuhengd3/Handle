//
//  ContentView.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: GameViewModel
    
    @State private var input: String = ""
    @State private var showingAlert = false
    @State private var alertState = AlertState.first
    
    enum AlertState {
        case first, second, third
    }
    
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
                    .onTapGesture {
                        viewModel.reinit()
                    }
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
                    ScrollViewReader { value in
                        ForEach(viewModel.model.previousAttempts) { row in
                            CharacterRowView(charRow: row)
                        }
                        .onChange(of: viewModel.model.previousAttempts.count) { _ in
                            value.scrollTo("blank")
                        }
                        if viewModel.model.state == .ongoing {
                            EmptyRowView().id("blank")
                        }
                    }
                }
            }
            Spacer()
            ZStack {
                Rectangle()
                    .fill()
                    .frame(height: 52, alignment: .bottom)
                    .padding([.leading, .trailing], 26)
                    .foregroundColor(Color("CharBackground"))
                TextField("??????????????????", text: $input)
                    .fixedSize()
                    .frame(width: 300, height: 40)
                    
            }
            Spacer()
                .fixedSize(horizontal: false, vertical: true)
            Button(action: {
                if viewModel.model.state == .ongoing {
                    if viewModel.enter(input) {
                        input = ""
                        if viewModel.model.state == .success {
                            alertState = .second
                            showingAlert = true
                        } else if viewModel.model.state == .failure {
                            alertState = .third
                            showingAlert = true
                        }
                    } else {
                        alertState = .first
                        showingAlert = true
                    }
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(viewModel.model.state == .ongoing ? Color("Keppel") : .gray)
                        .frame(width: 100, height: 40, alignment: .bottom)
                    Text("Enter")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            })
                .alert(isPresented: $showingAlert) {
                    switch alertState {
                    case .first:
                        return Alert(title: Text("Alert"), message: Text("????????????????????????"), dismissButton: .default(Text("?????????")))
                    case .second:
                        return Alert(title: Text("Congrats"), message: Text("???????????????"), dismissButton: .default(Text("?????????")))
                    case .third:
                        var text = ""
                        for t in viewModel.model.answer!.word {
                            text += t.character
                        }
                        return Alert(title: Text("Answer"), message: Text(text), dismissButton: .default(Text("???????????????")))
                    }
                    
                }
            
            Spacer()
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = GameViewModel()
        ContentView(viewModel: viewModel)
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
        let char0 = CharItem(character: "???", initial: "w", final: "o", tone: "??")
        let char1 = CharItem(character: "???", initial: "x", final: "in", tone: "??")
        let char2 = CharItem(character: "???", initial: "f", final: "ei", tone: "??")
        let char3 = CharItem(character: "???", initial: "y", final: "ang", tone: "??")
        li.append(CharacterBlock(id: 0, charItem: char0, charStatus: .incorrect, initialStatus: .incorrect, finalStatus: .incorrectPosition, toneStatus: .correct))
        li.append(CharacterBlock(id: 1, charItem: char1, charStatus: .incorrect, initialStatus: .incorrect, finalStatus: .correct, toneStatus: .incorrect))
        li.append(CharacterBlock(id: 2, charItem: char2, charStatus: .correct, initialStatus: .correct, finalStatus: .correct, toneStatus: .correct))
        li.append(CharacterBlock(id: 3, charItem: char3, charStatus: .incorrect, initialStatus: .correct, finalStatus: .incorrectPosition, toneStatus: .correct))
        return li
    }
}

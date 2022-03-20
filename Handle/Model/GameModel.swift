//
//  GameModel.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/17.
//

import Foundation

let fus: [String] = ["zh", "ch", "sh", "b", "p",
                    "m", "f", "d", "t", "n",
                    "l", "g", "k", "h", "j",
                    "q", "x", "y", "w", "z",
                    "c", "s", "r"]

struct GameModel {
    let MAX_ATTEMPTS = 10;
    let IDIOMS_BANK: [[CharItem]] = load("idioms.json")
    
    private(set) var currIdx = 0;
    private(set) var previousAttempts = [CharacterRow]()
    
    mutating func enter(_ str: String) -> Bool {
        return true
    }
}

// modified from Apple SwiftUI Tutorial
func load(_ filename: String) -> [[CharItem]] {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    var res = [[CharItem]]()
    
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : String]
        for (idiom, rawPin) in json {
            var block = [CharItem]()
            let pins = rawPin.split(separator: " ")
            precondition(pins.count == idiom.count, "pinyin has incorrect size")
            for i in 0..<pins.count {
                var fu: String = ""
                let pin = pins[i]
                for f in fus {
                    if pin.starts(with: f) {
                        fu = f
                        break
                    }
                }
                let range: Range<String.Index> = pin.index(pin.startIndex, offsetBy: fu.count)..<pin.index(pin.startIndex, offsetBy: pin.count - 1)
                let yuan: String = String(pin[range])
                let char = CharItem(character: idiom, initial: fu, final: yuan, tone: findTone(pin[pin.index(pin.endIndex, offsetBy: -1)]))
                block.append(char)
            }
            res.append(block)
        }
        print(res.count)
    } catch {
        fatalError("can't parse json")
    }
    
    return res
}

func findTone(_ char: Character) -> String {
    switch char {
    case "1":
        return "¯"
    case "2":
        return "´"
    case "3":
        return "ˇ"
    case "4":
        return "~"
    default:
        fatalError("tone \(char) doesn't exist")
    }
}

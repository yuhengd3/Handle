//
//  GameModel.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/17.
//

import Foundation

let FUS: [String] = ["zh", "ch", "sh", "b", "p",
                    "m", "f", "d", "t", "n",
                    "l", "g", "k", "h", "j",
                    "q", "x", "y", "w", "z",
                    "c", "s", "r"]

let TONES: [String: Set<Character>] = ["¯": ["ā", "ē", "ī", "ō", "ū", "ǖ"],
                                       "´": ["á", "é", "í", "ó", "ú", "ǘ"],
                                       "ˇ": ["ǎ", "ě", "ǐ", "ǒ", "ǔ", "ǚ"],
                                       "`": ["à", "è", "ì", "ò", "ù", "ǜ"]]

struct GameModel {
    enum State {
        case ongoing
        case success
        case failure
    }
    
    let MAX_ATTEMPTS = 10;
    let IDIOMS_BANK: [WordItem] = load("idioms.json")
    
    private(set) var currIdx = 0;
    private(set) var previousAttempts = [CharacterRow]()
    private(set) var answer: Optional<WordItem> = nil
    private(set) var state: State = .ongoing
    
    init() {
        setAnswer()
    }
    
    mutating func reinit() {
        previousAttempts.removeAll()
        currIdx = 0
        state = .ongoing
        
        setAnswer()
    }
    
    private mutating func setAnswer() {
        let ran = Int.random(in: 0..<IDIOMS_BANK.count)
        answer = IDIOMS_BANK[ran]
        print(answer!)
    }
    
    mutating func enter(_ str: String) -> Bool {
        guard let word = GameModel.getWordItem(str) else {
            return false
        }
        
        let result = word.compare(answer!, row: currIdx)
        
        previousAttempts.append(result)
        var completed = true
        for item in result.row {
            if item.charStatus != .correct {
                completed = false
                break
            }
        }
        
        if completed {
            state = .success
            return true
        }
        
        currIdx += 1;
        if currIdx == 10 {
            state = .failure
        }
        return true
    }
    
    
    
    static func getWordItem(_ str: String) -> Optional<WordItem> {
        // check length
        if str.count != 4 {
            return nil
        }
        
        // check if each character is chinese
        for c in str {
            if c < "\u{4E00}" || c > "\u{9FA5}" {
                return nil
            }
        }
        
        var chars = [CharItem]()
        
        // from https://www.jianshu.com/p/5fe0cc8b5ae0
        for c in str {
            let pin = NSMutableString(string: String(c))
            var tone:String = ""
            CFStringTransform(pin, nil, kCFStringTransformToLatin, false)
            for ch in String(pin) {
                if let t = getToneFromPin(ch) {
                    tone = t
                    break
                }
            }
            CFStringTransform(pin, nil, kCFStringTransformStripDiacritics, false)
            let (initial, final) = separatePin(String(pin))
            let charItem = CharItem(character: String(c), initial: initial, final: final, tone: tone)
            chars.append(charItem)
        }
        
        return WordItem(word: chars)
    }
    
    static func getToneFromPin(_ pin: Character) -> Optional<String> {
        for (k, s) in TONES {
            if s.contains(pin) {
                return k
            }
        }
        return nil
    }
}

// modified from Apple SwiftUI Tutorial
func load(_ filename: String) -> [WordItem] {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    var res = [WordItem]()
    
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : String]
        for (idiom, rawPin) in json {
            var block = [CharItem]()
            let pins = rawPin.split(separator: " ")
            precondition(pins.count == idiom.count, "pinyin has incorrect size")
            for i in 0..<pins.count {
                let pin = String(pins[i])
                let idx = pin.index(pin.endIndex, offsetBy: -1)
                let (fu, yuan) = separatePin(String(pin[..<idx]))
                let ch = idiom[idiom.index(idiom.startIndex, offsetBy: i)]
                let char = CharItem(character: String(ch), initial: fu, final: yuan, tone: getToneFromNumerical(pin[idx]))
                block.append(char)
            }
            res.append(WordItem(word: block))
        }
        print(res.count)
    } catch {
        fatalError("can't parse json")
    }
    
    return res
}

func getToneFromNumerical(_ char: Character) -> String {
    switch char {
    case "1":
        return "¯"
    case "2":
        return "´"
    case "3":
        return "ˇ"
    case "4":
        return "`"
    default:
        fatalError("tone \(char) doesn't exist")
    }
}

func separatePin(_ pin: String) -> (String, String) {
    var fu: String = ""
    for f in FUS {
        if pin.starts(with: f) {
            fu = f
            break
        }
    }
    let range: Range<String.Index> = pin.index(pin.startIndex, offsetBy: fu.count)..<pin.endIndex
    let yuan: String = String(pin[range])
    return (fu, yuan)
}

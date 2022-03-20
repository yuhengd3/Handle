//
//  GameViewModel.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/19.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published private(set) var model = GameModel()
    
    func enter(_ str: String) -> Bool {
        return model.enter(str)
    }
}

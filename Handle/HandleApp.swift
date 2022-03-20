//
//  HandleApp.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import SwiftUI

@main
struct HandleApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(repo: [CharacterRow]())
        }
    }
}

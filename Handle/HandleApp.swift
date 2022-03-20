//
//  HandleApp.swift
//  Handle
//
//  Created by Yuheng Ding on 2022/3/16.
//

import SwiftUI

@main
struct HandleApp: App {
    let viewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}

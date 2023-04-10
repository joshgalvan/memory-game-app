//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Joshua Galvan on 3/15/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeStore = ThemeStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeStore)
        }
    }
}

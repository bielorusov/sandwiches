//
//  SandwichesApp.swift
//  Sandwiches
//
//  Created by Dmitriy Belorusov on 8/5/22.
//

import SwiftUI

@main
struct SandwichesApp: App {
    @StateObject private var store = SandwichStore(sandwiches: testData)
    
    var body: some Scene {
        WindowGroup {
          ContentView(store: store).preferredColorScheme(.dark)
        }
    }
}

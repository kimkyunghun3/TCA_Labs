//
//  TCA_PracApp.swift
//  TCA_Prac
//
//  Created by LS-MAC-00211 on 2023/08/25.
//

import SwiftUI

@main
struct TCA_PracApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(store: .init(initialState: ContentCore.State(), reducer: {
            ContentCore()
          }))
        }
    }
}

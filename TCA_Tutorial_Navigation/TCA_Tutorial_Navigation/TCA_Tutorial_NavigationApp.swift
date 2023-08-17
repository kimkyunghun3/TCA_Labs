//
//  TCA_Tutorial_NavigationApp.swift
//  TCA_Tutorial_Navigation
//
//  Created by LS-MAC-00211 on 2023/08/14.
//

import SwiftUI

@main
struct TCA_Tutorial_NavigationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: .init(initialState: ContactsFeature.State(), reducer: {
                ContactsFeature()
            }))
        }
    }
}

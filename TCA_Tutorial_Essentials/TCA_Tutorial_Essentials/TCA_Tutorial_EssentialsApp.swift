//
//  TCA_Tutorial_EssentialsApp.swift
//  TCA_Tutorial_Essentials
//
//  Created by LS-MAC-00211 on 2023/08/14.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_Tutorial_EssentialsApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: TCA_Tutorial_EssentialsApp.store)
        }
    }
}

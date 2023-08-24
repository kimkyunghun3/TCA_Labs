//
//  SwiftUI_Dev_TutorialsApp.swift
//  SwiftUI_Dev_Tutorials
//
//  Created by LS-MAC-00211 on 2023/08/24.
//

import SwiftUI

@main
struct SwiftUI_Dev_TutorialsApp: App {
    var body: some Scene {
        WindowGroup {
          ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}

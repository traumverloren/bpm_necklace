//
//  bpm_necklaceApp.swift
//  bpm_necklace WatchKit Extension
//
//  Created by Steph on 2/15/21.
//

import SwiftUI

@main
struct bpm_necklaceApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

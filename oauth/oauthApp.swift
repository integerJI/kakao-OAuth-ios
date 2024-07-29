import SwiftUI

@main
struct oauthApp: App {
    // AppDelegate 연결
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

import SwiftUI

@main
struct UniversalLinkApp: App {
    @State private var receivedURL: URL?

    var body: some Scene {
        WindowGroup {
            ContentView(receivedURL: $receivedURL)
                .onOpenURL { url in
                    receivedURL = url
                }
        }
    }
}

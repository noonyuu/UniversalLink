import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

private let webURL = URL(string: "https://noonyuu.github.io/universal-link-web/")!

struct ContentView: View {
    @Binding var receivedURL: URL?
    @State private var showBanner = false

    var body: some View {
        ZStack(alignment: .top) {
#if canImport(UIKit)
            WebView(url: webURL)
                .ignoresSafeArea()
#endif

            if showBanner, let url = receivedURL {
                DeepLinkBanner(url: url) {
                    withAnimation {
                        showBanner = false
                        receivedURL = nil
                    }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .zIndex(1)
            }
        }
        .onChange(of: receivedURL) { _, newValue in
            if newValue != nil {
                withAnimation {
                    showBanner = true
                }
            }
        }
    }
}

struct DeepLinkBanner: View {
    let url: URL
    let onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: "link.circle.fill")
                    .foregroundStyle(.green)
                Text("Universal Link で起動しました")
                    .font(.subheadline.bold())
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
            Text(url.absoluteString)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

import SwiftUI
import WebKit

@main
struct DecoderApp: App {
    var body: some Scene {
        WindowGroup { DecoderView().ignoresSafeArea(edges: .bottom) }
    }
}

struct DecoderView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .default()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.isOpaque = false
        webView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.93, alpha: 1)
        webView.scrollView.contentInsetAdjustmentBehavior = .automatic
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

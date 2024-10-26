import SwiftUI

public struct UIWebView: View {
    @State private var isLoading = false
    private let urlString : String
    
    public init(urlString: String) {
        self.urlString = urlString
    }

    public var body: some View {
        ZStack {
            if let url = URL(string: urlString) {
                WebView(url: url, isLoading: $isLoading)
                
                if isLoading {
                    ProgressView()
                }
            } else {
                Text("読み込めませんでした。")
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


import SwiftUI
import Utility

public struct WebRepoView: View {
    let repoUrl: String
    
    public var body: some View {
        UIWebView(urlString: repoUrl)
    }
}

#Preview {
    WebRepoView(repoUrl: "https://www.apple.com/jp")
}

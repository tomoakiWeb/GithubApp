import SwiftUI
import DetailFeature

public struct HomeContentView: View {
    public init() {}

    public var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: DetailView()) {
                    Text("Go to Detail View")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeContentView()
}


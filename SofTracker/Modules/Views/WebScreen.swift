//
// Created by TMA on 02/20/25.
//
import SwiftUI

struct WebScreen: View {
    // MARK: - Properties

    @State private var isLoading = true
    @State private var showError = false

    var urlString = "https://shurutech.com/"

    // MARK: - Body

    var body: some View {
        VStack {
            WebView(urlString: urlString, isLoading: $isLoading, showError: $showError)
        }
        .loader(isLoading)
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text("Cannot load the webpage. Something went wrong."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    WebScreen()
}


import SwiftUI
import UIKit

@main
struct UIViewControlsApp: App {

    var body: some Scene {
        WindowGroup {
            AppEntryView()
                .ignoresSafeArea()
        }
    }
}

struct AppEntryView: UIViewControllerRepresentable {

    func makeUIViewController(
        context: Context
    ) -> UINavigationController {
        UINavigationController(
            rootViewController: MainViewController()
        )
    }

    func updateUIViewController(
        _ uiViewController: UINavigationController,
        context: Context
    ) {
    }
}

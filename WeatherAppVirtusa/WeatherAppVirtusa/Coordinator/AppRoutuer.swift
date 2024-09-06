//
//  AppCoordinator.swift
//  WeatherAppVirtusa
//
//  Created by Aadi on 9/5/24.
//

import UIKit
import SwiftUI

enum AppNavigationScreen {
    case weatherDetailsScreen
}

enum NavigationType {
    case push
    case present
}

class AppRoutuer {
    static let shared = AppRoutuer()
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    private init() {}
    
    func configure(window: UIWindow?) {
        self.window = window
    }
    
    func loadInititalView() {
        let vc = ContentViewController()
        self.navigationController = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func navigate(to swiftUIView: some View,
                  navigationType: NavigationType) {
        switch navigationType {
        case .push:
            let hostingVC = UIHostingController(rootView: swiftUIView)
            hostingVC.title = "Weather Detail View"
            self.navigationController?.pushViewController(hostingVC, animated: true)
        case .present:
            break
        }
    }
}

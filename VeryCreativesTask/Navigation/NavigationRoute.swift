//
//  NavigationRoute.swift
//  GRIP-Task1
//
//  Created by Noor Walid on 18/03/2022.
//

import Foundation
import UIKit

protocol NavigationRoute {
    func navigate(to route: Route)
}

extension UIViewController: NavigationRoute {
    func navigate(to route: Route) {
        switch route.style {
        case .modal:
            self.present(route.destination, animated: true, completion: nil)
        case .push:
            self.navigationController?.pushViewController(route.destination, animated: true)
        }
    }
}

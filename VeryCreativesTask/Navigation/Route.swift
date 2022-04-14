//
//  Route.swift
//  VeryCreativesTask
//
//  Created by Noor Walid on 18/03/2022.
//

import Foundation
import UIKit

protocol Route {
    var destination: UIViewController { get }
    var style: NavigationStyle { get }
}

enum NavigationStyle {
    case modal
    case push
}

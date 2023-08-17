//
//  Coordinator.swift
//  RecipesApp
//
//  Created by andres paladines on 8/16/23.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController {get set}
    func startCoordinator()

}

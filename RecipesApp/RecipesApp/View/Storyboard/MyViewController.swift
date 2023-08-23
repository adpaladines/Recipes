//
//  MyViewController.swift
//  RecipesApp
//
//  Created by Andres D. Paladines on 8/22/23.
//

import UIKit

class MyViewController: UIViewController {
    
    var mainCoordinator: MainCoordinator?
    
    
    @IBAction func buttonActionTap(_ sender: Any) {
        guard let coord = mainCoordinator else  {
            return
        }
        coord.path.removeLast()
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.isUserLogged.rawValue)
            UserDefaults.standard.synchronize()
        }
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

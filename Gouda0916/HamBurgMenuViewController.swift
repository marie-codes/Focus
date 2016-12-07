//
//  HamBurgMenuViewController.swift
//  Gouda0916
//
//  Created by Marie Park on 12/5/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation

import UIKit

class HamburgerMenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    let testArray = ["home", "goal", "Velocity", "notificiations", "logout"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Menu Table View setup
extension HamburgerMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "menuCell")
        cell?.textLabel?.text = testArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch testArray[indexPath.row] {
        case "home":
            NotificationCenter.default.post(name: .openMainVC, object: nil)
        case "goal":
            NotificationCenter.default.post(name: .openGoalVC, object: nil)
        case "Velocity":
            NotificationCenter.default.post(name: .openVelocityVC, object: nil)
        default:
            break
        }
    }
}

//Dismiss view controller when option selected
extension HamburgerMenuViewController {
    
    func add(viewController: UIViewController, animated: Bool = false) {
        self.addChildViewController(viewController)
        self.view.alpha = 0.0
        viewController.didMove(toParentViewController: self)
        
        guard animated else { self.view.alpha = 1.0; return }
        
        UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view.alpha = 1.0
        }) { _ in }
    }
}
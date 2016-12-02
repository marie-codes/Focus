//
//  MainViewController.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class MainViewController: UIViewController {

    let store = DataStore.sharedInstance
    let rootRef = "https://gouda0916-4bb79.firebaseio.com/"

    let velocity = Velocity()
    let velocityScoreView = VelocityScoreView()

    // TODO: Fix
    @IBOutlet weak var ButtonBackground: UIView!
    @IBOutlet weak var buttonShadowBackground: UIView!
    @IBOutlet weak var failSuccessLabel: UILabel!

    @IBOutlet weak var failButton: UIButton!
    // TODO: Fix successButton misspelling
    @IBOutlet weak var sucessButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchData()

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

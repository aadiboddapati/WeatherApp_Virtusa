//
//  ViewController.swift
//  WeatherAppVirtusa
//
//  Created by Aadi on 9/5/24.
//

import UIKit
import SwiftUI

class ContentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let childVC = UIHostingController(rootView: WeatherSearchView())
        addChild(childVC)
        childVC.view.frame = self.view.bounds
        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

}


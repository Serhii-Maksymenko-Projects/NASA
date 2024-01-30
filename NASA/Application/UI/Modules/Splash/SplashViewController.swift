//
//  ViewController.swift
//  NASA
//
//  Created by    Sergey on 20.01.2024.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet private weak var firstLoaderElement: LoaderElementView!
    @IBOutlet private weak var secondLoaderElement: LoaderElementView!
    @IBOutlet private weak var thirdLoaderElement: LoaderElementView!
    @IBOutlet private weak var lastLoaderElement: LoaderElementView!

    static let storyboardName = "Splash"

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstLoaderElement.animate(delay: 0.0)
        secondLoaderElement.animate(delay: 0.2)
        thirdLoaderElement.animate(delay: 0.4)
        lastLoaderElement.animate(delay: 0.6)
    }

}

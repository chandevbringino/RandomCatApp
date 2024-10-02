//
//  SplashScreenController.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/2/24.
//

import UIKit
import Lottie

class SplashScreenController: UIViewController {
    @IBOutlet var lottieView: LottieAnimationView!
}

// MARK: - Lifecycle

extension SplashScreenController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLottie()
    }
}

// MARK: - Setup

private extension SplashScreenController {
    func setupLottie() {
        lottieView.layer.cornerRadius = 10
        lottieView.contentMode = .scaleAspectFit
        lottieView.animationSpeed = 2.5
        lottieView.play { _ in
            self.presentCatDetails()
        }
    }
}

// MARK: - Routers

private extension SplashScreenController {
    func presentCatDetails() {
        let vc = R.storyboard.catDetails.catDetailsController()!
        vc.viewModel = CatDetailsViewModel()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

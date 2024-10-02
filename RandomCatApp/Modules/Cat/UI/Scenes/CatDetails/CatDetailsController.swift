//
//  CatDetailsController.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/1/24.
//

import UIKit
import Kingfisher
import SVProgressHUD

class CatDetailsController: UIViewController {
    var viewModel: CatDetailsViewModelProtocol!
    
    @IBOutlet private(set) var backgroundGradientView: Gradient!
    @IBOutlet private(set) var catImageView: UIImageView!
    @IBOutlet private(set) var labelView: UIView!
    @IBOutlet private(set) var catFactLabel: UILabel!
}

// MARK: - Lifecycle

extension CatDetailsController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup

private extension CatDetailsController {
    func setup() {
        setupViews()
        setupGesture()
        
        labelView.isHidden = true
        fetchCatDetails()
    }
    
    func setupViews() {
        catImageView.layer.cornerRadius = 10
        labelView.layer.cornerRadius = 10
        labelView.layer.borderColor = UIColor.black.cgColor
        labelView.layer.borderWidth = 1
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(mainViewTapped)
        )
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupGradientColor() {
        backgroundGradientView.startColor = getRandomColor()
        backgroundGradientView.endColor = getRandomColor()
    }
}

// MARK: - Refresh

private extension CatDetailsController {
    func refresh() {
        labelView.isHidden = false
        
        setupGradientColor()
        catImageView.kf.setImage(with: viewModel.catImageURL)
        catFactLabel.text = viewModel.catFact
    }
}

// MARK: - Actions

private extension CatDetailsController {
    @objc
    func mainViewTapped() {
        fetchCatDetails()
    }
}

// MARK: - Methods

private extension CatDetailsController {
    func fetchCatDetails() {
        SVProgressHUD.show()
        viewModel.getCatDetails(
            onSuccess: handleGetCatDetailsSuccess(),
            onError: handleGetCatDetailsError()
        )
    }
}

// MARK: - Handlers

private extension CatDetailsController {
    func handleGetCatDetailsSuccess() -> VoidResult {
        { [weak self] in
            guard let self else { return }
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.refresh()
            }
        }
    }
    
    func handleGetCatDetailsError() -> ErrorResult {
        { [weak self] error in
            guard let self else { return }
            SVProgressHUD.dismiss()
            DispatchQueue.main.async {
                self.showAlertMessage(
                    title: "Error",
                    message: error.localizedDescription
                )
            }
        }
    }
}

// MARK: - Helpers

private extension CatDetailsController {
    func getRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func showAlertMessage(title: String?, message: String?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}

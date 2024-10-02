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
    
    @IBOutlet private(set) var catImageView: UIImageView!
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
        setupImageView()
        setupGesture()
        
        fetchCatDetails()
    }
    
    func setupImageView() {
        catImageView.layer.cornerRadius = 8
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(mainViewTapped)
        )
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Refresh

private extension CatDetailsController {
    func refresh() {
        DispatchQueue.main.async {
            self.catImageView.kf.setImage(with: self.viewModel.catImageURL)
            self.catFactLabel.text = self.viewModel.catFact
        }
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

// MARK: - Handlers

private extension CatDetailsController {
    func handleGetCatDetailsSuccess() -> VoidResult {
        { [weak self] in
            guard let self else { return }
            SVProgressHUD.dismiss()
            self.refresh()
        }
    }
    
    func handleGetCatDetailsError() -> ErrorResult {
        { [weak self] error in
            guard let self else { return }
            SVProgressHUD.dismiss()
            self.showAlertMessage(
                title: "Error",
                message: error.localizedDescription
            )
        }
    }
}

//
//  CatDetailsViewModel.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/1/24.
//

import Foundation

class CatDetailsViewModel: CatDetailsViewModelProtocol {
    private var cat: CatModel?
    
    private let service: RandomCatServiceProtocol
    
    init(service: RandomCatServiceProtocol = App.shared.randomCat) {
        self.service = service
    }
}

// MARK: - Methods

extension CatDetailsViewModel {
    func getCatDetails(
        onSuccess: @escaping VoidResult,
        onError: @escaping ErrorResult
    ) {
        service.getCatDetails(
            onSuccess: handleGetCatDetailsSuccess(
                thenExecute: onSuccess
            ),
            onError: onError
        )
    }
}

// MARK: - Handlers

private extension CatDetailsViewModel {
    func handleGetCatDetailsSuccess(
        thenExecute onCompletion: @escaping VoidResult
    ) -> SingleResult<CatModel> {
        { [weak self] cat in
            guard let self else { return }
            self.cat = cat
            onCompletion()
        }
    }
}

// MARK: - Getters

extension CatDetailsViewModel {
    var catImageURL: URL? { cat?.imageUrl }
    var catFact: String { cat?.fact ?? "" }
}

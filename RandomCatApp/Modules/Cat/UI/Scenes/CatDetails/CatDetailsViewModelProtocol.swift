//
//  CatDetailsViewModelProtocol.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/1/24.
//

import Foundation

protocol CatDetailsViewModelProtocol {
    var catImageURL: URL? { get }
    var catFact: String { get }
    
    func getCatDetails(
        onSuccess: @escaping VoidResult,
        onError: @escaping ErrorResult
    )
}

//
//  RandomCatServiceProtocol.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/2/24.
//

import Foundation

protocol RandomCatServiceProtocol {
    func getCatDetails(
        onSuccess: @escaping SingleResult<CatModel>,
        onError: @escaping ErrorResult
    )
}

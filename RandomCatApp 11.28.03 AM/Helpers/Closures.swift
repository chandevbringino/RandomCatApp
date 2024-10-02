//
//  Closures.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/1/24.
//

import Foundation

// MARK: - Typealiases

typealias EmptyResult<ReturnType> = () -> ReturnType

typealias SingleResultWithReturn<T, ReturnType> = ((T) -> ReturnType)
typealias DoubleResultWithReturn<T1, T2, ReturnType> = ((T1, T2) -> ReturnType)
typealias TripleResultWithReturn<T1, T2, T3, ReturnType> = ((T1, T2, T3) -> ReturnType)

typealias SingleResult<T> = SingleResultWithReturn<T, Void>
typealias DoubleResult<T1, T2> = DoubleResultWithReturn<T1, T2, Void>
typealias TripleResult<T1, T2, T3> = TripleResultWithReturn<T1, T2, T3, Void>

typealias VoidResult = EmptyResult<Void> 
typealias ErrorResult = SingleResult<Error>
typealias BoolResult = SingleResult<Bool>

// MARK: - Default Closures

struct DefaultClosure {
  static func voidResult() -> VoidResult { {} }
  static func singleResult<T>() -> SingleResult<T> { { _ in } }
  static func doubleResult<T1, T2>() -> DoubleResult<T1, T2> { { _, _ in } }
  static func tripleResult<T1, T2, T3>() -> TripleResult<T1, T2, T3> { { _, _, _ in } }
}

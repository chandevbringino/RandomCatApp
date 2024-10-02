//
//  NetworkMonitorServiceProtocol.swift
//  RandomUsersApp
//
//  Created by Christian Bringino on 8/3/24.
//

import Combine
import Foundation

protocol NetworkMonitorServiceProtocol {
  var isConnectedToInternet: Bool { get }
    
  var isConnectedToInternetPublisher: AnyPublisher<Bool, Never> { get }
}

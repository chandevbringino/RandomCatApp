//
//  NetworkMonitorService.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/2/24.
//

import Foundation
import Network
import Combine

final class NetworkMonitorService: NetworkMonitorServiceProtocol {
  @Published private(set) var isConnectedToInternet: Bool = false
  
  private let monitor: NWPathMonitor
  
  init(monitor: NWPathMonitor = NWPathMonitor()) {
    self.monitor = monitor
    
    monitor.pathUpdateHandler = { [unowned self] path in
      DispatchQueue.main.async {
        self.isConnectedToInternet = (path.status == .satisfied)
      }
    }
    
    let queue = DispatchQueue(label: String(describing: self))
    monitor.start(queue: queue)
  }
}

// MARK: - Getters

extension NetworkMonitorService {
  var isConnectedToInternetPublisher: AnyPublisher<Bool, Never> {
    $isConnectedToInternet
      .removeDuplicates()
      .eraseToAnyPublisher()
  }
}

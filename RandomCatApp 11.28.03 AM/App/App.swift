//
//  App.swift
//  RandomCatApp
//
//  Created by Christian Bringino on 10/1/24.
//

import UIKit

class App {
    static let shared = App()
    
    // MARK: - API
    
    private(set) var api: RandomCatAPI!
    
    // MARK: - Services
    
    private(set) var randomCat: RandomCatServiceProtocol!
    private(set) var networkMonitor: NetworkMonitorServiceProtocol!
    
    func bootstrap(
      with application: UIApplication,
      launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        networkMonitor = NetworkMonitorService()
        api = RandomCatAPI()
        
        randomCat = RandomCatService(
            api: api
        )
    }
}

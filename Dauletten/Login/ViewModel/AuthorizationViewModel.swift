//
//  AuthorizationViewModel.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/21/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
protocol DefaultViewModelOutput {
    var error: Observable<String> { get }
    var loading: Observable<Bool> { get }
}

class AuthorizationViewModel: DefaultViewModelOutput {
    var error: Observable<String> = Observable("")
    var loading: Observable<Bool> = Observable(false)
    var user: Observable<User?> = Observable(nil)
    
    func getAuthorization(parameters: Parameters) {
        if UserDefaults.standard.integer(forKey: Key.deviceID) == 0 {
            getDeviceId {
                self.getLogin(parameters: parameters)
            }
        } else {
            getLogin(parameters: parameters)
        }
    }
    
    private func getLogin(parameters: Parameters) -> Void {
        self.loading.value = true
        ParseManager.shared.postRequest(url: AppConstants.API.authUrl, parameters: parameters, success: { (result: User?) in
            self.loading.value = false
            self.user.value = result
        }) { (error) in
            self.loading.value = false
            self.error.value = error
        }
    }
    
    private func getDeviceId( _ completion: @escaping () -> ()) -> Void {
        self.loading.value = true
        ParseManager.shared.getRequest(url: AppConstants.API.getDeviceId, success: { (result: DeviceId) in
            self.loading.value = false
            UserDefaults.standard.set(result.id, forKey: Key.deviceID)
            completion()
        }) { (error) in
            self.loading.value = false
            self.error.value = error
        }
    }
    

}

//
//  AuthorizationValuesViewModel.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/21/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
class AuthorizationValuesViewModel: ViewModelConfigurable {
    var errorMessage: String = ""
    var parameters: Parameters = [:]

    private var phone: String = String()
    private var user: String = String()
    private var password: String = String()

    func setPhone(_ phone: String) -> Void {
        let text = phone
        let phoneNumber = String(text.suffix(text.count-2)).replacingOccurrences(of: " ", with: "")
        self.phone = "\(phoneNumber)"
    }
    
    func setUser(_ user: String) {
        self.user = user
    }
    
    func setPassword(_ password: String) -> Void {
        self.password = password
    }

    func isValid() -> Bool {

        guard user != "" else { errorMessage = "Қолданушыны жазыңыз"; return false}
        guard password != "" else { errorMessage = "Құпиясөзді жазыңыз"; return false}

        return true
    }

    func getParameters() -> Parameters? {
        guard isValid() else {return nil}
        parameters["phone"] = user
        parameters["password"] = password
        parameters["device_id"] = UserDefaults.standard.integer(forKey: Key.deviceID)

        return parameters
    }

}

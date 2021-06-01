//
//  UserManager.swift
//  JTI
//
//  Created by Nursultan on 10/17/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import Foundation
class UserManager {

    //    MARK: - Properties
    static let userDefaults = UserDefaults.standard

    //    MARK: - Keys
//    private let deviceTokenIdentifier = "deviceTokenIdentifier"
//    private let userIdentifier = "userIdentifier"


    //    MARK: - Creation of user session

    static func createSessionWithUser(_ user: User) throws {
        let jsonEncoder = JSONEncoder()
        do {
            
            let userData = try jsonEncoder.encode(user)
            guard let token = user.token else { return }
            setCurrentToken(to: token)
            userDefaults.set(userData, forKey: Key.currentUser)
            
        } catch {
            throw error
        }
    }
    
    private static func setCurrentToken(to token: String) {
        userDefaults.set(token, forKey: Key.currentToken)
    }
    
    static func getCurrentToken() -> String? {
        return userDefaults.string(forKey: Key.currentToken)
    }
    
    static func getCurrentUser() -> User? {
        let jsonDecoder = JSONDecoder()
        if let userData = userDefaults.value(forKey: Key.currentUser) as? Data {
            do {
                let currentUser = try jsonDecoder.decode(User.self, from: userData)
                return currentUser
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func deleteCurrentSession() {
        userDefaults.set(nil, forKey: Key.currentToken)
        userDefaults.set(nil, forKey: Key.currentUser)
    }
}

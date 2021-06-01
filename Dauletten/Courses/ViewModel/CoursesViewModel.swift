//
//  CoursesViewModel.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/22/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class CoursesViewModel: DefaultViewModelOutput {
    var error: Observable<String> = Observable("")
    var loading: Observable<Bool> = Observable(false)
    var categotyList: Observable<[Category]> = Observable([])
    var lastPage = 1
    var page = 1
    var isFree = 1

    func getAccessToken() -> Void {
        if let token = UserManager.getCurrentToken() {
            let params = ["token": token]
            ParseManager.shared.postRequest(url: AppConstants.API.getAccessToken, parameters: params, success: { (result: EmptyResponse) in
            }) { (error) in
                self.error.value = error
                UserManager.deleteCurrentSession()
            }
            self.getCategoryList()
        } else {
            self.getCategoryList()
        }
    }
    
    func getCategoryList() {
        var parameters = Parameters()
        parameters["page"] = page
        parameters["free"] = isFree
        if page == 1 { self.categotyList.value.removeAll() }
//        if search != "" { parameters["search"] = search }

        ParseManager.shared.getRequest(url: AppConstants.API.getCourses, parameters: parameters, token: UserManager.getCurrentUser()?.token, success: { (result: PaginationResult<[Category]>) in
            self.loading.value = false
            self.categotyList.value.append(contentsOf: result.data)
            self.page = result.page
            self.lastPage = result.pages
        }) { (error) in
            self.loading.value = false
            self.error.value = error
        }
    }

}

//
//  MyCoursesViewModel.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/21/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class MyCoursesViewModel: DefaultViewModelOutput {
    var error: Observable<String> = Observable("")
    var loading: Observable<Bool> = Observable(false)
    var categotyList: Observable<[Category]> = Observable([])
    var page = 1
    var lastPage = 1
    
    func getCategoryList(page: Int) {
        var parameters = Parameters()
        parameters["page"] = page
        if page == 1 { self.categotyList.value.removeAll() }
        
        ParseManager.shared.getRequest(url: AppConstants.API.getMyCourses, parameters: parameters, success: { (result: PaginationResult<[Category]>) in
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

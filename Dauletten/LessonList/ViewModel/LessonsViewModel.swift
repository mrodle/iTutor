//
//  LessonsViewModel.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/21/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class LessonsViewModel: DefaultViewModelOutput {
    var error: Observable<String> = Observable("")
    var loading: Observable<Bool> = Observable(false)
    var videoList: Observable<[Lesson]> = Observable([])
    
    func getVideoList(courseId: Int, search: String = "") {
        self.videoList.value.removeAll()
        var parameters = Parameters()
        parameters["course_id"] = courseId
        if search != "" {parameters["search"] = search}

        ParseManager.shared.getRequest(url: AppConstants.API.getVideoList, parameters: parameters, token: UserManager.getCurrentUser()?.token ?? "token", success: { (result: [Lesson]) in
            self.loading.value = false
            self.videoList.value.append(contentsOf: result)

        }) { (error) in
            self.loading.value = false
            self.error.value = error
        }
    }

    
    
}

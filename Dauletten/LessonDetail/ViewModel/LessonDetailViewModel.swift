//
//  LessonDetailViewModel.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/21/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class LessonDetailViewModel: DefaultViewModelOutput {
    var error: Observable<String> = Observable("")
    var loading: Observable<Bool> = Observable(false)
    var video: Observable<Video?> = Observable(nil)
    
    func getVideo(id: Int) {
        var parameters = Parameters()
        parameters["lesson_id"] = id
        self.loading.value = true
        ParseManager.shared.getRequest(url: AppConstants.API.getVideo, parameters: parameters, success: { (result: Video) in
            self.loading.value = false
            self.video.value = result
        }) { (error) in
            self.loading.value = false
            self.error.value = error
        }
    }

}

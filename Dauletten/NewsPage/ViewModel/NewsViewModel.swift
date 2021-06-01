//
//  NewsViewModel.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/22/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class NewsViewModel: DefaultViewModelOutput {
    var error: Observable<String> = Observable("")
    var loading: Observable<Bool> = Observable(false)
    var newsList: Observable<[News]> = Observable([])
    var lastPage = 1
    var page = 1

    func getNewsList() -> Void {
        let parameters: Parameters = ["page": page]
        if page == 1 { self.newsList.value.removeAll() }

        ParseManager.shared.getRequest(url: AppConstants.API.getNews, parameters: parameters, success: { (result: PaginationResult<[News]>) in
            self.loading.value = false
            self.newsList.value.append(contentsOf: result.data)
            self.page = result.page
            self.lastPage = result.pages
        }) { (error) in
            self.loading.value = false
            self.error.value = error
        }
    }
    
    
}

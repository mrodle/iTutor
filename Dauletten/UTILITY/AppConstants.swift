//
//  AppConstants.swift
//  JTI
//
//  Created by Tuigynbekov Yelzhan on 9/12/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import UIKit

class AppConstants {
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let navBarHeight = UINavigationController().navigationBar.bounds.height
    static let saveMe = "saveMe"
    
    static func getTabbarHeight(_ tabBarController: UITabBarController?) -> CGFloat {
        return (tabBarController?.tabBar.frame.size.height)!
    }

    class API {

        //        MARK: - Base Url

        static let baseUrl = "ss"


        //        MARK: - General API

        static let authUrl = "v1/login"
        static let getCourses = "v1/courses"
        static let getMyCourses = "v1/my-courses"
        static let getVideoList = "v1/lessons"
        static let getVideo = "v1/lesson"
        static let getBuyCourse = "v1/course-buy"
        static let getQuestionList = "v1/question-answers"
        static let getNewsType = "v1/post-cats"
        static let getNews = "v1/posts"
        static let getNewsById = "v1/post"
        static let getSetting = "v1/setting"
        static let getAccessToken = "v1/login-by-token"
        static let checkVersion =  "version"
        static let getDeviceId = "v1/generator_device_id"
        static let setting = "v1/setting"
    }
}

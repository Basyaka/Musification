//
//  StorageService.swift
//  Musification
//
//  Created by Vlad Novik on 16.04.21.
//

import Foundation

protocol UserInfoStorageProtocol {
    func saveUserInfo(_ userInfo: UserInfo)
    func getUserInfo() -> [UserInfo]?
    func deleteUserInfo()
}

class StorageService: UserInfoStorageProtocol {
    private let userInfoRepository = UserInfoRepository()
    
    func saveUserInfo(_ userInfo: UserInfo) {
        return userInfoRepository.create(userInfo)
    }
    
    func getUserInfo() -> [UserInfo]? {
        return userInfoRepository.getUserInfo()
    }
    
    func deleteUserInfo() {
        return userInfoRepository.delete()
    }
}

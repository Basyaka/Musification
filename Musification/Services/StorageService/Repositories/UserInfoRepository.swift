//
//  UserInfoRepository.swift
//  Musification
//
//  Created by Vlad Novik on 16.04.21.
//

import Foundation
import CoreData

class UserInfoRepository {
    
    func create(_ userInfo: UserInfo) {
        let cdUserUnfo = CDUserInfo(context: PersistentStorage.shared.context)
        cdUserUnfo.username = userInfo.username
        cdUserUnfo.userPhoto = userInfo.userPhotoData
        PersistentStorage.shared.saveContext()
    }
    
    func getUserInfo() -> [UserInfo]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDUserInfo.self)
        
        var userInfoArray: [UserInfo] = []
        
        result?.forEach({ (cdUserInfo) in
            let userInfo = UserInfo(username: cdUserInfo.username,
                                    userPhotoData: cdUserInfo.userPhoto)
            
            userInfoArray.append(userInfo)
        })
        return userInfoArray
    }
    
    
    func delete() {
        guard let cdUserInfo = getElement() else { return }
        PersistentStorage.shared.context.delete(cdUserInfo)
        PersistentStorage.shared.saveContext()
    }
    
    private func getElement() -> CDUserInfo? {
        let fetchRequest = NSFetchRequest<CDUserInfo>(entityName: "CDUserInfo")
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return nil }
            return result
        } catch let error {
            print(error)
        }
        return nil
    }
}

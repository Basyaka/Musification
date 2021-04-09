//
//  TabBarPage.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import UIKit

enum TabBarPage {
    case songs
    case artists
    case albums
    case profile
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .songs
        case 1:
            self = .artists
        case 2:
            self = .albums
        case 3:
            self = .profile
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .songs:
            return "Songs"
        case .artists:
            return "Artists"
        case .albums:
            return "Albums"
        case .profile:
            return "Profile"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .songs:
            return 0
        case .artists:
            return 1
        case .albums:
            return 2
        case .profile:
            return 3
        }
    }
    
    // Add tab icon value
    func pageIconValue() -> UIImage {
        switch self {
        case .songs:
            return UIImage(systemName: "play.circle")!
            
        case .artists:
            return UIImage(systemName: "person.crop.circle.badge.questionmark")!
            
        case .albums:
            return UIImage(systemName: "rectangle.stack.person.crop")!
            
        case .profile:
            return UIImage(systemName: "person")!
        
        }
    }
    
    // Add tab icon selected / deselected color
    
    // etc
}

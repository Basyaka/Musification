//
//  TabBarPage.swift
//  Musification
//
//  Created by Vlad Novik on 8.04.21.
//

import Foundation

enum TabBarPage {
    case songs
    case artists
    case profile
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .songs
        case 1:
            self = .artists
        case 2:
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
        case .profile:
            return 2
        }
    }
    
    // Add tab icon value
    
    // Add tab icon selected / deselected color
    
    // etc
}

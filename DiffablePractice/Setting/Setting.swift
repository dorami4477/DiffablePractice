//
//  Setting.swift
//  DiffablePractice
//
//  Created by 박다현 on 7/18/24.
//

import Foundation


struct Setting:Hashable, Identifiable{
    let id = UUID()
    let title:String
}

class SettingDataManager{
    static let shared = SettingDataManager()
    
    private init(){}
    
    private var list:[[Setting]] = [
        [
            Setting(title: "공지사항"),
            Setting(title: "실험실"),
            Setting(title: "버전 정보"),
        ],
        [
            Setting(title: "개인/보안"),
            Setting(title: "알림"),
            Setting(title: "채팅"),
            Setting(title: "멀티프로필"),
        ],
        [
            Setting(title: "고객센터/도움말"),
        ],
    ]
    
    func fetchList() -> [[Setting]]{
        return list
    }
}

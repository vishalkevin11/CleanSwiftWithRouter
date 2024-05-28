//
//  NewsEntity.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Foundation

struct NewsEntity: Identifiable, Equatable {
    let id = UUID().uuidString
    let author: String?
    let title: String?
    let desciption: String?
    let url: String?
    let imageUrl: String?
}

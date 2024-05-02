//
//  News.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Foundation


struct NewsList: Codable {
    let newsList: [News]?
    private enum CodingKeys: String, CodingKey {
        case newsList = "articles"
    }
}

struct News: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey  {
        case author
        case title
        case description
        case url
        case imageUrl = "urlToImage"
    }
    
    init(author: String?, title: String?, description: String?, url: String?, urlToImage: String?) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.imageUrl = urlToImage
    }
}


extension News {
    func toDomain() -> NewsEntity {
        return NewsEntity(author: self.author, title: self.title, desciption: self.description, url: self.url, imageUrl: self.imageUrl)
    }
}

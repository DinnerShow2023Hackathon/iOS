//
//  BookRequestDto.swift
//  DinnerHack
//
//  Created by saint on 2023/04/30.
//

import Foundation

// MARK: - Welcome
struct BookRequestDto: Codable {
    let success: Bool
    let message, breed: String
}

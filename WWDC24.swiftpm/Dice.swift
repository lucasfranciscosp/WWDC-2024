//
//  Dice.swift
//  WWDC24
//
//  Created by Lucas Francisco on 31/01/24.
//

import SwiftUI

protocol Transferable {
    associatedtype Representation
}

struct Dice: Hashable, Transferable {
    typealias Representation = Dice
    
    let uuid = UUID()
    let image: [Image]
    let imageName: String
    let value: Int
    let team: String
//    var offsetX: CGFloat = 0 // Para rastrear a posição X do dado
//    var offsetY: CGFloat = 0 // Para rastrear a posição Y do dado

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}


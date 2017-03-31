//
//  DSTransitionAnimation.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 3/31/17.
//
//

import Foundation

protocol DSTransitionAnimation {
    var backgroundView: UIView { get }
    var contentView: UIView { get }
}

public enum Animation {
    case slide(direction: Direction, rotation: Bool)
    case fade
    
    public enum Direction: Int {
        case top
        case bottom
        case right
        case left
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
    }
}

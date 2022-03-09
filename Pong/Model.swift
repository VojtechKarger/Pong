//
//  Model.swift
//  Pong
//
//  Created by vojta on 05.03.2022.
//

import Foundation

struct Puck {
    var x: CGFloat
    var y: CGFloat
        
    var radius: CGFloat
}

struct Player {
    var x: CGFloat
    var y: CGFloat
    
    var dy: CGFloat = 0
    
    var score = 0
    
    let height: CGFloat
    let width:CGFloat
}

enum Start {
    case player1, player2
}

enum GameType {
    case playerVSbot, playerVSplayer
}

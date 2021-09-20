//
//  HelperFunc.swift
//  Soccer Wars
//
//  Created by Arman Zadeh-Attar on 2021-09-02.
//

import Foundation

func aiTurn(){
    ai -= 1
    dealt += 1
    self.number = Int.random(in: 0...self.players.count - 1)
}

func playerTurn(){
    self.dealt += 1
    self.player -= 1
    self.number = Int.random(in: 0...self.players.count - 1)
}

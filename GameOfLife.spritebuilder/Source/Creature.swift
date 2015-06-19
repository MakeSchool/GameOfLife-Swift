//
//  Creature.swift
//  GameOfLife
//
//  Created by Dion Larson on 1/19/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

class Creature: CCSprite {
  
  var isAlive: Bool = false {
    didSet {
      visible = isAlive
    }
  }
  
  var livingNeighborsCount = 0
  
  
  convenience override init() {
    self.init(imageNamed: "Assets/bubble.png")
    anchorPoint = CGPoint(x: 0, y: 0)
  }
  
}

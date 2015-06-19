//
//  MainScene.swift
//  GameOfLife
//
//  Created by Dion Larson on 1/19/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import Foundation

class MainScene: CCNode {
  
  weak var grid: Grid!
  weak var generationLabel: CCLabelTTF!
  weak var populationLabel: CCLabelTTF!
  var timer = CCTimer()
  
  func play() {
    schedule("step", interval: CCTime(0.5))
  }
  
  func pause() {
    unschedule("step")
  }
  
  func step() {
    grid.evolveStep()
    
    generationLabel.string = "\(grid.generation)"
    populationLabel.string = "\(grid.totalAlive)"
  }
  
}

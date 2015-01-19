//
//  MainScene.swift
//  GameOfLife
//
//  Created by Dion Larson on 1/19/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

import Foundation

class MainScene: CCNode {
  
  var grid: Grid!
  var generationLabel: CCLabelTTF!
  var populationLabel: CCLabelTTF!
  var timer = CCTimer()
  
  func play() {
    timer.invalidate()
    timer = scheduleBlock({ (timer) -> Void in
      self.step()
      self.play()
    }, delay: CCTime(0.5))
  }
  
  func pause() {
    timer.invalidate()
  }
  
  private func step() {
    grid.evolveStep()
    
    generationLabel.string = "\(grid.generation)"
    populationLabel.string = "\(grid.totalAlive)"
  }
  
}

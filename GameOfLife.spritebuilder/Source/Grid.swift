//
//  Grid.swift
//  GameOfLife
//
//  Created by Dion Larson on 1/19/15.
//  Copyright (c) 2015 MakeSchool. All rights reserved.
//

let GridRows = 8
let GridColumns = 10

class Grid: CCSprite {
  
  var totalAlive = 0
  var generation = 0
  
  private var cellWidth: CGFloat = 0
  private var cellHeight: CGFloat = 0
  private var gridArray: [[Creature]]!
  
  override func onEnter() {
    super.onEnter()
    
    setupGrid()
    userInteractionEnabled = true
  }
  
  private func setupGrid() {
    cellWidth = contentSize.width / CGFloat(GridColumns)
    cellHeight = contentSize.height / CGFloat(GridRows)
    
    gridArray = []
    
    for row in 0..<GridRows {
      
      gridArray.append([])
      
      for column in 0..<GridColumns {
        var creature = Creature()
        creature.position = CGPoint(x: cellWidth * CGFloat(column),
                                    y: cellHeight * CGFloat(row))
        addChild(creature)
        
        gridArray[row].append(creature)
        creature.isAlive = false
      }
    }
  }
  
  func evolveStep() {
    countNeighbors()
    updateCreatures()
    
    generation++
  }
  
  private func countNeighbors() {
    for row in 0..<gridArray.count {
      for column in 0..<gridArray[row].count {
        var currentCreature = gridArray[row][column]
        currentCreature.livingNeighborsCount = 0
        
        for x in (row-1)...(row+1) {
          for y in (column-1)...(column+1) {
            var validIndex = isValidIndex(x: x, y: y)
            
            if validIndex && !(x == row && y == column) {
              var neighbor = gridArray[x][y]
              if neighbor.isAlive {
                currentCreature.livingNeighborsCount++
              }
            }
          }
        }
      }
    }
  }
  
  private func updateCreatures() {
    totalAlive = 0
    for row in 0..<gridArray.count {
      for column in 0..<gridArray[row].count {
        var currentCreature = gridArray[row][column]
        let liveNeighbors = currentCreature.livingNeighborsCount
        if liveNeighbors == 3 {
          currentCreature.isAlive = true
        } else if liveNeighbors <= 1 || liveNeighbors >= 4 {
          currentCreature.isAlive = false
        }
        
        if currentCreature.isAlive {
          totalAlive++
        }
      }
    }
  }
  
  private func isValidIndex(#x: Int, y: Int) -> Bool {
    return !(x < 0 || y < 0 || x >= GridRows || y >= GridColumns)
  }
  
  override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
    var touchLocation = touch.locationInNode(self)
    
    var creature = creatureForTouchPosition(touchLocation)
    
    creature.isAlive = !creature.isAlive
  }
  
  private func creatureForTouchPosition(touchPosition: CGPoint) -> Creature {
    var row = Int(touchPosition.y / cellHeight)
    var column = Int(touchPosition.x / cellWidth)
    return gridArray[row][column]
  }
  
}

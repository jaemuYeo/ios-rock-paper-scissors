//
//  RockPaperScissors - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

enum RockPaperScissors: Int, CaseIterable {
    case scissors = 1
    case rock = 2
    case paper = 3
}

enum GameState: String {
    case win = "이겼습니다!"
    case lose = "졌습니다!"
    case draw = "비겼습니다!"
}

enum Player: CustomStringConvertible {
    case computer
    case user
    var description: String {
        switch self {
        case .user:
            return "사용자"
        case .computer:
            return "컴퓨터"
        }
    }
}

func printRockPaperScissorsMenu() {
    print("가위(1), 바위(2), 보(3)! <종료 : 0> : ", terminator: "")
}

func printMukjjipaMenu(winner: Player) {
    print("[\(winner.description) 턴] 묵(1), 찌(2), 빠(3)! <종료 : 0> : ", terminator: "")
}

func generateComputerValue() -> RockPaperScissors {
    guard let value = RockPaperScissors.allCases.randomElement() else {
        return generateComputerValue()
    }
    return value
}

func inputUserValue() -> RockPaperScissors? {
    guard let userNumber = readLine(), let convertedNumber = Int(userNumber) else {
        printError()
        return inputUserValue()
    }
    
    if convertedNumber == 0 {
        print("게임 종료")
        return nil
    }
    
    guard let userValue = RockPaperScissors(rawValue: convertedNumber) else {
        printError()
        return inputUserValue()
    }
    return userValue
}

func printWinner(winner: Player) {
    print("\(winner)의 승리!", terminator: "")
}

func printGameResult(gameResult: GameState) {
    print(gameResult.rawValue)
}

func compareValue(myValue: RockPaperScissors, otherValue: RockPaperScissors) -> GameState {
    switch (myValue, otherValue) {
    case (.rock, .rock):
        return .draw
    case (.rock, .paper):
        return .lose
    case (.rock, .scissors):
        return .win
        
    case (.paper, .rock):
        return .win
    case (.paper, .paper):
        return .draw
    case (.paper, .scissors):
        return .lose
        
    case (.scissors, .rock):
        return .lose
    case (.scissors, .paper):
        return .win
    case (.scissors, .scissors):
        return .draw
    }
}

func printError() {
    print("잘못된 입력입니다. 다시 시도해주세요")
}

func checkIsDraw(thisGameResult: GameState) -> Bool {
    if thisGameResult == .draw {
        return true
    } else {
        return false
    }
}

func printWhosTurn(wohsTurn: Player) {
    if wohsTurn == .computer {
        print("컴퓨터의 턴입니다 ", terminator: "")
    } else if wohsTurn == .user {
        print("사용자의 턴입니다 ", terminator: "")
    }
}

func compareWhosTurn(thisGameState: GameState) -> Player {
    if thisGameState == .lose {
        return .computer
    } else {
        return .user
    }
}

func startStageOne() {
    printRockPaperScissorsMenu()
    guard let userValue = inputUserValue() else {
        return
    }
    let thisGameResult = compareValue(myValue: userValue, otherValue: generateComputerValue())
    if checkIsDraw(thisGameResult: thisGameResult) {
        printGameResult(gameResult: thisGameResult)
        startStageOne()
    } else {
        printGameResult(gameResult: thisGameResult)
        startStageTwo(thisTurnPlayer: compareWhosTurn(thisGameState: thisGameResult))
    }
}

func startStageTwo(thisTurnPlayer: Player) {
    printMukjjipaMenu(winner: thisTurnPlayer)
    guard let userValue = inputUserValue() else {
        return
    }
    let thisGameResult = compareValue(myValue: userValue, otherValue: generateComputerValue())
    if checkIsDraw(thisGameResult: thisGameResult){
        printWinner(winner: thisTurnPlayer)
        return
    } else {
        print("\(compareWhosTurn(thisGameState: thisGameResult))의 턴입니다")
        startStageTwo(thisTurnPlayer: compareWhosTurn(thisGameState: thisGameResult))
    }
}

startStageOne()


//
//  OutcomeAnalystTests.swift
//  TicTacToe
//
//  Created by Joshua Smith on 11/28/15.
//  Copyright © 2015 iJoshSmith. All rights reserved.
//

import XCTest

class OutcomeAnalystTests: XCTestCase {

    // MARK: - checkForOutcome

    func test_checkForOutcome_emptyBoard_returnsNil() {
        let board = GameBoard(dimension: 3)
        let analyst = OutcomeAnalyst(gameBoard: board)
        XCTAssertNil(analyst.checkForOutcome())
    }
    
    func test_checkForOutcome_noWinnerYet_returnsNil() {
        let board = GameBoard(dimension: 3)
        board.marks = [
            [.Empty, .O,     .Empty],
            [.Empty, .Empty, .Empty],
            [.X,     .X,     .O    ]]
        let analyst = OutcomeAnalyst(gameBoard: board)
        XCTAssertNil(analyst.checkForOutcome())
    }
    
    func test_checkForOutcome_tied_returnsTiedAndNoWinningPositions() {
        let board = GameBoard(dimension: 3)
        board.marks = [
            [.O, .X, .O],
            [.X, .X, .O],
            [.O, .O, .X]]
        let analyst = OutcomeAnalyst(gameBoard: board)
        if let outcome = analyst.checkForOutcome() {
            XCTAssertEqual(outcome.winner, Winner.Tied)
            XCTAssertNil(outcome.winningPositions)
        }
        else {
            XCTFail("Tie was not detected.")
        }
    }
    
    func test_checkForOutcome_winningRowForX_returnsRowForPlayerX() {
        let board = GameBoard(dimension: 3)
        board.marks = [
            [.Empty, .Empty, .Empty],
            [.Empty, .Empty, .Empty],
            [.X,     .X,     .X    ]]
        let analyst = OutcomeAnalyst(gameBoard: board)
        if let outcome = analyst.checkForOutcome() {
            XCTAssertEqual(outcome.winner, Winner.PlayerX)
            
            if let positions = outcome.winningPositions {
                XCTAssertEqual(positions.count, 3)
                XCTAssertTrue(positions[0] == (row: 2, column: 0))
                XCTAssertTrue(positions[1] == (row: 2, column: 1))
                XCTAssertTrue(positions[2] == (row: 2, column: 2))
            }
            else {
                XCTFail("Winning positions are missing.")
            }
        }
        else {
            XCTFail("Winning row was not found.")
        }
    }
    
    func test_checkForOutcome_winningColumnForO_returnsColumnForPlayerO() {
        let board = GameBoard(dimension: 3)
        board.marks = [
            [.Empty, .O, .Empty],
            [.Empty, .O, .Empty],
            [.Empty, .O, .Empty]]
        let analyst = OutcomeAnalyst(gameBoard: board)
        if let outcome = analyst.checkForOutcome() {
            XCTAssertEqual(outcome.winner, Winner.PlayerO)
            
            if let positions = outcome.winningPositions {
                XCTAssertEqual(positions.count, 3)
                XCTAssertTrue(positions[0] == (row: 0, column: 1))
                XCTAssertTrue(positions[1] == (row: 1, column: 1))
                XCTAssertTrue(positions[2] == (row: 2, column: 1))
            }
            else {
                XCTFail("Winning positions are missing.")
            }
        }
        else {
            XCTFail("Winning column was not found.")
        }
    }
    
    func test_checkForOutcome_winningTopLeftToBottomRightDiagonalForX_returnsDiagonalForPlayerX() {
        let board = GameBoard(dimension: 3)
        board.marks = [
            [.X,     .Empty, .Empty],
            [.Empty, .X,     .Empty],
            [.Empty, .Empty, .X    ]]
        let analyst = OutcomeAnalyst(gameBoard: board)
        if let outcome = analyst.checkForOutcome() {
            XCTAssertEqual(outcome.winner, Winner.PlayerX)
            
            if let positions = outcome.winningPositions {
                XCTAssertEqual(positions.count, 3)
                XCTAssertTrue(positions[0] == (row: 0, column: 0))
                XCTAssertTrue(positions[1] == (row: 1, column: 1))
                XCTAssertTrue(positions[2] == (row: 2, column: 2))
            }
            else {
                XCTFail("Winning positions are missing.")
            }
        }
        else {
            XCTFail("Winning diagonal was not found.")
        }
    }
    
    func test_checkForOutcome_winningBottomLeftToTopRightDiagonalForO_returnsDiagonalForPlayerO() {
        let board = GameBoard(dimension: 3)
        board.marks = [
            [.Empty, .Empty, .O    ],
            [.Empty, .O,     .Empty],
            [.O,     .Empty, .Empty]]
        let analyst = OutcomeAnalyst(gameBoard: board)
        if let outcome = analyst.checkForOutcome() {
            XCTAssertEqual(outcome.winner, Winner.PlayerO)
            
            if let positions = outcome.winningPositions {
                XCTAssertEqual(positions.count, 3)
                XCTAssertTrue(positions[0] == (row: 2, column: 0))
                XCTAssertTrue(positions[1] == (row: 1, column: 1))
                XCTAssertTrue(positions[2] == (row: 0, column: 2))
            }
            else {
                XCTFail("Winning positions are missing.")
            }
        }
        else {
            XCTFail("Winning diagonal was not found.")
        }
    }
}

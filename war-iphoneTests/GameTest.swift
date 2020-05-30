import XCTest
@testable import war_iphone

class GameTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGameCreation() {
        let _ = Game()
    }
    
    func testGame_OneCardEach_Player1Wins() {
        let game = Game()
        let cards1 = [Card(rank: Rank.ace, suit: Suit.club)]
        let cards2 = [Card(rank: Rank.king, suit: Suit.club)]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .play)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .ace);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .king);
        XCTAssert(result1.player1.cards.count == 2);
        XCTAssert(result1.player2.cards.count == 0);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards)
        XCTAssert(result2.play == .end)
        XCTAssert(result2.player1.actions[0] == .winner)
        XCTAssert(result2.player2.actions[0] == .loser)
    }
    
    func testGame_OneCardEach_Player2Wins() {
        let game = Game()
        let cards1 = [Card(rank: Rank.king, suit: Suit.club)]
        let cards2 = [Card(rank: Rank.ace, suit: Suit.club)]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .play)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .king);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .ace);
        XCTAssert(result1.player1.cards.count == 0);
        XCTAssert(result1.player2.cards.count == 2);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards)
        XCTAssert(result2.play == .end)
        XCTAssert(result2.player1.actions[0] == .loser)
        XCTAssert(result2.player2.actions[0] == .winner)
    }
    
    func testGame_Tie_Player1Wins() {
        let game = Game()
        let cards1 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club),
        ]
        let cards2 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.jack, suit: Suit.club),
        ]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .tie)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .king);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .king);
        XCTAssert(result1.player1.cards.count == 4);
        XCTAssert(result1.player2.cards.count == 4);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards, result1.tieCards)
        XCTAssert(result2.play == .play)
        XCTAssert(result2.player1.actions[3] == .showcardup);
        XCTAssert(result2.player1.cardsToShow[3].rank == .ace);
        XCTAssert(result2.player2.actions[3] == .showcardup);
        XCTAssert(result2.player2.cardsToShow[3].rank == .jack);
        XCTAssert(result2.player1.cards.count == 10);
        XCTAssert(result2.player2.cards.count == 0);
        
        let result3 = game.play(result2.player1.cards, result2.player2.cards)
        XCTAssert(result3.play == .end)
        XCTAssert(result3.player1.actions[0] == .winner)
        XCTAssert(result3.player2.actions[0] == .loser)
    }
    
    func testGame_Tie_Player2Wins() {
        let game = Game()
        let cards1 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.jack, suit: Suit.club),
        ]
        let cards2 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club),
        ]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .tie)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .king);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .king);
        XCTAssert(result1.player1.cards.count == 4);
        XCTAssert(result1.player2.cards.count == 4);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards, result1.tieCards)
        XCTAssert(result2.play == .play)
        XCTAssert(result2.player1.actions[3] == .showcardup);
        XCTAssert(result2.player1.cardsToShow[3].rank == .jack);
        XCTAssert(result2.player2.actions[3] == .showcardup);
        XCTAssert(result2.player2.cardsToShow[3].rank == .ace);
        XCTAssert(result2.player1.cards.count == 0);
        XCTAssert(result2.player2.cards.count == 10);
        
        let result3 = game.play(result2.player1.cards, result2.player2.cards)
        XCTAssert(result3.play == .end)
        XCTAssert(result3.player1.actions[0] == .loser)
        XCTAssert(result3.player2.actions[0] == .winner)
    }
    
    func testGame_MultipleTies_Player1Wins() {
        let game = Game()
        let cards1 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.queen, suit: Suit.club),
        ]
        let cards2 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.jack, suit: Suit.club),
        ]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .tie)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .king);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .king);
        XCTAssert(result1.player1.cards.count == 8);
        XCTAssert(result1.player2.cards.count == 8);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards, result1.tieCards)
        XCTAssert(result2.play == .tie)
        XCTAssert(result2.player1.actions[3] == .showcardup);
        XCTAssert(result2.player1.cardsToShow[3].rank == .ace);
        XCTAssert(result2.player2.actions[3] == .showcardup);
        XCTAssert(result2.player2.cardsToShow[3].rank == .ace);
        XCTAssert(result2.player1.cards.count == 4);
        XCTAssert(result2.player2.cards.count == 4);
        
        let result3 = game.play(result2.player1.cards, result2.player2.cards, result2.tieCards)
        XCTAssert(result3.play == .play)
        XCTAssert(result3.player1.actions[3] == .showcardup);
        XCTAssert(result3.player1.cardsToShow[3].rank == .queen);
        XCTAssert(result3.player2.actions[3] == .showcardup);
        XCTAssert(result3.player2.cardsToShow[3].rank == .jack);
        XCTAssert(result3.player1.cards.count == 18);
        XCTAssert(result3.player2.cards.count == 0);
        
        let result4 = game.play(result3.player1.cards, result3.player2.cards)
        XCTAssert(result4.play == .end)
        XCTAssert(result4.player1.actions[0] == .winner)
        XCTAssert(result4.player2.actions[0] == .loser)
    }
    
    func testGame_TiePlayer1RunsOutOfCards_Player1Loses() {
        let game = Game()
        let cards1 = [
            Card(rank: Rank.king, suit: Suit.club), // tie
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club), // tie
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club), // lose
        ]
        let cards2 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.jack, suit: Suit.club),
        ]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .tie)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .king);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .king);
        XCTAssert(result1.player1.cards.count == 6);
        XCTAssert(result1.player2.cards.count == 8);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards, result1.tieCards)
        XCTAssert(result2.play == .tie)
        XCTAssert(result2.player1.actions[3] == .showcardup);
        XCTAssert(result2.player1.cardsToShow[3].rank == .ace);
        XCTAssert(result2.player2.actions[3] == .showcardup);
        XCTAssert(result2.player2.cardsToShow[3].rank == .ace);
        XCTAssert(result2.player1.cards.count == 2);
        XCTAssert(result2.player2.cards.count == 4);
        
        let result3 = game.play(result2.player1.cards, result2.player2.cards, result2.tieCards)
        XCTAssert(result3.play == .play)
        XCTAssert(result3.player1.actions[1] == .showcardup);
        XCTAssert(result3.player1.cardsToShow[1].rank == .three);
        XCTAssert(result3.player2.actions[3] == .showcardup);
        XCTAssert(result3.player2.cardsToShow[3].rank == .jack);
        XCTAssert(result3.player1.cards.count == 0);
        XCTAssert(result3.player2.cards.count == 16);
        
        let result4 = game.play(result3.player1.cards, result3.player2.cards)
        XCTAssert(result4.play == .end)
        XCTAssert(result4.player1.actions[0] == .loser)
        XCTAssert(result4.player2.actions[0] == .winner)
    }
    
    func testGame_TiePlayer2RunsOutOfCards_Player2Loses() {
        let game = Game()
        let cards1 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.jack, suit: Suit.club),
        ]
        let cards2 = [
            Card(rank: Rank.king, suit: Suit.club), // tie
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
            Card(rank: Rank.four, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club), // tie
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club), // lose
        ]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .tie)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .king);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .king);
        XCTAssert(result1.player1.cards.count == 8);
        XCTAssert(result1.player2.cards.count == 6);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards, result1.tieCards)
        XCTAssert(result2.play == .tie)
        XCTAssert(result2.player1.actions[3] == .showcardup);
        XCTAssert(result2.player1.cardsToShow[3].rank == .ace);
        XCTAssert(result2.player2.actions[3] == .showcardup);
        XCTAssert(result2.player2.cardsToShow[3].rank == .ace);
        XCTAssert(result2.player1.cards.count == 4);
        XCTAssert(result2.player2.cards.count == 2);
        
        let result3 = game.play(result2.player1.cards, result2.player2.cards, result2.tieCards)
        XCTAssert(result3.play == .play)
        XCTAssert(result3.player1.actions[3] == .showcardup);
        XCTAssert(result3.player1.cardsToShow[3].rank == .jack);
        XCTAssert(result3.player2.actions[1] == .showcardup);
        XCTAssert(result3.player2.cardsToShow[1].rank == .three);
        XCTAssert(result3.player1.cards.count == 16);
        XCTAssert(result3.player2.cards.count == 0);
        
        let result4 = game.play(result3.player1.cards, result3.player2.cards)
        XCTAssert(result4.play == .end)
        XCTAssert(result4.player1.actions[0] == .winner)
        XCTAssert(result4.player2.actions[0] == .loser)
    }
    
    func testGame_UnEvenCardsPlayer2OutOfCards_Player2Loses() {
        let game = Game()
        let cards1 = [
            Card(rank: Rank.king, suit: Suit.club), // win
            Card(rank: Rank.eight, suit: Suit.club), // win
            Card(rank: Rank.nine, suit: Suit.club), // win game
            Card(rank: Rank.ten, suit: Suit.club),
        ]
        let cards2 = [
            Card(rank: Rank.queen, suit: Suit.club),
            Card(rank: Rank.two, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
        ]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .play)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .king);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .queen);
        XCTAssert(result1.player1.cards.count == 5);
        XCTAssert(result1.player2.cards.count == 2);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards)
        XCTAssert(result2.play == .play)
        XCTAssert(result2.player1.actions[0] == .showcardup);
        XCTAssert(result2.player1.cardsToShow[0].rank == .eight);
        XCTAssert(result2.player2.actions[0] == .showcardup);
        XCTAssert(result2.player2.cardsToShow[0].rank == .two);
        XCTAssert(result2.player1.cards.count == 6);
        XCTAssert(result2.player2.cards.count == 1);
        
        let result3 = game.play(result2.player1.cards, result2.player2.cards)
        XCTAssert(result3.play == .play)
        XCTAssert(result3.player1.actions[0] == .showcardup);
        XCTAssert(result3.player1.cardsToShow[0].rank == .nine);
        XCTAssert(result3.player2.actions[0] == .showcardup);
        XCTAssert(result3.player2.cardsToShow[0].rank == .three);
        XCTAssert(result3.player1.cards.count == 7);
        XCTAssert(result3.player2.cards.count == 0);
        
        let result4 = game.play(result3.player1.cards, result3.player2.cards)
        XCTAssert(result4.play == .end)
        XCTAssert(result4.player1.actions[0] == .winner)
        XCTAssert(result4.player2.actions[0] == .loser)
    }
    
    func testGame_lastCardForPlayer1IsTie_ThenPlayer1Loses() {
        let game = Game()
        let cards1 = [
            Card(rank: Rank.king, suit: Suit.club), // tie
        ]
        let cards2 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
        ]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .tie)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .king);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .king);
        XCTAssert(result1.player1.cards.count == 1);
        XCTAssert(result1.player2.cards.count == 3);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards)
        XCTAssert(result2.play == .play)
        XCTAssert(result2.player1.actions[0] == .showcardup);
        XCTAssert(result2.player1.cardsToShow[0].rank == .king);
        XCTAssert(result2.player2.actions[0] == .showcardup);
        XCTAssert(result2.player2.cardsToShow[0].rank == .ace);
        XCTAssert(result2.player1.cards.count == 0);
        XCTAssert(result2.player2.cards.count == 4);
        
        let result3 = game.play(result2.player1.cards, result2.player2.cards)
        XCTAssert(result3.play == .end)
        XCTAssert(result3.player1.actions[0] == .loser)
        XCTAssert(result3.player2.actions[0] == .winner)
    }
    
    func testGame_lastCardForPlayer2IsTie_ThenPlayer2Loses() {
        let game = Game()
        let cards1 = [
            Card(rank: Rank.king, suit: Suit.club),
            Card(rank: Rank.ace, suit: Suit.club),
            Card(rank: Rank.three, suit: Suit.club),
        ]
        let cards2 = [
            Card(rank: Rank.king, suit: Suit.club), // tie
        ]
        
        let result1 = game.play(cards1, cards2)
        XCTAssert(result1.play == .tie)
        XCTAssert(result1.player1.actions[0] == .showcardup);
        XCTAssert(result1.player1.cardsToShow[0].rank == .king);
        XCTAssert(result1.player2.actions[0] == .showcardup);
        XCTAssert(result1.player2.cardsToShow[0].rank == .king);
        XCTAssert(result1.player1.cards.count == 3);
        XCTAssert(result1.player2.cards.count == 1);
        
        let result2 = game.play(result1.player1.cards, result1.player2.cards)
        XCTAssert(result2.play == .play)
        XCTAssert(result2.player1.actions[0] == .showcardup);
        XCTAssert(result2.player1.cardsToShow[0].rank == .ace);
        XCTAssert(result2.player2.actions[0] == .showcardup);
        XCTAssert(result2.player2.cardsToShow[0].rank == .king);
        XCTAssert(result2.player1.cards.count == 4);
        XCTAssert(result2.player2.cards.count == 0);
        
        let result3 = game.play(result2.player1.cards, result2.player2.cards)
        XCTAssert(result3.play == .end)
        XCTAssert(result3.player1.actions[0] == .winner)
        XCTAssert(result3.player2.actions[0] == .loser)
    }
}

import Foundation

enum Action {
    case winner
    case loser
    case showcardup
    case showcarddown
    case play
    case end
    case tie
    case none
}

class Player {
    var actions = [Action]()
    var cardsToShow = [Card]()
    var cards = [Card]()
}

class GameResult {
    var play: Action = .none
    let player1 = Player()
    let player2 = Player()
    var tieCards = [Card]()
}

enum CompareResult {
    case card1
    case card2
    case equal
}

class Game {
    
    func compare(card1: Card, card2: Card) -> CompareResult {
        if(card1.getValue() > card2.getValue()) {
            return .card1
        }
        if(card2.getValue() < card2.getValue()) {
            return .card2
        }
        return .equal
    }
    
    func play(_ inCards1: [Card], _ inCards2: [Card], _ tieCards: [Card]?=nil) -> GameResult {
        let result = GameResult()
        if(inCards2.count == 0) {
            result.player1.actions.append(.winner)
            result.player2.actions.append(.loser)
            result.play = .end
            return result
        }
        if(inCards1.count == 0) {
            result.player1.actions.append(.loser)
            result.player2.actions.append(.winner)
            result.play = .end
            return result
        }
        var cards1 = inCards1
        var cards2 = inCards2
        
        if(tieCards != nil) {
            let cards1Size = cards1.count >= 3 ? 3 : cards1.count - 1
            for _ in 0..<cards1Size {
                result.player1.cardsToShow.append(cards1.removeFirst())
                result.player1.actions.append(.showcarddown)
            }
            result.player1.cardsToShow.append(cards1.removeFirst())
            result.player1.actions.append(.showcardup)
            
            let cards2Size = cards2.count >= 3 ? 3 : cards2.count - 1
            for _ in 0..<cards2Size {
                result.player2.cardsToShow.append(cards2.removeFirst())
                result.player2.actions.append(.showcarddown)
            }
            result.player2.cardsToShow.append(cards2.removeFirst())
            result.player2.actions.append(.showcardup)
            
            if(result.player1.cardsToShow.last!.getValue() > result.player2.cardsToShow.last!.getValue()) {
                result.player1.cards += cards1
                result.player2.cards += cards2
                result.player1.cards += result.player1.cardsToShow
                result.player1.cards += result.player2.cardsToShow
                result.player1.cards += tieCards!
                result.play = .play
            } else if(result.player1.cardsToShow.last!.getValue() < result.player2.cardsToShow.last!.getValue()) {
                result.player1.cards += cards1
                result.player2.cards += cards2
                result.player2.cards += result.player1.cardsToShow
                result.player2.cards += result.player2.cardsToShow
                result.player2.cards += tieCards!
                result.play = .play
            } else {
                result.play = .tie
                result.player1.cards += cards1
                result.player2.cards += cards2
                result.tieCards += tieCards!
                result.tieCards += result.player1.cardsToShow
                result.tieCards += result.player2.cardsToShow
            }
            return result
        }
        
        let card1 = cards1.removeFirst()
        let card2 = cards2.removeFirst()
        if(card1.getValue() > card2.getValue()) {
            result.play = .play
            result.player1.actions.append(.showcardup)
            result.player2.actions.append(.showcardup)
            result.player1.cardsToShow.append(card1)
            result.player2.cardsToShow.append(card2)
            result.player1.cards += cards1
            result.player1.cards += [card1]
            result.player1.cards += [card2]
            result.player2.cards += cards2
        } else if(card1.getValue() < card2.getValue()) {
            result.play = .play
            result.player1.actions.append(.showcardup)
            result.player2.actions.append(.showcardup)
            result.player1.cardsToShow.append(card1)
            result.player2.cardsToShow.append(card2)
            result.player2.cards += cards2
            result.player2.cards += [card1]
            result.player2.cards += [card2]
            result.player1.cards += cards1
        } else {
            result.play = .tie
            result.player1.actions.append(.showcardup)
            result.player2.actions.append(.showcardup)
            result.player1.cardsToShow.append(card1)
            result.player2.cardsToShow.append(card2)
            result.player1.cards = cards1
            result.player2.cards = cards2
            result.tieCards = [card1, card2]
        }
        return result
    }
}

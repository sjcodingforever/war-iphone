import Foundation

class Deck {
    var cards = [Card]()
    var index: Int
    
    init() {
        for r in Rank.allCases {
            for s in Suit.allCases {
                cards.append(Card(rank: r, suit: s, faceUp: false))
            }
        }
        index = 0
    }
    
    func shuffle() {
        cards.shuffle()
        index = 0
    }
    
    func getCard() -> Card? {
        if index == cards.count - 1 {
            return nil
        }
        let c = cards[index]
        index += 1
        return c
    }
}

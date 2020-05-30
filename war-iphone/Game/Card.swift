import Foundation

enum Rank : Int, CaseIterable {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
    case ace = 14
    
    func toShortString() -> String {
        switch self {
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ten: return "T"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        case .ace: return "A"
        }
    }
    
    func toLongString() -> String {
        switch self {
        case .two: return "two"
        case .three: return "three"
        case .four: return "four"
        case .five: return "five"
        case .six: return "six"
        case .seven: return "seven"
        case .eight: return "eight"
        case .nine: return "nine"
        case .ten: return "ten"
        case .jack: return "jack"
        case .queen: return "queen"
        case .king: return "king"
        case .ace: return "ace"
        }
    }
}

enum Suit : String, CaseIterable {
    case club = "club"
    case diamond = "diamond"
    case heart = "heart"
    case spade = "spade"
    
    func toLongString() -> String {
        return self.rawValue
    }
    
    func toShortString() -> String {
        switch self {
        case .club: return "C"
        case .diamond: return "D"
        case .heart: return "H"
        case .spade: return "S"
        }
    }
}


class Card {
    let rank: Rank
    let suit: Suit
    var faceUp: Bool
    
    init(rank: Rank, suit: Suit, faceUp: Bool = true) {
        self.rank = rank
        self.suit = suit
        self.faceUp = faceUp
    }
    
    func toShortString() -> String {
        return "\(self.rank.toShortString())\(self.suit.toShortString())"
    }
    
    func toLongString() -> String {
         return "\(self.rank.toLongString()) of \(self.suit.toLongString())s"
     }
    
    func getValue() -> Int {
        return rank.rawValue
    }
}

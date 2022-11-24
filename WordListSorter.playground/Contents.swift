import Foundation

let text = """

PRIME_MERIDIAN
WHILE_SLEEPING
FLEETING_THOUGHT
NOT MANY_OPTIONS
ILL_PREPARED
PRIME_MERIDIAN
WHILE_SLEEPING
FLEETING_THOUGHT
NOT MANY_OPTIONS
ILL PREPARED
PRIME MERIDIAN
WHILE_SLEEPING
FLEETING_THOUGHT
NOT MANY_OPTIONS
ILL_PREPARED
TRACKING_DEVICE
FOREIGN_WORKER
LIQUID_PLUMBER
TOUGHEN_UP
INTENSE_ANIMAL
BAD_FEELING
SCRATCH_SNIFF
PENALTY_BOX
ON YOUR_KNEES
PEOPLE_CLOTHES
DOG_CLOTHES
ABUSIVE_FATHER
ABUSIVE_PARENTS
GARBAGE_DUMP
DEFLATE
THERMAL
RANSACK
CRYPTIC
EQUATOR
HYDRATE
PENALTY
BLAMING
BARGAIN
FENCING
COURAGE
MINDFUL
YAPPING
BLOATED
JOINED
BARREL
RUMBLE
ATTACH
RUBBER
ROTATE
ENERGY
TAMPER
JUMBLE
GLIDER
SLIDER
INSANE
TONGUE
NEARLY
SURVEY
AFRAID
SAVORY
JARGON
MIXED
STRAW
THUMB
GLARE
STRAY
HAVOC
BENDY
MOIST
SCALP
EYE_CONTACT
NUCLEAR_SUB
MISSILE_SILO
SOCIAL_MANDATE
CONTROL_FREAK
SANTA_COSTUME
LOTS OF_OPTIONS
ON_ECSTASY
FITTING_IN
MARTINI_GLASS
MARRIED_COUPLES
TIMELY_FASHION
STAMPED_OUT
DENTAL_FLOSS
NIGHT_SCHOOL
BROKEN_GLASS
NOTE_WORTHY
LEFT_HANDED
COUPON_BOOK
SHIFT_CHANGE
MULTI_PLAYER
BUBBLE_GUM
ALMOST_THERE
GET_ENOUGH
GRAND_CANYON
LIKE_MINDED
BETTER_CHOICE
DARK_TUNNEL
DEEP_BREATH
SAW IT_COMING
WINE_BOTTLE
PORNO_FLICK
DRAMA_QUEEN
RED_NECKS
TOOTH_PASTE
BREAK_FREE
RIGHT_SIDE
GLASS_HOUSE
GREEN_HOUSE
STRAY_DOG
FIBER_OPTIC
GLUE_STICK
TWO_HANDS
BOTH_HANDS
CYBER_BULLY
SWORD_FIGHT
SPEAK_OUT
CHALK_BOARD
MAKES_SENSE
TRASH_HEAP
PARTY_LINES
MUCH_WORSE
STARE_DOWN
CHICK_FLICK
BAD_MOVIE
CHAIR_POSE
MALL_SANTA
QUICK_NAP
GOOD_STUFF
GOOD STAFF
GOOD HA FF
NICE_GUY
BAD_BOYS
STAR_DUST
TYPE_OF
SAFE_DRUG
MELT_DOWN
MAIL_BOX
DEEP_FAKE
BEND_ABLE
BIKE_PATH
ONE_HAND
KIDS_MEAL
LAND_FILL
BUGS_ME
TACO_BOWL
SAD_PART
STEP_UP
YOGA_POSE
FLIP_OUT
HIGH_NOON
DEFLATE
THERMAL
RANSACK
CRYPTIC
EQUATOR
HYDRATE
PENALTY
BLAMING
BARGAIN
FENCING
COURAGE
MINDFUL
YAPPING
BLOATED
JOINED
BARREL
RUMBLE
ATTACH
RUBBER
ROTATE
ENERGY
TAMPER
JUMBLE
GLIDER
SLIDER
INSANE
TONGUE
NEARLY
SURVEY
AFRAID
SAVORY
JARGON
MIXED
STRAW
THUMB
GLARE
STRAY
HAVOC
BENDY
MOIST
SCALP
OVER_DOSE
ONE_ARM
ENLIGHTENED
CONFIDENCE
SURROUNDED
PRIORITIZE
INTENSITY
COMMUNITY
SEPARATE
COMBINED
ATTACHED
DEFLATED
ENERGIZE
UNLOCKED
PRIORITY
TROPICAL
WHISKERS
MULTIPLE
MOISTURE
KNEELING
COMMUNAL
OFFENDED
TROUBLE
SALVAGE
APPLIED
COUPONS

KAYAK
CANOE
GLIDE
SLIDE
KNEEL
BLAME
SURGE
USAGE
BARGAIN
FENCING
COURAGE
MINDFUL
YAPPING
BLOATED
JOINED
BARREL
RUMBLE
ATTACH
RUBBER
ROTATE
ENERGY
TANGY
PATCH
CRUD
PUNK
DOME
RAIL
SOFA
TUBE
"""

let _lines = text.split(separator: "\n")
    .map {
        $0
            .uppercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
}.filter {
    $0
        .count > 0
}

var lines = [[String]]()
var set = Set<[String]>()
for line in _lines {
    var words = [String]()
    
    let splitOnSpace = line.split(separator: " ")
    for checkWord in splitOnSpace {
        let innerWords = checkWord.split(separator: "_")
        for innerWord in innerWords {
            let word = innerWord.trimmingCharacters(in: .whitespacesAndNewlines)
            if word.count > 0 {
                words.append(word)
            }
        }
    }
    if words.count > 0 {
        if !set.contains(words) {
            lines.append(words)
            set.insert(words)
        }
    }
}

enum Bit: CustomStringConvertible {
    
    case oneLine(word: String)
    case twoLine(line1: [String], line2: [String])
    
    func isOneLiner() -> Bool {
        switch self {
        case .oneLine:
            return true
        case .twoLine:
            return false
        }
    }
    
    func line1Count() -> Int {
        switch self {
        case .oneLine(let word):
            return word.count
        case .twoLine(let line1, _):
            var result = line1.reduce(0) {
                $0 + $1.count
            }
            if line1.count > 1 {
                result += (line1.count - 1)
            }
            return result
        }
    }
    
    func line2Count() -> Int {
        switch self {
        case .oneLine:
            return 0
        case .twoLine(_ , let line2):
            var result = line2.reduce(0) {
                $0 + $1.count
            }
            if line2.count > 1 {
                result += (line2.count - 1)
            }
            return result
        }
    }
    
    func line1() -> String {
        switch self {
        case .oneLine(let word):
            return word
        case .twoLine(let line1, _):
            let result = line1.joined(separator: " ")
            return result
        }
    }
    
    func line2() -> String {
        switch self {
        case .oneLine:
            return ""
        case .twoLine(_, let line2):
            let result = line2.joined(separator: " ")
            return result
        }
    }
    
    var description: String {
        if isOneLiner() {
            return line1()
        } else {
            return "\(line1())_\(line2())"
        }
    }
}

var bits = [Bit]()

for line in lines {
    if line.count <= 0 {
        
    } else if line.count <= 1 {
        bits.append(Bit.oneLine(word: line[0]))
    } else {
        var bestConfigurationLine1 = [String]()
        var bestConfigurationLine2 = [String]()
        bestConfigurationLine1.append(line[0])
        for i in 1..<line.count { bestConfigurationLine2.append(line[i]) }
        let count1 = bestConfigurationLine1.reduce(0) { $0 + $1.count }
        let count2 = bestConfigurationLine2.reduce(0) { $0 + $1.count }
        var bestDiff = abs(count1 - count2)
        
        var splitIndex = 2
        while splitIndex < line.count {
            
            var checkConfigurationLine1 = [String]()
            var checkConfigurationLine2 = [String]()
            for i in 0..<splitIndex { checkConfigurationLine1.append(line[i]) }
            for i in splitIndex..<line.count { checkConfigurationLine2.append(line[i]) }
            let count1 = checkConfigurationLine1.reduce(0) { $0 + $1.count }
            let count2 = checkConfigurationLine2.reduce(0) { $0 + $1.count }
            let checkDiff = abs(count1 - count2)
            if checkDiff < bestDiff {
                bestDiff = checkDiff
                bestConfigurationLine1 = checkConfigurationLine1
                bestConfigurationLine2 = checkConfigurationLine2
            }
            splitIndex += 1
        }
        bits.append(Bit.twoLine(line1: bestConfigurationLine1, line2: bestConfigurationLine2))
    }
}

bits.sort { (lhs: Bit, rhs: Bit) in
    if !lhs.isOneLiner() {
        if !rhs.isOneLiner() {
            let countLHS = max(lhs.line1Count(), lhs.line2Count())
            let countRHS = max(rhs.line1Count(), rhs.line2Count())
            if countLHS == countRHS {
                let lhsLine1 = lhs.line1()
                let rhsLine1 = rhs.line1()
                if lhsLine1 == rhsLine1 {
                    let lhsLine2 = lhs.line2()
                    let rhsLine2 = rhs.line2()
                    if lhsLine2.count == rhsLine2.count {
                        return lhsLine2 > rhsLine2
                    } else {
                        return lhsLine2.count > rhsLine2.count
                    }
                } else {
                    return lhsLine1 > rhsLine1
                }
            } else {
                return countLHS > countRHS
            }
        } else {
            return true
        }
        
    } else if !rhs.isOneLiner() {
        return false
    } else {
        let lhsCount = lhs.line1Count()
        let rhsCount = rhs.line1Count()
        if lhsCount == rhsCount {
            return lhs.line1() > rhs.line1()
        } else {
            return lhs.line1Count() > rhs.line1Count()
        }
    }
}

for bit in bits {
    print(bit)
}

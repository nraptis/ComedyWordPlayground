import Foundation

let text = """

FAVORITE POSITION
TROUBLE
PORNO FLICK
NICE GUY
BAD BOYS
HALLOWEEN COSTUME
INDIGINOUS PEOPLE
TROPICAL FRUIT
TENSE SITUATION
DRAMA QUEEN
RED NECKS
IMMIGRANT FAMILIES
IMMIGRANT WORKERS
FOREIGN WORKER
CONFIDENCE
LIQUID PLUMBER
TOOTH PASTE
DENTAL FLOSS
Night school
Separate
Joined
Combined
Mixed
Crud
Straw
Barrel
Salvage
Thumb
OVER WHELMING
TREATMENT PLAN
GLARE
STAR DUST
BREAK FREE
BROKEN GLASS
TOUGHEN UP
MYTHICAL CREATURES
NOTE WORTHY
SPORTS COMMENTS
Surrounded
Rumble
Right side
Left handed
Applied
Coupon book
Coupons
Attach
Attached
Type of
Safe drug
Crickets singing
Intensity
Intense animal
Bad feeling
Deflated
Deflate
Rubber
Melt down
Glass house
Green house
Mail box
Rotate
Shift change
Stray Dog
Stray
Energize
Energy
Thermal
Tamper
Fiber Optic
Glue Stick
Scratch Sniff
Ransack
Unlocked
Havoc
Cryptic
Priority
Prioritize
Odd behavior
Deep fake
Punk
Tropical fruit
Tropical
Equator
Prime meridian
Whiskers
Jumble
Bendy
Bend Able
Hydrate
Multiple
Multi Player
Moist
Moisture
Scalp
Bubble Gum
Enlightened
Community
Kayak
Canoe
Glide
Glider
Slide
Slider
Dome
Botanical Gardens
Bike Path
Penalty
Penalty Box
Rail
One arm
Two hands
Both hands
One hand
Kneel
Kneeling
On your knees
People clothes
Dog clothes
Insane
Cyber Bully
Blane
Blaming
Tongue
Sofa
Bargain
Sword Fight
Fencing
Nearly
Almost There
Disruptive behavior
Speak out
Chalk board
Kids meal
Surge
Survey
Get enough
Makes sense
Afraid
While sleeping
Abusive father
Abusive parents
Grand Canyon
Land fill
Garbage dump
Trash heap
Party Lines
Didn't understand
Bugs me
Taco Bowl
Much worse
Eye contact
Stare down
Nuclear sub
Missile silo
Sad part
Like minded
Step Up
Social mandate
Chick flick
Bad movie
Better choice
Dark tunnel
Recurring image
Recurring dream
Control freak
Courage
Mindful
Usage
Deep breath
Chair pose
Yoga pose
Fleeting thought
Mall santa
Santa costume
Haunted by failure
Quick nap
Lots of options
Not many options
Good stuff
On ecstasy
Saw it coming
Flip out
Fitting in
Martini glass
Communal
Anti Depressants
Yapping
Wine bottle
Married couples
Offended
Timely fashion
Bloated
Ill prepared
No questions asked
Tracking device
Savory
Tangy
No distractions
Patch
High Noon
Tube
Infra structure
Stamped Out
Jargon
Over Dose
"""

let lines = text.split(separator: "\n")
    .map {
        $0
            .uppercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
}.filter {
    $0
        .count > 0
}.map {
    $0.split(separator: " ")
        .map {
            $0
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
        .filter {
            $0.count > 0
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
            return countLHS > countRHS
        } else {
            return true
        }
        
    } else if !rhs.isOneLiner() {
        return false
    } else {
        return lhs.line1Count() > rhs.line1Count()
    }
}

for bit in bits {
    print(bit)
}

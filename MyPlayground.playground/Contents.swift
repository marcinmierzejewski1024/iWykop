import UIKit



extension NSRegularExpression {

    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            print("Illegal regular expression: \(pattern).")

            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }


    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

var greeting = "Hello, playground"


//<a\shref=\"([^\"]*?)\">(.*?)<\/a>


let ahrefRegex = "<a\\shref=\\\"([^\\\"]*?)\\\">(.*?)<\\/a>"


let regex = try NSRegularExpression(pattern: ahrefRegex,options: [.caseInsensitive])

//print(regex)

let haystack = "poczatek <a href=\"#w\">#aa</a> <a href=\"www.wykop.pl\">aa</a>w inny tekst"
let mutableString = NSMutableString(string: haystack)

let range = NSRange(location: 0, length: haystack.utf16.count)
var matches = regex.matches(in: String(mutableString), options: [], range: range)


while let match = matches.first {
    let rangeUrl = (match.range(at: 1))
    let rangeName = (match.range(at: 2))
    
//    haystack.substring(from: rangeUrl)
    
    print(match)
    let foundBlock = mutableString.substring(with: match.range)
    let url = mutableString.substring(with: rangeUrl)
    let name = mutableString.substring(with: rangeName)


    mutableString.replaceOccurrences(of: foundBlock, with: "[\(name)](\(url))", options: [], range: match.range)
    let asString = String(mutableString);
    print(asString)
    let newRange = NSRange(location: 0, length: asString.utf16.count)

    matches = regex.matches(in: asString, options: [], range: newRange)
}

print(mutableString)

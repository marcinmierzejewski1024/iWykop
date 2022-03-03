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

print(regex)

let haystack = "poczatek <a href=\"#w\">#aa</a> <a href=\"www.wykop.pl\">aa</a>w inna trest"
var haystackCopy = haystack;

let range = NSRange(location: 0, length: haystack.utf16.count)
let matches = regex.matches(in: haystack, options: [], range: range)

for match in matches {
    let rangeUrl = (match.range(at: 0))
    let rangeName = (match.range(at: 1))
    
//    haystack.substring(from: rangeUrl)

//    haystackCopy.replaceSubrange(match.range, with: <#T##Collection#>)
//    haystackCopy.replaceSubrange(match.range, with: "tu markdownowy link".map({ c in
//        return String(c)
//    }))
}

print(haystackCopy)

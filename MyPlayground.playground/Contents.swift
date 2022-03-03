import UIKit


//
//extension NSRegularExpression {
//
//    convenience init(_ pattern: String) {
//        do {
//            try self.init(pattern: pattern)
//        } catch {
//            print("Illegal regular expression: \(pattern).")
//
//            preconditionFailure("Illegal regular expression: \(pattern).")
//        }
//    }
//
//
//    func matches(_ string: String) -> Bool {
//        let range = NSRange(location: 0, length: string.utf16.count)
//        return firstMatch(in: string, options: [], range: range) != nil
//    }
//}

//var greeting = "Hello, playground"


//<a\shref=\"([^\"]*?)\">(.*?)<\/a>


func replaceLinks(html: String) -> String {
    let ahrefRegex = "<a\\shref=\\\"([^\\\"]*?)\\\">(.*?)<\\/a>"
    do {
        let regex = try NSRegularExpression(pattern: ahrefRegex,options: [.caseInsensitive])
        
        let mutableString = NSMutableString(string: html)
        
        let range = NSRange(location: 0, length: html.utf16.count)
        var matches = regex.matches(in: String(mutableString), options: [], range: range)
        
        
        while let match = matches.first {
            
            if match.numberOfRanges >= 2 {
                let rangeName = (match.range(at: 2))
                let rangeUrl = (match.range(at: 1))
                
                let foundBlock = mutableString.substring(with: match.range)
                let url = mutableString.substring(with: rangeUrl)
                let name = mutableString.substring(with: rangeName)
                
                
                mutableString.replaceOccurrences(of: foundBlock, with: "[\(name)](\(url))", options: [], range: match.range)
                let asString = String(mutableString);
                let newRange = NSRange(location: 0, length: asString.utf16.count)
                
                matches = regex.matches(in: asString, options: [], range: newRange)
            }
        }
        
        return String(mutableString);
    } catch {
        return html;
    }
    
}

let haystack = "poczatek <a href=\"#w\">#aa</a> <a href=\"www.wykop.pl\">aa</a>w inny tekst"

print(replaceLinks(html: haystack))

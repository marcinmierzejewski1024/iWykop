//
//  String.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 17/02/2022.
//

import Foundation
import CryptoKit


extension String: LocalizedError {
    public var errorDescription: String? { return self }
}


func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}


extension String {
    
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        let immutableData = NSData(data: data)
        do {
            return try NSAttributedString(data: immutableData as Data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }


    
    
    func replaceLinks(html: String) -> String {
        let ahrefRegex = "#{0,1}@{0,1}<a\\shref=\\\"([^\\\"]*?)\\\".*?>(.*?)<\\/a>"
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
                    var name = mutableString.substring(with: rangeName)

                    if(url.starts(with: "#") || url.starts(with: "@")){
                        name = url;
                    }
                    
                    
                    
                    
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

    
    func replaceOtherStuff(html: String) -> String {
        return html.replacingOccurrences(of: "<br />", with: "\n")
        //TODO:
        
    }


    var markupFromHtml:AttributedString? {
        var result = replaceLinks(html: self);
        result = replaceOtherStuff(html: result);
        do {
            return try AttributedString(markdown: result)
        } catch {
            return nil;
        }
;
    }
    
    
    
}




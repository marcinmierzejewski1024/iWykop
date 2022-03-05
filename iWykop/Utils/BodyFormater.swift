//
//  BodyFormater.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 05/03/2022.
//

import Foundation
import UIKit

protocol BodyFormatable {
    var bodyAttributed: AttributedString? { get set }
    var body: String? { get }


}

class BodyFormater
{
 
    @MainActor
    func addBodyAttr(es:[BodyFormatable]) async -> [BodyFormatable] {

        
        es.map { entry in
            var withAttributed = entry;
            withAttributed.bodyAttributed = self.markupFromHtml(entry.body)
            return withAttributed;
        }
        
    }
    
    
    func markupFromHtml(_ html: String?) -> AttributedString? {

        guard html != nil else {
            return nil;
        }
        
        guard Thread.isMainThread else {
            return nil;
        }
        
        let replacedLinks = self.replaceLocalLinks(html!);
        

        do {
            let data = Data(replacedLinks.utf8)
            if let nsAttr = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {

                let attr = try AttributedString(nsAttr, including: \.uiKit)

                return attr;
            }
        } catch {
            return nil;
        }

        return nil;

    }

    
    
    func replaceLocalLinks(_ html: String) -> String {
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
                    
                    var url = mutableString.substring(with: rangeUrl)
                    var name = mutableString.substring(with: rangeName)

                    if(url.starts(with: "#") || url.starts(with: "@")){
                        name = url;
                        url = "iWykop:\(url)"
                        
                     
                        mutableString.replaceOccurrences(of: foundBlock, with: "<a href='\(url)'>\(name)</a>", options: [], range: match.range)
                        let asString = String(mutableString);
                        let newRange = NSRange(location: 0, length: asString.utf16.count)
                        
                        matches = regex.matches(in: asString, options: [], range: newRange)
                    }
                    
                    
                    
                    

                }
            }
            
            return String(mutableString);
        } catch {
            return html;
        }
        
    }


}

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
    var visibleSpoilers: [String]? { get set }

}

protocol WithComments : BodyFormatable
{
    var comments: [Comment]? { get set}
    
}

class BodyFormater
{
    
    
    
    @MainActor
    func addBodyAttr(es:[BodyFormatable]) async -> [BodyFormatable] {
        //creating attributedString fails when is on non-main queue
        
        es.map { entry in
            var withAttributed = entry;
            withAttributed.bodyAttributed = self.markupFromHtml(entry.body, spoilersToShow: entry.visibleSpoilers)
            
            if var withComments = withAttributed as? WithComments {
                
                withComments.comments = withComments.comments?.map({ c in
                    var commentWithAttributed = c;
                    commentWithAttributed.bodyAttributed = self.markupFromHtml(commentWithAttributed.body, spoilersToShow: commentWithAttributed.visibleSpoilers);
                    return commentWithAttributed;
                });
                
                
                return withComments;
                
            }
            
            return withAttributed;
        }
        
    }
    
    @MainActor
    func addBodyAttrSingle(es:BodyFormatable) async -> BodyFormatable? {
        return await addBodyAttr(es: [es]).first;
    }
    
    @MainActor
    func showSpoiler(es:BodyFormatable, spoiler:URL) async -> BodyFormatable? {
        var spoilers = es.visibleSpoilers ?? [String]();
        var copy = es;
        spoilers.append(spoiler.absoluteString);
        copy.visibleSpoilers = spoilers;
        
        return await self.addBodyAttrSingle(es: copy);
    }

    
    private func markupFromHtml(_ html: String?, spoilersToShow:[String]?) -> AttributedString? {
        
        guard html != nil else {
            return nil;
        }
        
        guard Thread.isMainThread else {
            return nil;
        }
        
        let replacedLinks = BodyFormater.replaceLocalLinks(html!,spoilersToShow: spoilersToShow);
        let otherReplaced = BodyFormater.replaceOtherSymbols(replacedLinks);
        let withCustomCss = BodyFormater.addFontCss(otherReplaced);
        
        
        do {
            let data = Data(withCustomCss.utf8)
            
            
            if let nsAttr = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil) {
                
                let attr = try AttributedString(nsAttr, including: \.uiKit)
                
                return attr;
            }
        } catch {
            return nil;
        }
        
        return nil;
        
    }
    
    
    static private func addFontCss(_ html: String) -> String {
        
        
        let css = """
            *{
            font-family: '-apple-system', 'HelveticaNeue'; font-size: \(UIFont.bodyFont().pointSize)pt;
             color: #\(WykopColors.shared.currentTheme.textColor.hexDescription());

            }
            a{
                 text-decoration: none;
                 color: #\(WykopColors.shared.currentTheme.accentColor.hexDescription());
                 
             }
            """;
        
        return "<style>\(css)</style> <span>\(html)</span>";
        
    }
    
    
    static func replaceOtherSymbols(_ html: String) -> String {
        return html.replacingOccurrences(of: "&quot;", with: "\"");
    }
    
    static private func replaceLocalLinks(_ html: String, spoilersToShow:[String]?) -> String {
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
                    
                    if (url.starts(with: "#") || url.starts(with: "@") || (url.starts(with: "spoiler:"))) {

                        if (url.starts(with: "spoiler:")) {
                            url = "iwykop:\(url)"
                        } else {
                            name = url;
                            url = "iwykop:\(url)"
                        }

                        
                        var newText = "<a href=\"\(url)\">\(name)</a>";
                         
                        if let spoilersToShow = spoilersToShow {
                            _ = spoilersToShow.map { spoiler in
                                if(url == spoiler) {
                                    newText = url.replacingOccurrences(of: "+", with: "%20").decodeUrl()?.replacingOccurrences(of: "iwykop:spoiler:", with: "") ?? "Show Spoiler Bug"
                                }
                            }
                        }
                        mutableString.replaceOccurrences(of: foundBlock, with: newText, options: [], range: match.range)
                        
                        let asString = String(mutableString);
                        let newRange = NSRange(location: 0, length: asString.utf16.count)
                        
                        matches = regex.matches(in: asString, options: [], range: newRange)
                    } else {
                        
                        
                        let asString = String(mutableString);
                        let newRange = NSRange(location: match.range.location + match.range.length , length: (asString.utf16.count - match.range.location - match.range.length))
                        
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

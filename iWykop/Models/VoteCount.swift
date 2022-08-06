//
//  VoteCount.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 15/07/2022.
//

import Foundation
struct VoteCount
{
    let voteCountPlus : Int?;
    let voteCountMinus : Int?;
    let upvotes : Int?;
    
    
    static func from(comment:Comment) -> VoteCount {
        return VoteCount(voteCountPlus: comment.voteCountPlus, voteCountMinus: abs(comment.voteCountMinus ?? 0), upvotes: (comment.voteCountPlus ?? 0) - (comment.voteCountMinus ?? 0))
    }
    
    static func from(link:Link) -> VoteCount {
        return VoteCount(voteCountPlus: link.voteCount, voteCountMinus: abs(link.buryCount ?? 0), upvotes: link.voteCount - (link.buryCount ?? 0))
    }

    static func from(entry:Entry) -> VoteCount {
        return VoteCount(voteCountPlus: entry.voteCount, voteCountMinus: nil, upvotes: entry.voteCount)
    }

}


//
//  TagsListView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 21/06/2022.
//

import Foundation
import SwiftUI

struct TagsListView: View {
    
    let tags : [String];
    
    var body: some View {
        VStack(alignment: .leading, spacing: Margins.medium.rawValue) {
            ForEach(tags, id: \.hashValue) { tag in
                Text(tag).font(Font.largeFont()).padding(Margins.medium.rawValue);
            }
        }
        
    }
}

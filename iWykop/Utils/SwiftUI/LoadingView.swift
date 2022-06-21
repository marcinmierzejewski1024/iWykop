//
//  LoadingView.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 21/06/2022.
//

import SwiftUI

struct LoadingView: View {
    var title = "Loading";
    
    var body: some View {
        HStack {
            ProgressView()
            Text(NSLocalizedString(title, comment: "")).padding()
        }.padding()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

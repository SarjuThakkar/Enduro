//
//  StatView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/4/23.
//

import SwiftUI

struct StatView: View {
    var label: String
    var value: String
    var width: CGFloat

    var body: some View {
        VStack {
            Text(value)
                .font(.title)
            Text(label)
        }
        .frame(width: width)
    }
}


#Preview {
    StatView(label: "Miles", value: "10", width: 100)
}

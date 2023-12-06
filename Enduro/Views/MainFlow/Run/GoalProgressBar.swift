//
//  GoalProgressBar.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/4/23.
//

import SwiftUI

struct GoalProgressBar: View {
    let progressResult: ProgressResult

    var body: some View {
        VStack {
            Text("Goal Progress").font(.headline)
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width, height: 25)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                    
                    Rectangle().frame(width: min(CGFloat(self.progressResult.percentage) / 100 * geometry.size.width, geometry.size.width), height: 25)
                        .foregroundColor(Color.blue)
                        .animation(.linear, value: self.progressResult.percentage)
                    
                    // Overlay the percentage text inside the progress bar
                    Text("\(self.progressResult.percentage)%")
                        .frame(width: geometry.size.width, alignment: .center)
                }
                .cornerRadius(45.0)
            }
            .frame(height: 25) // Set a fixed height for the progress bar
            .padding()
        }
    }
}

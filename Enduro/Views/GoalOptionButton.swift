//
//  GoalOptionButton.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/23/23.
//

import SwiftUI

struct GoalOptionButton: View {
    let text: String
    let symbolName: String
    let goalType: GoalType
    
    var body: some View {
        NavigationLink(value: goalType) {
            VStack {
                Image(systemName: symbolName)
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.bottom, 8)
                
                Text(text)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            .padding(.horizontal, 10) // Added padding to individual button
        }
    }
}


struct GoalOptionButton_Previews: PreviewProvider {
    static var previews: some View {
        GoalOptionButton(text: "I want to run longer", symbolName: "timer", goalType: .time)
    }
}

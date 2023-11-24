//
//  DistanceSlider.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/24/23.
//

import SwiftUI

struct DistanceSlider: View {
    @Binding var selectedDistance: Double

    var body: some View {
        VStack {
            Slider(value: $selectedDistance, in: 0.95...26.2, step: 0.1)
                .padding(.horizontal) // Add padding to avoid touching the screen edges
            
            Text("\(selectedDistance, specifier: "%.1f") miles")
                .padding(.top, 5) // Provide some space between the slider and the label
        }
    }
}

struct DistanceSlider_Previews: PreviewProvider {
    @State static var previewSelectedDistance: Double = 1.0 // Temporary state for preview

    static var previews: some View {
        DistanceSlider(selectedDistance: $previewSelectedDistance)
    }
}

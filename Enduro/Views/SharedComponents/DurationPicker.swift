//
//  DurationPicker.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/24/23.
//

import SwiftUI

struct DurationPicker: View {
    @Binding var selectedHours: Int
    @Binding var selectedMinutes: Int

    var body: some View {
        HStack {
            Picker("Hours", selection: $selectedHours) {
                PickerContent(pickerValues: Array(0..<24)) { "\($0) hr" }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100, alignment: .center)

            Picker("Minutes", selection: $selectedMinutes) {
                PickerContent(pickerValues: Array(0..<60)) { "\($0) min" }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100, alignment: .center)
        }
    }
}


struct DurationPicker_Previews: PreviewProvider {
    @State static var previewSelectedHours: Int = 1 // Temporary state for preview
    @State static var previewSelectedMinutes: Int = 30 // Temporary state for preview

    static var previews: some View {
        DurationPicker(selectedHours: $previewSelectedHours, selectedMinutes: $previewSelectedMinutes)
    }
}

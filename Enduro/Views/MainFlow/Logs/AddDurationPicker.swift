//
//  AddDurationPicker.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/4/23.
//

import SwiftUI

struct AddDurationPicker: View {
    @Binding var selectedHours: Int
    @Binding var selectedMinutes: Int
    @Binding var selectedSeconds: Int

    var body: some View {
        HStack {
            Picker("Hours", selection: $selectedHours) {
                ForEach(0..<24) { Text("\($0) hr").tag($0) }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)

            Picker("Minutes", selection: $selectedMinutes) {
                ForEach(0..<60) { Text("\($0) min").tag($0) }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)

            Picker("Seconds", selection: $selectedSeconds) {
                ForEach(0..<60) { Text("\($0) sec").tag($0) }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
        }
    }
}

struct AddDurationPicker_Previews: PreviewProvider {
    @State static var previewSelectedHours: Int = 23
    @State static var previewSelectedMinutes: Int = 59
    @State static var previewSelectedSeconds: Int = 59

    static var previews: some View {
        AddDurationPicker(selectedHours: $previewSelectedHours,
                          selectedMinutes: $previewSelectedMinutes,
                          selectedSeconds: $previewSelectedSeconds)
    }
}


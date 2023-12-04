//
//  PickerContent.swift
//  Enduro
//
//  Created by Sarju Thakkar on 12/2/23.
//

import SwiftUI

struct PickerContent<Data>: View where Data: RandomAccessCollection, Data.Element: Hashable {
    let pickerValues: Data
    let labelBuilder: (Data.Element) -> String

    var body: some View {
        ForEach(pickerValues, id: \.self) { value in
            Text(labelBuilder(value)).tag(value)
        }
    }
}

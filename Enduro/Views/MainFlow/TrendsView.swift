//
//  TrendsView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/25/23.
//

import SwiftUI
import Charts

struct TrendsView: View {
    @Environment(\.managedObjectContext) private var context
       
    @StateObject private var viewModel = RunDataViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Chart {
                    ForEach(viewModel.runData, id: \.date) { runData in
                        BarMark(
                            x: .value("Date", runData.date, unit: .day),
                            y: .value("Miles", runData.totalMiles)
                        )
                    }
                }
                
                Chart {
                    ForEach(viewModel.runData, id: \.date) { runData in
                        BarMark(
                            x: .value("Date", runData.date, unit: .day),
                            y: .value("Duration", runData.totalDuration)
                        )
                    }
                }
                
                Chart {
                    ForEach(viewModel.runData, id: \.date) { runData in
                        BarMark(
                            x: .value("Date", runData.date, unit: .day),
                            y: .value("Pace", runData.averagePace)
                        )
                    }
                }
            }
            .navigationTitle("Trends")
            .onAppear {
               viewModel.setContext(context)
               viewModel.updateRunData()
           }
        }
    }
}


struct TrendsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendsView()
    }
}

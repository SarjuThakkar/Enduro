//
//  HomeView.swift
//  Enduro
//
//  Created by Sarju Thakkar on 11/22/23.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tabs = .run // Default to the "Run" tab

    var body: some View {
        TabView(selection: $selectedTab) {
            TrendsView()
                .tabItem {
                    Label("Trends", systemImage: "chart.xyaxis.line")
                }
                .tag(Tabs.trends) // Tag for identifying the tab

            RunView()
                .tabItem {
                    Label("Run", systemImage: "figure.run")
                }
                .tag(Tabs.run) // Tag for identifying the tab

            LogView()
                .tabItem {
                    Label("Log", systemImage: "square.and.pencil")
                }
                .tag(Tabs.log) // Tag for identifying the tab
        }
    }

    enum Tabs {
        case trends, run, log
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

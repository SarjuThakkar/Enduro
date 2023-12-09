//
//  SessionPagingView.swift
//  EnduroCompanion Watch App
//
//  Created by Sarju Thakkar on 12/8/23.
//

import SwiftUI

struct SessionPagingView: View {
    @State private var selection: Tab = .metrics
    
    enum Tab {
        case controls, metrics, nowPlaying
    }
    var body: some View {
        TabView(selection: $selection,
                content:  {
            Text("Controls").tabItem { Text("Controls") }.tag(Tab.controls)
            Text("Metrics").tabItem { Text("Metrics") }.tag(Tab.metrics)
            Text("Now Playing").tabItem { Text("Now Playing") }.tag(Tab.nowPlaying)
        })
    }
}

#Preview {
    SessionPagingView()
}

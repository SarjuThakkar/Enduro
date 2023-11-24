import SwiftUI

struct WelcomeView: View {
    @State private var selectedGoalType: GoalType?
    @ObservedObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer() // Use spacer to push Welcome towards center
                
                // Title
                Text("Meet Enduro")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                // Subtitle
                Text("Enduro is designed to help you improve your running through the progressive overloading methodology. Simply put, Enduro challenges you to do a little bit better every day so you can reach your goals!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20) // Increased horizontal padding for the subtitle
                    .multilineTextAlignment(.center)
                
                Spacer() // Use spacer to provide space between text and buttons
                
                // Goal Question
                Text("What is your goal?")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                
                // Goal Reminder
                Text("You can always change and update your goals in settings.\nFor now choose what best aligns with you!")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20) // Increased horizontal padding for the reminder
                    .padding(.bottom, 20)
                
                // Goal Options
                HStack {
                    GoalOptionButton(text: "I want to run longer", symbolName: "timer", goalType: .time)
                    GoalOptionButton(text: "I want to run farther", symbolName: "map", goalType: .distance)
                }
                .padding(.horizontal, 20)
                Spacer() // Use spacer to push Welcome towards center
            }
            .padding(.horizontal, 10) // Added horizontal padding to VStack
            .navigationDestination(for: GoalType.self) { goalType in
                GoalSettingView(goalType: goalType, onGoalSet: onGoalSet)
            }
        }
    }
    func onGoalSet() {
        appState.hasCompletedWelcomeFlow = true
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(appState: previewAppState)
    }

    static var previewAppState: AppState {
        let appState = AppState()
        appState.hasCompletedWelcomeFlow = true // Configure as needed for the preview
        return appState
    }
}



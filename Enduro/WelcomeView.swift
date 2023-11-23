import SwiftUI

struct WelcomeView: View {
    var body: some View {
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
                GoalOptionButton(text: "I want to run further", symbolName: "map", goalType: .distance)
            }
            .padding(.horizontal, 20) // Increased horizontal padding for buttons
            
            Spacer() // Use spacer to push Welcome towards center
        }
        .padding(.horizontal, 10) // Added horizontal padding to VStack
    }
}

struct GoalOptionButton: View {
    let text: String
    let symbolName: String
    let goalType: GoalType

    var body: some View {
        Button(action: {
            UserDefaults.standard.userPreferences = UserPreferences(goalType: goalType)
            print("Goal set to: \(goalType.rawValue)")
            // Here you might want to navigate to the main view of your app or perform other actions after saving the preference
        }) {
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

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

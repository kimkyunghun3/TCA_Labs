import SwiftUI

struct ContentView: View {
    var body: some View {
      VStack {
        ProgressView(value: 10, total: 15)
        HStack {
          VStack(alignment: .leading) {
            Text("Seconds Elapsed")
              .font(.caption)
            Label("300", systemImage: "hourglass.tophalf.fill")
          }
          Spacer()
          VStack(alignment: .trailing) {
            Text("seconds Remaining")
              .font(.caption)
            Label("600", systemImage: "hourglass.bottomhalf.fill")
          }
        }
        .accessibilityElement()
        .accessibilityLabel("Time remaining")
        .accessibilityValue("10 minutes")
        Circle()
          .strokeBorder(lineWidth: 24)
        HStack {
          Text("Speaker 1 of 3")
          Spacer()
          Button { } label: {
            Image(systemName: "forward.fill")
          }
          .accessibilityLabel("Next speaker")
        }
      }
      .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

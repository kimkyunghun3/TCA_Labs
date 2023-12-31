import SwiftUI

struct DetailEditView: View {
  @Binding var scrum: DailyScrum
  @State private var newAttendeeName = ""
  
    var body: some View {
      Form {
        Section {
          TextField("Title", text: $scrum.title)
          HStack {
            Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
              Text("Length")
            }
            .accessibilityValue("\(scrum.lengthInMinutes) minutes")
            Spacer()
            Text("\(scrum.lengthInMinutes) minutes")
              .accessibilityHidden(true)
          }
          ThemePicker(selection: $scrum.theme)
        } header: {
          Text("Metting Info")
        }
        Section {
          ForEach(scrum.attendees) { attendee in
            Text(attendee.name)
          }
          .onDelete { indices in
            scrum.attendees.remove(atOffsets: indices)
          }
        } header: {
          Text("Attendees")
        }
        
        HStack {
          TextField("New Attendee", text: $newAttendeeName)
          Button {
            withAnimation {
              let attendee = DailyScrum.Attendee(name: newAttendeeName)
              scrum.attendees.append(attendee)
              newAttendeeName = ""
            }
          } label: {
            Image(systemName: "plus.circle.fill")
              .accessibilityLabel("Add attendee")
          }
          .disabled(newAttendeeName.isEmpty)
        }
      }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
      DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}

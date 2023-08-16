import SwiftUI

struct SpecificSpacing: View {
    var body: some View {
        Text("Specific Spacing")
        HStack {
            TrainCar(.rear)
            Spacer()
            TrainCar(.middle)
            Spacer()
            TrainCar(.front)
        }
        TrainTrack()
    }
}

struct SpecificSpacing_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            SpecificSpacing()
        }
    }
}

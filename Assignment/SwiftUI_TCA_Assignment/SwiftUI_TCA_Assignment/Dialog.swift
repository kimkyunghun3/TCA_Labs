import Foundation

struct Dialog: Hashable {
    let number: String
    let alphabet: String?
}

extension Dialog {
    static func all() -> [Dialog] {
        return [
            Dialog(number: "1", alphabet: ""),
            Dialog(number: "2", alphabet: "ABC"),
            Dialog(number: "3", alphabet: "DEF"),
            Dialog(number: "4", alphabet: "GHI"),
            Dialog(number: "5", alphabet: "JKL"),
            Dialog(number: "6", alphabet: "MNO"),
            Dialog(number: "7", alphabet: "PQRS"),
            Dialog(number: "8", alphabet: "TUV"),
            Dialog(number: "9", alphabet: "WXYZ"),
            Dialog(number: "٭", alphabet: ""),
            Dialog(number: "0", alphabet: "+"),
            Dialog(number: "#", alphabet: "")
        ]
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

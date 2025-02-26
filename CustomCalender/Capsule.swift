//
//  Capsule.swift
//  CustomCalender
//
//  Created by Adit Hasan on 2/25/25.
//

import SwiftUI

struct CapsuleBarView: View {
    var body: some View {
        Capsule()
            .fill(Color.red) // Change color as needed
            .frame(width: 20, height: 5) // Adjust size
            .shadow(radius: 2) // Optional shadow
    }
}

 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleBarView()
    }
}
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

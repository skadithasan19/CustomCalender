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

//
//  CardView.swift
//  Natos
//
//  Created by Saarthak Tuli on 28/12/22.
//

import SwiftUI

struct CardView: View {
    @State var noteDate: Date = Date.now
    @State var notemessage: String = ""
    @State var noteColor: String = "Pink"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(notemessage)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("\(noteDate.formatted())")
                .bold()
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 30, alignment: .leading)
        .padding()
        .background(Color(noteColor))
        .cornerRadius(25)
        
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

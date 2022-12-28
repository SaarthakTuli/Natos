//
//  AddNote.swift
//  Natos
//
//  Created by Saarthak Tuli on 28/12/22.
//

import SwiftUI
import UIKit

let colors = ["Pink", "Green", "Purple", "Blue", "Yellow"]

struct AddNote: View {
    @Environment(\.managedObjectContext) var managedObjContext
    
    @Binding var showAddPage: Bool
    
    @State var message: String = ""
    @State var date: Date = Date.now
    @State var color: Int = 0
    
    var body: some View {
        VStack {
            // MARK: Header...
            HStack {
                Button {
                    showAddPage.toggle()
                } label: {
                    Text("Cancel")
                }
                Spacer(minLength: 0)
                
                Text("Add Note")
                
                Spacer(minLength: 0)
                
                Button {
                    DataController().addNote(message: message, date: date, color: colors[color], context: managedObjContext)
                    
                    withAnimation(.spring()) { showAddPage.toggle() }
                } label: {
                    Text("Save")
                }

                
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 10){
                    Text("Add Message")
                    TextEditor(text: $message)
                        .font(.title3)
                        .shadow(color: .primary, radius: 1)
                        .padding()
                        .frame(height: UIScreen.main.bounds.height/2 - 100)
                }
                
                
                DatePicker("Date", selection: $date, in: ...Date.now,displayedComponents: .date)
                
                VStack(spacing: 10) {
                    Text("Color")
                    
                    Picker(selection: $color) {
                        Text("Pink")
                            .tag(0)
                        
                        Text("Green")
                            .tag(1)
                        
                        Text("Purple")
                            .tag(2)
                        
                        Text("Blue")
                            .tag(3)
                        
                        Text("Yellow")
                            .tag(4)
                    } label: {
                        Text("")
                            .background(Color(colors[color]))
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onAppear {
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(colors[color]))
                    }
                    .id(color)
                }
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
        }
        .interactiveDismissDisabled()
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote(showAddPage: .constant(true))
    }
}

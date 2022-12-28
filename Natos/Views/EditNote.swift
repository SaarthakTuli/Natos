//
//  EditNote.swift
//  Natos
//
//  Created by Saarthak Tuli on 28/12/22.
//


import SwiftUI
import UIKit

struct EditNote: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var message: String = ""
    @State private var date: Date = Date.now
    @State private var color: String = "Pink"
    var note: FetchedResults<Note>.Element
    
    var body: some View {
   
        VStack {
            // MARK: Header...
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Spacer(minLength: 0)
                
                Text("Edit Note")
                
                Spacer(minLength: 0)
                
                Button {
                    DataController().editNote(note: note, message: message, date: date, color: color, context: managedObjContext)
                    
                    dismiss()
                } label: {
                    Text("Save")
                }

                
            }
            .padding()
            
            Divider()
            
           
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 10){
                    Text("Edit Message")
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
                            .tag("Pink")
                        
                        Text("Green")
                            .tag("Green")
                        
                        Text("Purple")
                            .tag("Purple")
                        
                        Text("Blue")
                            .tag("Blue")
                        
                        Text("Yellow")
                            .tag("Yellow")
                    } label: {
                        Text("")
                            .background(Color(color))
                            .frame(width: 24, height: 24)
                            .clipShape(Circle())
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onAppear {
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(color))
                    }
                    .id(color)
                }
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            .onAppear {
                message = note.message!
                date = note.date!
                color = note.color!
            }
             
        }
        .navigationBarBackButtonHidden()
    }
}

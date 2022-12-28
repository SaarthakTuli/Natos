//
//  Home.swift
//  Natos
//
//  Created by Saarthak Tuli on 28/12/22.
//

import SwiftUI
import CoreData

struct Home: View {
    @State var showAddPage: Bool = false
    
    @State var searchText: String = ""
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) var managedObjContext
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(notes) {note in
                        NavigationLink {
                            EditNote(note: note)
                        } label: {
                            VStack(alignment: .leading, spacing: 25) {
                                Text(note.message ?? "Unable to load...")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Text("\(note.date?.convert() ?? Date.now.formatted())")
                                    .bold()
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                            .frame(maxWidth: UIScreen.main.bounds.width - 30, alignment: .leading)
                            .padding()
                            .background(Color(note.color ?? "Pink"))
                            .cornerRadius(25)
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                        .buttonStyle(.plain)
                        .padding(.trailing, -30)

                        
                    }
                    .onDelete(perform: removeData)
                }
                .listStyle(.plain)
                
            }
            .navigationTitle(Text("Natos"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring()) { showAddPage = true }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        EditButton()
                    }

                }
            }
            .popover(isPresented: $showAddPage) {
                AddNote(showAddPage: $showAddPage)
            }
            .onAppear() {
                print(notes)
            }
            .searchable(text: $searchText, prompt: "Looking for something...")
            .onChange(of: searchText) { val in
                notes.nsPredicate = searchPredicate(query: val)
            }
            
        }
    }
    
    private func searchPredicate(query: String) -> NSPredicate? {
        if query.isEmpty { return nil }
        return NSPredicate(format:
                            "%K BEGINSWITH[cd] %@ OR %K CONTAINS[cd] %@ OR %K BEGINSWITH[cd] %@",
                           #keyPath(Note.message), query, #keyPath(Note.date), query,
                           #keyPath(Note.color), query)
                           
    }
    
//    private func loadNotes() {
//        print("loading data..")
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
//
//        do {
//            notes = try managedObjContext.fetch(fetchRequest) as! [Note]
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
    
    private func removeData(at offsets: IndexSet) {
        withAnimation {
            offsets.map {
                notes[$0]
            }.forEach(managedObjContext.delete(_:))
            
            DataController().save(context: managedObjContext)
        }
    }
}
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Home()
//
//            Home()
//                .preferredColorScheme(.dark)
//        }
//    }
//}

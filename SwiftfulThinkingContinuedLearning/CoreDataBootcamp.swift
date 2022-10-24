//
//  CoreDataBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 11.10.22.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []

    init() {
        self.container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        fetchFriuts()
    }
    
    func fetchFriuts() {
        let entityName = String(describing: FruitEntity.self)
        let request = NSFetchRequest<FruitEntity>(entityName: entityName)
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching. \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func updateFruit(_ entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFriuts()
        } catch {
            print("Error saving: \(error)")
        }
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20.0) {
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)))
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
                
                List {
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.name ?? "NO NAME")
                            .onTapGesture {
                                vm.updateFruit(entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}

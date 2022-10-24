//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artur Remizov on 11.10.22.
//

import SwiftUI
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error loading Core Data: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved successfully!")
        } catch {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipsViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func getBusinesses() {
        let entityName = String(describing: BusinessEntity.self)
        let request = NSFetchRequest<BusinessEntity>(entityName: entityName)
        
        let sortDescriptor = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getDepartments() {
        let entityName = String(describing: DepartmentEntity.self)
        let request = NSFetchRequest<DepartmentEntity>(entityName: entityName)
        
        do {
            departments = try manager.context.fetch(request)
        } catch {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getEmployees() {
        let entityName = String(describing: EmployeeEntity.self)
        let request = NSFetchRequest<EmployeeEntity>(entityName: entityName)
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getEmployees(for business: BusinessEntity) {
        let entityName = String(describing: EmployeeEntity.self)
        let request = NSFetchRequest<EmployeeEntity>(entityName: entityName)
        
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do {
            employees = try manager.context.fetch(request)
        } catch {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
//        newBusiness.departmens = []
//        newBusiness.employees = []
//        newBusiness.addToDepartmens(<#T##value: DepartmentEntity##DepartmentEntity#>)
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
//        newBusiness.departmens = [departments[0], departments[1]]
//        newBusiness.employees = [employees[1]]
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        
//        newDepartment.employees = [employees[1]]
        newDepartment.addToEmployees(employees[1])
        
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 21
        newEmployee.dateJoined = Date()
        newEmployee.name = "John"
        
        newEmployee.business = businesses[2]
        newEmployee.department = departments[1]
        
        save()
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartmens(departments[1])
        save()
    }
    
    func deleteDepartment() {
        let department = departments[1]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
}

struct CoreDataRelationshipsBootcamp: View {
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20.0) {
                    Button {
                        vm.deleteDepartment()
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelationshipsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBootcamp()
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departmens?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            Text("Age: \(entity.age)")
            Text("Date joined: \(entity.dateJoined ?? Date())")
            
            Text("Business:")
                .bold()
            Text(entity.business?.name ?? "")
            
            Text("Department:")
                .bold()
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

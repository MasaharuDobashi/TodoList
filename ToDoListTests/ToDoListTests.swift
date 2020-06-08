//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by 土橋正晴 on 2018/11/14.
//  Copyright © 2018 m.dobashi. All rights reserved.
//

import XCTest
@testable import ToDoList

class ToDoModelTests: XCTestCase {

    var view:ToDoListViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = ToDoListViewController()
        
     
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        ToDoModel.allDelete()
    }
    
    
    func test_AddModel() {
        
        let addTodoDate = Format().stringFromDate(date: Date())
        ToDoModel.addRealm(view, addValue: TableValue(id: "0", title: "UnitTest", todoDate: addTodoDate, detail: "詳細"))
        let todoModel = ToDoModel.findRealm(view, todoId: "0", createTime: nil)
        
        XCTAssert(todoModel?.id == "0", "idが登録されていない")
        XCTAssert(todoModel?.toDoName == "UnitTest", "Todoのタイトルが登録されていない")
        XCTAssert(todoModel?.todoDate == addTodoDate, "　Todoの期限が登録されていない")
        XCTAssert(todoModel?.toDo == "詳細", "　Todoの詳細が登録されていない")
        XCTAssert(!(todoModel?.createTime!.isEmpty)!, "Todo作成時間が登録されていない")
    }
    
    
    
    func test_EditModel() {
        let addTodoDate = Format().stringFromDate(date: Date())
        ToDoModel.addRealm(view, addValue: TableValue(id: "0", title: "UnitTest", todoDate: addTodoDate, detail: "詳細"))
    
        let updateTodoDate = Format().stringFromDate(date: Date())
        ToDoModel.updateRealm(view, todoId: "0", updateValue: TableValue(id: "0", title: "EditUnitTest", todoDate: updateTodoDate, detail: "詳細編集"))
        
        
        let todoModel = ToDoModel.findRealm(view, todoId: "0", createTime: nil)
        XCTAssert(todoModel?.id == "0", "idが登録されていない")
        XCTAssert(todoModel?.toDoName == "EditUnitTest", "Todoのタイトルが登録されていない")
        XCTAssert(todoModel?.todoDate == updateTodoDate, "　Todoの期限が登録されていない")
        XCTAssert(todoModel?.toDo == "詳細編集", "　Todoの詳細が登録されていない")
        XCTAssert(!(todoModel?.createTime!.isEmpty)!, "Todo作成時間が登録されていない")
    }
    
    
    
    
    func test_DeleteModel() {
        let addTodoDate = Format().stringFromDate(date: Date())
        ToDoModel.addRealm(view, addValue: TableValue(id: "0", title: "UnitTest", todoDate: addTodoDate, detail: "詳細"))
        
        let todoModel = ToDoModel.findRealm(view, todoId: "0", createTime: nil)
        
        XCTAssertTrue(ToDoModel.allFindRealm(view)!.count > 0, "Todoが作成されていない")
        XCTAssert(todoModel?.id == "0", "idが登録されていない")
        XCTAssert(todoModel?.toDoName == "UnitTest", "Todoのタイトルが登録されていない")
        XCTAssert(todoModel?.todoDate == addTodoDate, "　Todoの期限が登録されていない")
        XCTAssert(todoModel?.toDo == "詳細", "　Todoの詳細が登録されていない")
        XCTAssert(!(todoModel?.createTime!.isEmpty)!, "Todo作成時間が登録されていない")
        
        ToDoModel.deleteRealm(view, todoId: todoModel!.id, createTime: todoModel?.createTime) {
            XCTAssertFalse(ToDoModel.allFindRealm(view)!.count > 0, "Todoが削除されていない")
        }
        
    }
    
    
    
    func test_allDeleteModel() {
        let addTodoDate = Format().stringFromDate(date: Date())
        ToDoModel.addRealm(view, addValue: TableValue(id: "0", title: "UnitTest1", todoDate: addTodoDate, detail: "詳細1"))
        sleep(1)
        ToDoModel.addRealm(view, addValue: TableValue(id: "1", title: "UnitTest2", todoDate: addTodoDate, detail: "詳細2"))
        
        let todoModel1 = ToDoModel.findRealm(view, todoId: "0", createTime: nil)
        
        XCTAssertTrue(ToDoModel.allFindRealm(view)!.count == 2, "Todoが作成されていない")
        XCTAssert(todoModel1?.id == "0", "idが登録されていない")
        XCTAssert(todoModel1?.toDoName == "UnitTest1", "Todoのタイトルが登録されていない")
        XCTAssert(todoModel1?.todoDate == addTodoDate, "　Todoの期限が登録されていない")
        XCTAssert(todoModel1?.toDo == "詳細1", "　Todoの詳細が登録されていない")
        XCTAssert(!(todoModel1?.createTime!.isEmpty)!, "Todo作成時間が登録されていない")
        
        let todoModel2 = ToDoModel.findRealm(view, todoId: "1", createTime: nil)
        XCTAssert(todoModel2?.id == "1", "idが登録されていない")
        XCTAssert(todoModel2?.toDoName == "UnitTest2", "Todoのタイトルが登録されていない")
        XCTAssert(todoModel2?.todoDate == addTodoDate, "　Todoの期限が登録されていない")
        XCTAssert(todoModel2?.toDo == "詳細2", "　Todoの詳細が登録されていない")
        XCTAssert(!(todoModel2?.createTime!.isEmpty)!, "Todo作成時間が登録されていない")
        
        ToDoModel.allDeleteRealm(view) {
            XCTAssertFalse(ToDoModel.allFindRealm(self.view)!.count > 0, "Todoが削除されていない")
        }
        
    }
    

}

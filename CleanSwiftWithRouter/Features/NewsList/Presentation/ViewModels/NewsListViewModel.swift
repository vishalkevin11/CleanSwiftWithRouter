//
//  NewsListViewModel.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Combine
import Foundation


class Person {
    var name: String
    var pet: Pet?
    
    init(name: String) {
        self.name = name
        print("\(name) has been initialized.")
    }
    
    deinit {
        print("\(name) has been deinitialized.")
    }
}

class Pet {
    var name: String
    weak var owner: Person?
    
    init(name: String) {
        self.name = name
        print("\(name) has been initialized.")
    }
    
    deinit {
        print("\(name) has been deinitialized.")
    }
}


enum NewListResultState: Equatable {
    case none
    case loading
    case error(String)
    case results([NewsEntity])
}


@propertyWrapper
struct Capitalise {
    //Using propert observers
//    var wrappedValue: String {
//        didSet {
//            wrappedValue = wrappedValue.uppercased()
//        }
//    }
//    
//    init(wrappedValue: String) {
//        self.wrappedValue = wrappedValue
//    }
    
    // using computed peoerty
    var name: String
    var wrappedValue: String  {
        get {
            name.uppercased()
        }
        set {
            name = newValue
        }
    }
    init(wrappedValue: String) {
        self.name = wrappedValue
    }
}

final class B {
    let newBall = ""
 //  weak var news = NewsListViewModel(newsUsecase: NewsUsecase(newsRespository: NewsListRepoImp()))
}


final class A {
    let newBall = ""
    let b = B()
 //  weak var news = NewsListViewModel(newsUsecase: NewsUsecase(newsRespository: NewsListRepoImp()))
}

final class NewsListViewModel: ObservableObject {
//    @Published var newsList: [NewsEntity] = []
//    @Published var isLoading: Bool = false
//    @Published var errorMessage = ""
    
    // var a = A()
    
    @Published private(set) var newListResultState: NewListResultState = .none
    
    private var newsUsecase: NewsUsecase?
    private var cancellable: AnyCancellable?
    
    @Capitalise var lowerstring  = "kevin"
    
    var john: Person? = Person(name: "John")
    var dog: Pet? = Pet(name: "Fido")
    
    
    
    init(newsUsecase: NewsUsecase?) {
        self.newsUsecase = newsUsecase
        print("\(lowerstring)")
    }
    
    
    func fetcNews() {
        
        john?.pet = dog
        dog?.owner = john
        
        guard let newsUsecase = newsUsecase else {
            self.newListResultState = .error("Invalid UseCase")
            return
        }
        
        DispatchQueue.main.async {  
            self.newListResultState = .loading
        }
        cancellable = newsUsecase.newsRespository.fetchAllNews().sink { completion in
            //guard let error = completion.
            
            switch completion {
            case .finished:
                print("Completion \(completion)")
            case .failure(let networkError):
                self.newListResultState = .error(networkError.localizedDescription)
            }
        } receiveValue: { newsEntities in
            self.newListResultState = .results(newsEntities)
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    
    
    func testFerSemaphore()  {
        
        var counter = 0
        var semaphore = DispatchSemaphore(value: 2)
        func incremet() {
            semaphore.wait()
            for var i in 0..<5 {
                print("Thread is \(Thread.current)")
                counter += 1
                print("Counter is \(counter)")
            }
            semaphore.signal()
        }
        
        func decrement() {
            semaphore.wait()
            for var i in 0..<5 {
                print("Thread is \(Thread.current)")
                counter -= 1
                print("Counter is \(counter)")
            }
            semaphore.signal()
        }
        
        let concurrentQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)
        
        concurrentQueue.async {
            incremet()
        }
        
        concurrentQueue.async {
            decrement()
        }
        
    }
    
    func taskeWithBarrier() {
        let queue  = DispatchQueue(label: "ConcurrentQueue",attributes:.concurrent)
        print("Task From Main Queue ",Thread.current)
        queue.async {
            print("Task on queue one is started")
            print(Thread.current)
            print("Task on queue one has finished")
        }
        queue.async(flags: .barrier) {
            print("Task on queue two is started")
            print(Thread.current)
            for _ in 0...1_00_000_00 {
                
            }
            print("Task on queue two is finished")
        }
        queue.async {
            print("Task on queue Three is started")
            print(Thread.current)
            print("Task on queue Three is finished")
        }
    }
    
    func taskeWithoutBarrier() {
        let queue  = DispatchQueue(label: "ConcurrentQueue",attributes:.concurrent)
        print("Task From Main Queue ",Thread.current)
        queue.async {
            print("Task on queue one is started")
            print(Thread.current)
            print("Task on queue one has finished")
        }
        queue.async() {
            print("Task on queue two is started")
            print(Thread.current)
            for _ in 0...1_00_000_00 {
                
            }
            print("Task on queue two is finished")
        }
        queue.async {
            print("Task on queue Three is started")
            print(Thread.current)
            print("Task on queue Three is finished")
        }
    }
}

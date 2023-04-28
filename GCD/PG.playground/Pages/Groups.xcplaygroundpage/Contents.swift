import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let queue = DispatchQueue(label: "label", attributes: .concurrent)

let group = DispatchGroup()

queue.async(group: group) {
    for i in 0...10 {
        if i == 10 {
            print(i)
        }
    }
}

queue.async(group: group) {
    for i in 0...20 {
        if i == 20 {
            print(i)
        }
    }
}

group.notify(queue: .main) {
    print("Group ended")
}

let secondGroup = DispatchGroup()

secondGroup.enter()
queue.async(group: group) {
    for i in 0...30 {
        if i == 30 {
            print(i)
            sleep(2)
            secondGroup.leave()
        }
    }
}

let result = secondGroup.wait(timeout: .now() + 3)
print(result)

secondGroup.notify(queue: .main) {
    print("secondGroup ended")
}

print("Этот принт должен быть выше чем последний")

secondGroup.wait()

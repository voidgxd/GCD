import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let workItem = DispatchWorkItem(qos: .utility, flags: .detached) {
    print("Performing workItem")
}

workItem.perform()

let queue = DispatchQueue(label: "QueueLabel", qos: .utility, attributes: .concurrent)

queue.asyncAfter(deadline: .now() + 1, execute: workItem)

workItem.notify(queue: .main) {
    print("workItem is completed")
}

workItem.isCancelled
workItem.cancel()
workItem.isCancelled

//workItem.wait()



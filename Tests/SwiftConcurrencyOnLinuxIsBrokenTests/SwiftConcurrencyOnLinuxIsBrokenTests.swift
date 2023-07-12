import XCTest
@testable import SwiftConcurrencyOnLinuxIsBroken

final class SwiftConcurrencyOnLinuxIsBrokenTests: XCTestCase {
    func testAcceptTask() throws
    {
        let asyncWorks = XCTestExpectation(description: "async task called")
        let lock = DispatchSemaphore(value: 0)

        Task
        {
            lock.signal()
            try await Task.sleep(for: .seconds(10))
        }

        lock.wait()

        Task
        {
            asyncWorks.fulfill()
        }

        wait(for: [asyncWorks], timeout: 1)
    }
}

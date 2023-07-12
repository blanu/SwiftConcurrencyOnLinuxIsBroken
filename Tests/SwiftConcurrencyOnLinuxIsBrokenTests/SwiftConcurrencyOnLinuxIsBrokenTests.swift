import XCTest
@testable import SwiftConcurrencyOnLinuxIsBroken
import TransmissionAsync

#if os(macOS)
import os.log
#else
import Logging
#endif

final class SwiftConcurrencyOnLinuxIsBrokenTests: XCTestCase {
    func testAcceptTask() throws
    {
        let asyncWorks = XCTestExpectation(description: "async task called")
        let lock = DispatchSemaphore(value: 0)

        Task
        {
            #if os(macOS)
            let logger = Logger(subsystem: "testing", category: "testAcceptTask")
            #else
            let logger = Logger(label: "testing")
            #endif
            let listener = try AsyncTcpSocketListener(port: 1234, logger)
            lock.signal()
            let _ = try await listener.accept()
        }

        lock.wait()

        Task
        {
            asyncWorks.fulfill()
        }

        wait(for: [asyncWorks], timeout: 1)
    }
}

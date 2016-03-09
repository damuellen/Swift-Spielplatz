import XCTest

public class PlaygroundTestObserver : NSObject, XCTestObservation {
  @objc public func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {
    print("Test failed on line \(lineNumber): \(testCase.name), \(description)")
  }
}

public let center: XCTestObservationCenter = { center in
  center.addTestObserver(PlaygroundTestObserver())
  return center }(XCTestObservationCenter.sharedTestObservationCenter())

public class Tester {
  
  public init () {}
  
  public func runTests(testClass:AnyClass) {
    print("Running test suite \(testClass)")
    let tests = testClass as! XCTestCase.Type
    let testSuite = tests.defaultTestSuite()
    testSuite.runTest()
    let run = testSuite.testRun as! XCTestSuiteRun
    
    print("Ran \(run.executionCount) tests in \(run.testDuration)s with \(run.totalFailureCount) failures")
  }
}
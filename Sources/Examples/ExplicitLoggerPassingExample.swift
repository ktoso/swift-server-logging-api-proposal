import Foundation
import Logging

private class Client {
    func spawnFreshClient(uuid: UUID, logger: Logger) {
        var logger = logger
        logger[metadataKey: "UUID"] = uuid.description
        logger.info("we're up and running")
        let otherSubSystem = OtherSubSystem()
        otherSubSystem.randomFunction(logger: logger)
        logger.debug("random function returned")
    }
}

private class OtherSubSystem {
    func randomFunction(logger: Logger) {
        logger.debug("this propagates UUID and log level")
    }
}

enum ExplicitContextPassingExample {
    static func main() {
        Logging.bootstrap(ExampleValueLoggerImplementation.init)
        let logger = Logging.make("com.example.TestApp.ExplicitContextPassingExample.main")
        for clientID in 0 ..< 10 {
            var clientLogger = logger
            if clientID % 3 == 0 {
                clientLogger.logLevel = .debug
            } else {
                clientLogger.logLevel = .info
            }
            Client().spawnFreshClient(uuid: UUID(), logger: clientLogger)
        }
    }
}

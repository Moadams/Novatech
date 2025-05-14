package com.novatech.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoggerUtil {
    private static final Logger logger = Logger.getLogger(LoggerUtil.class.getName());
    private static final String LOG_FILE = "logs/log.txt";

    public void log(Level level, String message) {
        try {
            String timeStamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            String content = level + ": " + timeStamp + ": " + message + "\n";

            // Ensure directory exists
            Files.createDirectories(Paths.get("logs"));

            // Append to file
            Files.write(
                Paths.get(LOG_FILE),
                content.getBytes(),
                StandardOpenOption.CREATE,
                StandardOpenOption.APPEND
            );

        } catch (IOException e) {
            logger.log(Level.SEVERE, "Logging failed: " + e.getMessage(), e);
        }
    }

    public void logInfo(String message) {
        log(Level.INFO, message);
    }

    public void logError(String message, Throwable throwable) {
        log(Level.SEVERE, message + " | Exception: " + throwable.getMessage());
    }

    public void logWarning(String message) {
        log(Level.WARNING, message);
    }
}

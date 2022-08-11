"""CLI configuration."""
import os
import sys

LOGGING_LEVEL = os.getenv("LOGGING_LEVEL", "SUCCESS")
LOGGING_FORMAT = os.getenv("LOGGING_FORMAT", "HUMAN")

handler = {
    "level": LOGGING_LEVEL,
    "sink": sys.stdout,
}
if LOGGING_FORMAT == "HUMAN":
    handler["colorize"] = True
    handler["format"] = "{time} <level>{message}</level> | {extra}"
elif LOGGING_FORMAT == "JSONL":
    handler["format"] = "{message}"
    handler["serialize"] = True
else:
    raise ValueError("LOGGING_FORMAT can be only HUMAN or JSONL")
log_config = {"handlers": [handler]}

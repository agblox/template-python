"""CLI tool."""

from loguru import logger as log
import typer

from .helpers.cfg import log_config

cli = typer.Typer()
log.configure(**log_config)


@cli.command()
@log.catch(reraise=True)
def hello(name: str) -> str:
    """Hello command.

    Set LOGGING_LEVEL environment variable for change logging level from SUCCESS(default)  # noqa DAR

    Set LOGGING_FORMAT to JSONL if you need machine-readable log

    Raises ValueError if NAME John Dow

    """
    log.info("Started", command="hello", value=name)
    if name == "John Dow":
        raise ValueError(f"{name} not expected")
    message = f"Hello {name}111"
    log.success(message)
    return message


if __name__ == "__main__":
    cli()

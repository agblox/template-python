"""CLI tool test-suit."""
import pytest

from template_python.cli import hello


def test_hello():
    assert hello("test") == "Hello test111"


def test_exception():
    with pytest.raises(ValueError):  # noqa PT011
        hello("John Dow")

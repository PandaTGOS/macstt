from pathlib import Path
from subprocess import check_call

from setuptools import setup
from setuptools.command.build_py import build_py


ROOT = Path(__file__).resolve().parents[2]


class BuildHelper(build_py):
    def run(self):
        check_call([str(ROOT / "tools" / "build_helper.sh")])
        super().run()

setup(
    cmdclass={
        "build_py": BuildHelper,
    }
)
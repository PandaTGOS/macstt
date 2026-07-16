from pathlib import Path
from subprocess import check_call

from setuptools import setup
from setuptools.command.build_py import build_py


ROOT = Path(__file__).resolve().parent.parent


class BuildHelper(build_py):
    def run(self):
        check_call([str(ROOT / "scripts" / "build_helper.sh")])
        super().run()

setup(
    cmdclass={
        "build_py": BuildHelper,
    }
)
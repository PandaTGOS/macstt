from setuptools import setup

try:
    from setuptools.command.bdist_wheel import bdist_wheel
except ImportError:
    from wheel.bdist_wheel import bdist_wheel


class PlatformWheel(bdist_wheel):
    """Build a platform-specific, Python-version-independent wheel."""

    def finalize_options(self):
        super().finalize_options()
        self.root_is_pure = False

    def get_tag(self):
        return (
            "py3",
            "none",
            "macosx_11_0_arm64",
        )


setup(
    cmdclass={
        "bdist_wheel": PlatformWheel,
    }
)
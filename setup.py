"""
dragon-quant -- A-gu stock leader screener

Compatibility setup.py for environments with older setuptools.
"""
from setuptools import setup, find_packages

setup(
    name="dragon-quant",
    version="0.4.1",
    description="A-gu stock leader screener",
    long_description=open("README.md", encoding="utf-8").read(),
    long_description_content_type="text/markdown",
    author="gitBingxu",
    url="https://github.com/gitBingxu/dragon-quant",
    license="MIT",
    packages=find_packages(include=["dragon_quant", "dragon_quant.*", "web_ui", "web_ui.*"]),
    package_data={"web_ui": ["dist/**/*"]},
    install_requires=[],
    python_requires=">=3.8",
    entry_points={
        "console_scripts": [
            "dragon-quant=dragon_quant.cli:main",
        ],
    },
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Financial and Insurance Industry",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.12",
        "Topic :: Office/Business :: Financial :: Investment",
    ],
)

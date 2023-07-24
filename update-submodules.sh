#!/bin/bash

git submodule update --init --recursive && \
git submodule update --recursive --remote && \
git submodule update --recursive && \
git pull --recurse-submodules

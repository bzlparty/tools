#!/usr/bin/env bash

sed "s|0.0.0|%VERSION%|" "%SRC%" > "%OUT%"

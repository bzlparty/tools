#!/usr/bin/env bash

_xsv_ cat rows "$@" |
_utils_ tail +2 |
_goawk_ -f _assets_awk_ > _out_


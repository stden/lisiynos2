#!/bin/bash
gawk -f listproblems.awk problems/*/statement/*.tex >problems.cfg

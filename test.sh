#!/bin/env bash
echo $(find org/post -name *.org | sed s:org/:content/: | sed s/.org/.md/)

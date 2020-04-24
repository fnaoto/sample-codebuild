#!/bin/bash

set -x

#
# 引数の個数チェック
#
if [ "$#" -ne "3" -a "$#" -ne "4" ]; then
  echo "\nInvalid arguments\nUsage: trigger is (release|merge [branch]|pr) ? \n";
  exit 1;
fi;

if [ "$2" = "release" ]; then
  if [ "${CODEBUILD_WEBHOOK_TRIGGER:-none}" == "tag/*" ]; then
    exit 0;
  fi;
fi;

if [ "$2" = "merge" ]; then
  if [ "${CODEBUILD_WEBHOOK_HEAD_REF#refs/heads/}" == "$3" ]; then
    exit 0;
  fi;
fi;

if [ "$2" = "pr" ]; then
  if [ "${CODEBUILD_WEBHOOK_TRIGGER:-none}" == "pr/*" ]; then
    exit 0;
  fi;
fi;

exit 1;

#!/bin/bash

export GRADLE_OPTS="-Dorg.gradle.daemon=false"

exec ./gradlew clean build || exit 1

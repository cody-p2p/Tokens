$ bash autogen.sh

#!/bin/bash

# Set the project name and version
PROJECT_NAME="MyProject"
PROJECT_VERSION="1.0"

# Set the source files and headers
SRC_FILES="src/main.cpp src/utils.cpp"
HDR_FILES="src/utils.h"

# Set the build flags
CXXFLAGS="-g -O2 -Wall"
LDFLAGS="-L. -lmylib"

# Generate the configure.ac file
cat > configure.ac <<EOF
AC_INIT([$PROJECT_NAME], [$PROJECT_VERSION])
AC_CONFIG_SRCDIR([src/main.cpp])
AC_CONFIG_HEADERS([config.h])

AC_PROG_CXX
AC_PROG_CC
AC_PROG_CPP
AC_PROG_LIBTOOL

AC_CHECK_HEADERS([${HDR_FILES}])

AC_SUBST(CXXFLAGS)
AC_SUBST(LDFLAGS)

AC_OUTPUT([Makefile])
EOF

# Generate the Makefile
cat > Makefile <<EOF
# Makefile for $PROJECT_NAME

CXXFLAGS = $CXXFLAGS
LDFLAGS = $LDFLAGS

all: myprogram

myprogram: $(SRC_FILES)
    $(CXX) $(CXXFLAGS) -o $@ $^

clean:
    rm -f myprogram
EOF

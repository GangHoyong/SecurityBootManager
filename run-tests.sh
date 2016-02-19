#!/bin/bash
tests_path="`pwd`/tests"
if test -e $tests_path; then
  # get all test cpp files
  compile_list=`ls -l $tests_path | grep ^- | awk '{split($0,arr," "); print arr[9];}'`
  for x in $compile_list
  do
    # check test-shell source files
    if [ "$x" != "test_shell.cpp" ]; then
      is_source_file=`echo $x | grep -E "(cpp|c)$"`
      if test -n "$is_source_file"; then
        # build and execute
        build_command="g++ -o $tests_path/tests $tests_path/test_shell.cpp $tests_path/$x"
        exec_command="$tests_path/tests"
        #echo $build_command
        #echo $exec_command
        `$build_command`
        `$exec_command`

        result=$?
        if [ "$result" != "0" ]; then
          echo "$x($result): exit $result"
          exit $result
        fi
      fi
    fi
  done
fi

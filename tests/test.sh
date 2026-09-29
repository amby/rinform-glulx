#!/bin/bash

inform +../library,../libext +language_name=Russian -DG -Cu '$DICT_CHAR_SIZE=4' -Cu '$DICT_WORD_SIZE=12' -D _Sources/ambiguity.inf
inform +../library,../libext +language_name=Russian -DG -Cu '$DICT_CHAR_SIZE=4' -Cu '$DICT_WORD_SIZE=12' -D _Sources/basic_meta_verbs.inf
inform +../library,../libext +language_name=Russian -DG -Cu '$DICT_CHAR_SIZE=4' -Cu '$DICT_WORD_SIZE=12' -D _Sources/declension.inf
inform +../library,../libext +language_name=Russian -DG -Cu '$DICT_CHAR_SIZE=4' -Cu '$DICT_WORD_SIZE=12' -D _Sources/test.inf
inform +../library,../libext +language_name=Russian -DG -Cu '$DICT_CHAR_SIZE=4' -Cu '$DICT_WORD_SIZE=12' -D _Sources/walking.inf
inform +../library,../libext +language_name=Russian -DG -Cu '$DICT_CHAR_SIZE=4' -Cu '$DICT_WORD_SIZE=12' -D _Sources/scoring.inf
inform +../library,../libext +language_name=Russian -DG -Cu '$DICT_CHAR_SIZE=4' -Cu '$DICT_WORD_SIZE=12' -D _Sources/system.inf

REGTEST_FAIL=0
regtest() {
  testfile=$1
  echo "" >> test.out
  echo "=== ${testfile} ===" | tee -a test.out
  if ! python3 ./regtest.py "${testfile}" --vital >> test.out 2> >(tee -a test.out >&2); then
    REGTEST_FAIL=1
  fi
}

: > test.out
regtest _Tests/test.test
regtest _Tests/walking.test
regtest _Tests/basic_meta_verbs.test
regtest _Tests/ambiguity.test
regtest _Tests/declension.test
regtest _Tests/scoring.test
regtest _Tests/system.test

if [ "${REGTEST_FAIL}" -ne 0 ]; then
  echo "Regtest failed (see test.out)." >&2
  exit 1
fi

echo "All regtests passed." >&2

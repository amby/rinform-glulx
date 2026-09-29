#!/bin/bash

TESTS=(test walking basic_meta_verbs ambiguity declension scoring system)

for name in "${TESTS[@]}"; do
  inform +../library,../libext +language_name=Russian -DG -Cu '$DICT_CHAR_SIZE=4' -Cu '$DICT_WORD_SIZE=12' -D "_Sources/${name}.inf"
done

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
for name in "${TESTS[@]}"; do
  regtest "_Tests/${name}.test"
done

if [ "${REGTEST_FAIL}" -ne 0 ]; then
  echo "Regtest failed (see test.out)." >&2
  exit 1
fi

echo "All regtests passed." >&2

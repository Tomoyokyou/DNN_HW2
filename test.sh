DATADIR=/home/hui/model/
TESTDIR=/home/hui/model/test/
TESTFILE=${TESTDIR}test_norm.svm
RESULT=./result/
MODEL=./model/out.mdl
OUTFILE=${RESULT}testResult.seq
DIM=69
FEATTYPE=0

mkdir -p ${RESULT}

./svm_struct/svm_empty_classify.app -x ${DIM} -z ${FEATTYPE} ${TESTFILE} ${MODEL} ${OUTFILE}

./bin/svmTrim.app ${OUTFILE} ${DATADIR}raw/test.ark ${DATADIR}char_48to39.map ${RESULT}output.kaggle


DATADIR=/home/hui/model/
TESTDIR=/home/hui/model/test/
TESTFILE=${TESTDIR}test_norm.svm
RESULT=./result/
MODEL=./model/out.mdl
OUTFILE=${RESULT}testResult.seq
DIM=69
FEATTYPE=0
KAGGLE=${RESULT}output.kaggle

mkdir -p ${RESULT}

./svm_struct/svm_empty_classify.app -x ${DIM} -z ${FEATTYPE} ${TESTFILE} ${MODEL} ${OUTFILE}
echo "Trimming output label sequence..."
./bin/svmTrim.app ${OUTFILE} ${DATADIR}raw/test.ark ${DATADIR}char_48to39.map ${KAGGLE}
echo "end of testing, see result: ${KAGGLE}"

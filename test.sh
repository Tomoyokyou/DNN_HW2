DATADIR=/home/hui/model/
TESTDIR=/home/hui/model/test/
MODELDIR=./model
TESTFILE=${TESTDIR}test_norm.svm
TEST=/home/jason/MachineLearningDNNCourse/model/testFtre_orig_256_acc55.txt
RESULT=./result/
MODEL=./model/out.mdl
OUTFILE=${RESULT}testResult.seq

mkdir -p ${RESULT}

./svm_struct/svm_empty_classify.app ${TESTFILE} ${MODEL} ${OUTFILE}

./bin/svmTrim.app ${OUTFILE} ${DATADIR}raw/test.ark ${DATADIR}char_48to39.map ${RESULT}output.kaggle


DATADIR=/home/hui/model/
TESTDIR=/home/hui/model/test/
MODELDIR=./model
TESTFILE=${TESTDIR}test_norm.svm
TESTFILE_GENDER=${TESTDIR}test_gender_norm.svm
MODELFILE=${MODELDIR}/    #put modelfile here
OUTFILE=testResult.csv

./svm_struct/svm_empty_classify.app ${TESTFILE} ${MODELFILE} ${OUTFILE}
make svmTrim
./bin/svmTrim.app ${OUTFILE} ${DATADIR}raw/test.ark ${DATADIR}char48_39.map result.csv


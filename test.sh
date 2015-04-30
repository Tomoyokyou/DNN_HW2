DATADIR=/home/hui/model/
TESTDIR=/home/hui/model/test/
MODELDIR=./model
TESTFILE=${TESTDIR}test_norm.svm
TESTFILE_GENDER=${TESTDIR}test_gender_norm.svm
MODELFILE=${MODELDIR}/1c.mdl    #put modelfile here
OUTFILE=testResult.txt

./svm_struct/svm_empty_classify.app ${TESTFILE} ${MODELFILE} ${OUTFILE}
make svmTrim
./bin/svmTrim.app ${OUTFILE} ${DATADIR}raw/test.ark ${DATADIR}char_48to39.map result.csv


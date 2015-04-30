DATADIR=/home/hui/model/
TESTDIR=/home/hui/model/test/
MODELDIR=./model
TESTFILE=${TESTDIR}test_norm.svm
TESTFILE_GENDER=${TESTDIR}test_gender_norm.svm
#MODELFILE=${MODELDIR}/1c.mdl    #put modelfile here
RESULT=../svm_result/
MODELFILE=/home/jason/DNN_HW2/model/output.txt
#MODELFILE=/home/larry/Documents/MLDS/DNN_HW2/model/test.mdl.orig
OUTFILE=${RESULT}testResult.txt
mkdir -p ${RESULT}
./svm_struct/svm_empty_classify.app ${TESTFILE_GENDER} ${MODELFILE} ${OUTFILE}
make svmTrim
./bin/svmTrim.app ${OUTFILE} ${DATADIR}raw/test.ark ${DATADIR}char_48to39.map ${RESULT}result.csv


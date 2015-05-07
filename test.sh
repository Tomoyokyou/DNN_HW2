FEATDIR=./deeplearningHW2_data/
TESTFILE=${FEATDIR}testFtre_orig_256_acc60.txt
RESULT=./result/
MODEL=./model/out.mdl
OUTFILE=${RESULT}testResult.seq
DIM=325
FEATTYPE=0
KAGGLE=output.kaggle

mkdir -p ${RESULT}

./svm_struct/svm_empty_classify.app -x ${DIM} -z ${FEATTYPE} ${TESTFILE} ${MODEL} ${OUTFILE}
echo "Trimming output label sequence..."
./bin/svmTrim.app ${OUTFILE} ${FEATDIR}test.ark ${FEATDIR}char_48to39.map ${KAGGLE}
echo "end of testing, see result: ${KAGGLE}"

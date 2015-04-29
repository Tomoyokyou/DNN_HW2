C=0.01
kernel_type=0
order=1;
epsilon=0.05;
#TRAIN=/home/hui/model/u10.ark
TEST=/home/hui/model/test/test_gender.svm
TRAIN=/home/hui/model/train/svm_fbank.ark
MODEL=./model/test.mdl
OUTPUT=./model/output.txt
mkdir -p model
./svm_struct/svm_empty_learn.app -c ${C} -t ${kernel_type} -d ${order} -e ${epsilon} ${TRAIN} ${MODEL} 
./svm_struct/svm_empty_classify.app ${TEST} ${MODEL} ${OUTPUT}

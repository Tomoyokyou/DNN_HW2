C=5
kernel_type=0
order=1
epsilon=0.05
loss_type=1
#=====================
#TEST=/home/hui/model/u10.ark
TEST=/home/hui/model/test/test_gender_norm.svm
TRAIN=/home/hui/model/train/train_gender_norm.svm
MODEL=/home/jason/DNN_HW2/model/test${C}.mdl
OUTPUT=./model/output.txt
mkdir -p model
./svm_struct/svm_empty_learn.app -c ${C} -t ${kernel_type} -d ${order} -e ${epsilon} -l ${loss_type} ${TRAIN} ${MODEL} 
#./svm_struct/svm_empty_classify.app ${TEST} ${MODEL} ${OUTPUT}

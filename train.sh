C=0.1
kernel_type=0
order=1
epsilon=0.01
loss_type=1
#=====================
TEST=/home/hui/model/u10.ark
TRAIN=/home/hui/model/u10.ark
#TEST=/home/hui/model/test/test_gender_norm.svm
#TRAIN=/home/hui/model/train/train_gender_norm.svm

MODEL=./model/test_${C}_${epsilon}.mdl
OUTPUT=./model/${C}_${epsilon}.seq
mkdir -p model
mkdir -p log
./svm_struct/svm_empty_learn.app -c ${C} -t ${kernel_type} -d ${order} -e ${epsilon} -l ${loss_type} ${TRAIN} ${MODEL} | tee ./log/${C}_${epsilon}.log
./svm_struct/svm_empty_classify.app ${TEST} ${MODEL} ${OUTPUT}

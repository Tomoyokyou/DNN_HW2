C=0.1
kernel_type=0
order=1
epsilon=0.01
loss_type=1
#TEST=/home/hui/model/u10.ark
#TRAIN=/home/hui/model/u10.ark
TEST=/home/hui/model/test/test_gender_norm.svm
TRAIN=/home/hui/model/train/train_gender_norm.svm

DIM=69
FEATTYPE=1

MODEL=./model/test_${C}_${epsilon}_hui.mdl
OUTPUT=./model/${C}_${epsilon}_hui.seq
#=====================
#TRAIN=/home/hui/model/u10.ark
#MODEL=./model/temp.mdl
#OUTPUT=./model/temp.seq
mkdir -p model
mkdir -p log
./svm_struct/svm_empty_learn.app -c ${C} -t ${kernel_type} -d ${order} -e ${epsilon} -l ${loss_type} -x ${DIM} -z ${FEATTYPE} ${TRAIN} ${MODEL} | tee ./log/${order}_${C}_${epsilon}_${loss_type}.log
./svm_struct/svm_empty_classify.app ${TEST} ${MODEL} ${OUTPUT}

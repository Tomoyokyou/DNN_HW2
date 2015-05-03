C=1
kernel_type=0
order=1
epsilon=0.05
loss_type=2
#=====================
#TRAIN=/home/hui/model/u10.ark
TEST=/home/hui/model/test/test_gender_norm.svm
TRAIN=/home/hui/model/train/train_gender_norm.svm
MODEL=./model/order${order}_${C}_${epsilon}_${loss_type}.mdl
#MODEL=./model/temp.mdl
OUTPUT=./model/order${order}_${C}_${epsilon}_${loss_type}.seq
#OUTPUT=./model/temp.seq
mkdir -p model
mkdir -p log
./svm_struct/svm_empty_learn.app -c ${C} -t ${kernel_type} -d ${order} -e ${epsilon} -l ${loss_type} ${TRAIN} ${MODEL} | tee ./log/${order}_${C}_${epsilon}_${loss_type}.log
./svm_struct/svm_empty_classify.app ${TEST} ${MODEL} ${OUTPUT}

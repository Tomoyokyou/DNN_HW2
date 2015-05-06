C=1
kernel_type=0
order=1
epsilon=1
loss_type=2
TRAIN=/home/hui/model/train/train_norm.svm

DIM=69
FEATTYPE=0
MODEL=./model/out.mdl

mkdir -p model
mkdir -p log

./svm_struct/svm_empty_learn.app -c ${C} -t ${kernel_type} -d ${order} -e ${epsilon} -l ${loss_type} -x ${DIM} -z ${FEATTYPE} ${TRAIN} ${MODEL} | tee ./log/${order}_${C}_${epsilon}_${loss_type}.log

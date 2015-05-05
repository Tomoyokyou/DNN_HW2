C=5
kernel_type=0
order=1
epsilon=0.1
loss_type=1
#=====================
#TRAIN=/home/hui/model/u10.ark
#TEST=/home/hui/model/train/train_gender_norm.svm
#TRAIN=/home/hui/model/train/train_gender_norm.svm
TRAIN=/home/jason/MachineLearningDNNCourse/model/trainFtre_orig.txt
TEST=/home/jason/MachineLearningDNNCourse/model/testFtre_orig.txt
#MODEL=./model/hidden_orig_${C}_${epsilon}.mdl
#MODEL=/home/larry/Documents/MLDS/DNN_HW2/model/test_10_0.05.mdl
OUTPUT=./model/hidden_orig_${C}_${epsilon}.seq
#OUTPUT=./model/temp.seq
mkdir -p model
mkdir -p log
./svm_struct/svm_empty_learn.app -c ${C} -t ${kernel_type} -d ${order} -e ${epsilon} -l ${loss_type} ${TRAIN} ${MODEL} | tee ./log/${C}_${epsilon}.log

#./svm_struct/svm_empty_classify.app ${TEST} ${MODEL} ${OUTPUT}

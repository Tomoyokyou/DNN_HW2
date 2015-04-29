RATE=0.002
BSIZE=256
MAXEPOCH=20000
MOMENTUM="0 0.3 0.6 0.9"
DECAYSET="1 0.9 0.81 0.72"
DECAY=1
INITMODEL=model/momentExpInit.mdl
MODELDIR=model/initexp
UNIRANGE="0.1 0.5 1 2";
# ====== new parameters
C=0.01
#TRAIN=/home/hui/model/u10.ark
TEST=/home/hui/model/test/test_gender.svm
TRAIN=/home/hui/model/train/train_gender_norm.svm
MODEL=./model/test.mdl
OUTPUT=./model/output.txt
mkdir -p model
./svm_struct/svm_empty_learn.app -c ${C} ${TRAIN} ${MODEL} 
./svm_struct/svm_empty_classify.app ${TEST} ${MODEL} ${OUTPUT}

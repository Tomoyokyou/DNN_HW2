#=====================
#TRAIN=/home/hui/model/u10.ark
TRAIN=/home/hui/model/train/train_gender_norm.svm
OUTPUT_TRAIN=./validate/valTrain.svm
OUTPUT_TEST=./validate/valTest.svm
PROPORTION=0.8
mkdir -p validate

./bin/svmValGen.app ${TRAIN} ${PROPORTION} ${OUTPUT_TRAIN} ${OUTPUT_TEST}

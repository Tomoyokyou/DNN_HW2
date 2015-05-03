#=====================
INPUT=/home/ahpan/DeepLearningHW2/DNN_HW2/Data/MLDS_HW1_RELEASE_v1/fbank/test_gender_norm.svm
OUTPUT=/home/ahpan/DeepLearningHW2/DNN_HW2/Data/MLDS_HW1_RELEASE_v1/fbank/test_gender_norm_frame_9.svm
FRAMENUM=9
mkdir -p validate

./bin/makeFrameData.app ${INPUT} ${OUTPUT} ${FRAMENUM}

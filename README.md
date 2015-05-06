# 				Structured SVM program

---------------------------------------------------------------------------------------------------

Environment requirement:  

	Linux platform recommended, C/C++ compiler needed.  

---------------------------------------------------------------------------------------------------  

Authors:

	Jason Wu, Larry Tsai, Tom Huang, Pan Po-chen  

	National Taiwan Unversity, Electrical Engineering department.  

---------------------------------------------------------------------------------------------------

Quick start:

	  Once all requirements are met, type "make" at main directory will compile all executables.

	Shell scripts are provided also, you may need to change some paths in it.

	Sample data are included, type "make run" after "make", it shall start the whole process of

	structured SVM, the result named "output.kaggle" will be at the directory /result.

---------------------------------------------------------------------------------------------------	

Makefile:

	-run:
		after all executables are compiled, run scripts and generate structured SVM result.	

	-all:
		compile all object and executables.

	-structSvm:
		compile struct_svm/struct_light api packages.

	-svmGen:
		compile a program "bin/svmFeatureGen.app" to generate required feature format for

		structured SVM. See below for detail.

	-featNorm:
		compile "bin/featNorm.app" to normalize raw features to zero mean unit variance.

	-svmTrim:
		compile "bin/svmTrim.app" to trim result of struct svm classification.

	-svmValGen:
		compile "bin/svmValGen.app" separate features to training set and validation set.

	-makeFrameData:	
		compile "bin/makeFrameData.app" splice features to take frames before and after

		into account.
----------------------------------------------------------------------------------------------------

Notes:

1.Some directories must be built up before compiling, such as: obj/ bin/ or you can simply enter:  

					make dir  

2.Before "make run" please make sure feature are included in train.sh/test.sh

	Feature format for this program:
		
			speakerId_utterencename_frameid feat1 feat2 ........  
	
	For detail, you can run this program with no arguments, it will show its usage.  

3.Some example files could help you to run this program. Check them out in ./example/  

4.the core of this program combined two api, svm_struct and svm_light, you can see README in

  svm_struct/ for copyright issues.  
 
----------------------------------------------------------------------------------------------------- 

Scripts:

	-train.sh:
		
	  This script will run struct_svm_empty_learn.app to train a model with desired 
	
	parameters, paths for training feature need configuration:

	1. [line 6] TRAIN=[ your training features path ]

	2. other variables are:
	
	3. [line 1] C=1 : scaling margin
	
	4. [line 4] epsilon=1 : error tolerance
	
	5. [line 5] loss_type: 0>   1>   2>

	6. [line 8] DIM: feature dimension    

	7. [line 9] FEATTYPE: 0> normal patterns 1> dummy 1 add at the end of pattern
	
	-test.sh:
	  
	  Run svm_struct_empty_classify.app and generate kaggle upload format result
	
	features file path and feature name raw archieve need configuration.

	1. [line 1] DATADIR=[ your feature directory ]

	2. [line 2] TESTDIR=[ your testing set path ]

	3. [line 3] TESTFILE=${TESTDIR}[ add your testing file name ]

	5. [line 5] MODEL=[ put your structured SVM model file name ]

------------------------------------------------------------------------------------------------------

Other programs:

	  After compilation, programs will be in directory "bin/", you can run these programs

	without argument, they will show usages to you.

	-svmFeatureGen.app:
		
		merge label and features together to generate required format for structured SVM.
	
	since testing features has no label, option --train/--test must be given. Provided 

	training set, label archieve and label map must be given.
	
	-featNorm.app:

		normalize features in each dimention to zero mean, unit variance.

	-svmTrim.app:

		Trim infered sequences of structured SVM model and generate Kaggle upload format result,

	original test.ark needed, this program is included in test.sh, you can also see it in test.sh
	
	to know the usage of this program.

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

	  Once all requirements are met, type "make" at main directory to start compilation for all
	
	executables. Shell scripts are also provided, you may need to change some paths in it.

	With sample data included, type "make run" after "make", it shall start the whole process of

	structured SVM program, the result named "output.kaggle" will be at the directory /result.

---------------------------------------------------------------------------------------------------	

Makefile:

	-run:
		after all executables are compiled, run scripts and generate structured SVM result.	

	-all:
		compile all objects and executables.

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

1.Some directories must be built up before compilation, such as: obj/ bin/ or you can simply enter:  

					make dir  

2.Before "make run", please make sure features path are correct in train.sh/test.sh

	Feature format for this program:
		
			speakerId_utterencename_frameid feat1 feat2 ........  
	
	To see usage, you can run executables with no arguments, it will show you how to run it properly.  

3.Some example files could help you run this program. Check them out in ./example/  

4.The core of this program combined two api packages, svm_struct and svm_light, you can see README in

  svm_struct/ for copyright issues.  
 
----------------------------------------------------------------------------------------------------- 

Scripts:

	-train.sh:
		
	  This script will run struct_svm_empty_learn.app to train a model with desired 
	
	parameters, paths for training feature need configuration:

	1. [line 6] TRAIN=[ your training features path ]

	other variables are:
	
	2. [line 1] C=1 : scaling margin
	
	3. [line 4] epsilon=1 : error tolerance
	
	4. [line 5] loss_type: 0>   1>   2>

	5. [line 8] DIM: feature dimension    

	6. [line 9] FEATTYPE: 0> normal patterns 1> dummy 1 add at the end of pattern
	
	-test.sh:
	  
	  Run svm_struct_empty_classify.app and generate kaggle upload format result if
	
	features file paths configured properly.

	1. [line 1] DATADIR=[ your feature directory ]

	2. [line 2] TESTDIR=[ your testing set path ]

	3. [line 3] TESTFILE=${TESTDIR}[ add your testing file name ]

	4. [line 5] MODEL=[ put your structured SVM model file name ]

------------------------------------------------------------------------------------------------------

Other programs:

	  After compilation, executables will be in directory "bin/", you can run these programs

	without argument, they will show usages to you.

	-svmFeatureGen.app:
		
		merge label and features together to generate required format for structured SVM.

	For training features:
	
	command ./svmFeatureGen.app <featureFile> --train <labelFile> <labelMap> <outputFile>
	
	Since testing features have no label, only feature file is needed:
	
	command: ./svmFeatureGen.app <featureFile> --test <outputFile>
	
	-featNorm.app:

		normalize features in each dimention to zero mean, unit variance.

	-svmTrim.app:

		Trim infered sequences of structured SVM model and generate Kaggle upload format result,

	original test.ark is needed, this program is also included in test.sh. See it then you'll know 

	how to run svmTrim.app!

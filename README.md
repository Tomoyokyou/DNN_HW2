# Structured SVM program
---
Environment requirement:  
---
*Linux platform recommended, C/C++ compiler needed.*  
Authors:
---  
*Jason Wu, Larry Tsai, Tom Huang, Ahpan*  
*National Taiwan Unversity, Electrical Engineering department.*  

	Once all requirements are met, type "make" at main directory will compile all executables.
	Shell scripts are provided also, you may need to change some paths in it.
	Sample data are included, type "make run" after "make", it shall start the whole process of
	structured SVM, the result named "output.kaggle" will be at directory /result
	
Notes:
---
1.Some directories must be built up before compiling, such as: obj/ bin/ or you can simply enter:  
make dir  

2.The format of features in this program can be generated by a executable: bin/svmFeatureGen.app.  
-Format for this program: speakerId\_utterencename\_frameid feat1 feat2 ........  
-For detail, you can run this program with no arguments, it will show its usage.  
-For compilation, enter: make svmGen  
3.Some example files could help you to run this program.  
Check them out in ./example/  

4.the core of this program combined two api, svm\_struct and svm\_light, you can see README in
svm\_struct/ for copyright issues.  
 
 

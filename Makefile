CC=gcc
CXX=g++
CPPFLAGS=-std=c++11 -O2
NVCFLAGS=-Xcompiler -fPIC -std=c++11
SVMDIR=tool/svm_struct/
# ================================
# = 		ADD EXE HERE         =
# ================================
EXECUTABLES=svmGen featNorm svmTrim

# +==============================+
# +======== Phony Rules =========+
# +==============================+

.PHONY: debug all clean 
all:dir $(EXECUTABLES)
	cd svm_struct; make
run:train.sh test.sh
	@echo "Training structured SVM model..."
	@sh train.sh
	@echo "Tesing and generate Kaggle upload file..."
	@sh test.sh

debug:CPPFLAGS+=-g

vpath %.cpp example/

	 
#=============APP================================
svmGen: example/svmFeatureGen.cpp
	$(CXX) $(CPPFLAGS) -o bin/svmFeatureGen.app $^
featNorm: example/featureNorm.cpp
	$(CXX) $(CPPFLAGS) -o bin/featNorm.app $^
svmTrim: example/svmTrimming.cpp
	$(CXX) $(CPPFLAGS) -o bin/svmTrim.app $^
svmValGen: example/svmValidationGen.cpp
	$(CXX) $(CPPFLAGS) -o bin/svmValGen.app $^
makeFrameData: example/makeFrameData.cpp
	$(CXX) $(CPPFLAGS) -o bin/makeFrameData.app $^
structSvm: svm_empty_learn svm_empty_classify
svm_empty_learn: 
	@cd svm_struct; make svm_empty_learn; cd ..
svm_empty_classify:
	@cd svm_struct; make svm_empty_classify; cd ..
#===========UTIL==========
dir:
	@cd svm_struct; make dir; cd ..
	@mkdir -p obj; mkdir -p bin; mkdir -p model

ctags:
	@cd svm_struct; make ctags; cd ..
	@rm -f src/tags tags
	@echo "Tagging main directory"
	@ctags -a svm_struct/* svm_struct/src/* svm_struct/include/*\
         svm_struct/svm_struct/* svm_struct/svm_light/* svm_struct/svm_struct/include/*

clean:
	@echo "All objects and executables removed"
	@rm -f $(EXECUTABLES) obj/* bin/*
	@cd svm_struct; make clean; cd ..

# +==============================+
# +===== Other Phony Target =====+
# +==============================+
obj/%.o: src/%.cpp include/%.h
	@echo "compiling OBJ: $@ " 
	@$(CXX) $(CPPFLAGS) $(INCLUDE) -o $@ -c $<


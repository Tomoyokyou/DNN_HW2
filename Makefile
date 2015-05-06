CC=gcc
CXX=g++
NVCC=nvcc -arch=sm_21 -w
CPPFLAGS=-std=c++11 -O2
NVCFLAGS=-Xcompiler -fPIC -std=c++11
CUDADIR=/usr/local/cuda/
LIBCUMATDIR=tool/libcumatrix/
SVMDIR=tool/svm_struct/
OBJ=obj/svmset.o
# ================================
# = 		ADD EXE HERE         =
# ================================
EXECUTABLES=svmGen featNorm svmTrim

# +==============================+
# +======== Phony Rules =========+
# +==============================+

.PHONY: debug all clean 
all:$(EXECUTABLES)
	cd svm_struct; make

LIBS=$(LIBCUMATDIR)lib/libcumatrix.a

$(LIBCUMATDIR)lib/libcumatrix.a:
	@echo "Missing library file, trying to fix it in tool/libcumatrix"
	@cd tool/libcumatrix/ ; make ; cd ../..

debug:CPPFLAGS+=-g

vpath %.h include/
vpath %.cpp src/
vpath %.cu src/

INCLUDE= -I include/\
	 -I $(LIBCUMATDIR)include/\
	 -I $(CUDADIR)include/\
	 -I $(CUDADIR)samples/common/inc/\
	 
LD_LIBRARY=-L$(CUDADIR)lib64 -L$(LIBCUMATDIR)lib
LIBRARY=-lcuda -lcublas -lcudart

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

obj/datasetJason.o: src/datasetJason.cpp include/dataset.h 
	@echo "compiling OBJ: $@ "
	@$(CXX) $(CPPFLAGS) $(INCLUDE) -o $@ -c $<

obj/%.o: %.cu
	@echo "compiling OBJ: $@ "
	@$(NVCC) $(NVCCFLAGS) $(INCLUDE) -o $@ -c $<


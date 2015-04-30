#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <map>
#include <algorithm>
#include <ctime>
#include <cstdlib>



using namespace std;

void myUsage(){
	cout<<"validationGen.app <trainFile> <trainProportion> <outTrainset> <outTestset>\n";
}
int myrandom(int i){
	return rand()%i;
}


int main(int argc, char *argv[])
{
	if(argc!=5){
		myUsage();
		return 1;
	}
	char* in = argv[1];
	float trainProportion = atof(argv[2]);	
	char* outTrain = argv[3];
	char* outTest = argv[4];
	
	//map<string, vector<string>> trainMap;
	string str;


	ifstream fin(in, ifstream::in);
	if(!fin){
		cerr<<"ERROR:no train file...\n";
		return 1;
	}
	cout<<"Reading train file "<<in<<" ...";
	size_t lineNum =1;
	string utterance ="";
	size_t utteranceNum = 0, tmpUtteranceNum = 0;
	vector<string> utteranceFeature;
	vector<string> utteranceName;
	vector<int> utteranceLength;
	vector<vector<string>> allUtteranceFeature;
	vector<string> utteranceNameWithNum;
	
	while(getline(fin, str)){
		if(lineNum!=1){
			if(str.find("<")!=string::npos){
				utteranceNameWithNum.push_back(str);
				size_t pos1 = str.find("<");
				size_t pos2 = str.find(">");
				utterance = str.substr(pos1+1,pos2-pos1-1);
			//	utteranceName.push_back(utterance);
				size_t pos3 = str.find_last_of(" ");		
				utteranceNum = atoi(str.substr(pos3+1).c_str());
			//	utteranceLength.push_back(utteranceNum);
			}
			else{
				tmpUtteranceNum++;
				utteranceFeature.push_back(str);
				if(tmpUtteranceNum == utteranceNum){
					//trainMap.insert(pair<string, vector<string>>(utterance ,utteranceFeature));
					allUtteranceFeature.push_back(utteranceFeature);
					tmpUtteranceNum = 0;
					utteranceFeature.clear();
				}	
			
			}
		}
		lineNum++;
	}	
	
	fin.close();
	cout<<"done!\n";

	size_t allUtterNum = utteranceNameWithNum.size();
	size_t trainsetNum = allUtterNum*trainProportion;
	size_t testsetNum = allUtterNum - trainsetNum;
	cout<<"# of all utterances : "<<allUtterNum<<endl;	

	srand(unsigned(time(0)));
	vector<int> randomNum;
	int ranTrainArr[trainsetNum];
	int ranTestArr[testsetNum];

	int ri;
	cout<<"Make random number array...";
	for( ri=1;ri<=allUtterNum;ri++) randomNum.push_back(ri);
	random_shuffle(randomNum.begin(),randomNum.end(),myrandom);
	cout<<"done\n";

	
	cout<<"Make train random number array...";
	
	for(int i =0;i<trainsetNum;i++){	
		ranTrainArr[i] = randomNum.at(i)-1;
	}

	cout<<"done\n";
	cout<<"Make test random number array...";
	for(int i =0;i<testsetNum;i++){
	
		ranTestArr[i] = randomNum.at(i+trainsetNum);
	}


	cout<<"done\n";
	//Make trainset
	ofstream ftrain(outTrain);
	cout<<"# of utterance in trainset : "<<trainsetNum<<endl;
	cout<<"Make trainset....";
	
	ftrain<<"[training]\n";
	for(int i=0;i<trainsetNum;i++){
		ftrain<<utteranceNameWithNum.at(ranTrainArr[i])<<endl;
		vector<string> tmpUtteranceFeature=allUtteranceFeature.at(ranTrainArr[i]);
		for(int j=0;j<tmpUtteranceFeature.size();j++){
			ftrain<<tmpUtteranceFeature.at(j)<<endl;
		}	
	}	

	ftrain.close();
	cout<<"done!\n";
		
	
	//Make testset
	ofstream ftest(outTest);
	cout<<"# of utterance in testset : "<<testsetNum<<endl;
	cout<<"Make testset....";
	ftest<<"[training]\n";
	
	for(int i=0;i<testsetNum;i++){
		ftest<<utteranceNameWithNum.at(ranTestArr[i])<<endl;
		vector<string> tmpUtteranceFeature=allUtteranceFeature.at(ranTestArr[i]);
		for(int j=0;j<tmpUtteranceFeature.size();j++){
			ftest<<tmpUtteranceFeature.at(j)<<endl;
		}	
	}	


	ftest.close();
	cout<<"done\n";

	
	cout<<"Done.\n";
	return 0;
}

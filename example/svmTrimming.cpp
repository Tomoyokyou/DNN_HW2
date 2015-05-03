#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <cstdlib>

using namespace std;

void parseOptions(string str,vector<string>& vout){
	string hold;
	size_t begin=str.find_first_not_of(' '),end;
	while(begin!=string::npos){
		end=str.find_first_of(' ',begin);
		if(end==string::npos)
			hold=(begin==str.find_last_not_of(' '))? str.substr(begin,1) : str.substr(begin,str.find_last_not_of(' ')-begin);
		else
			hold=str.substr(begin,end-begin);
		if(!hold.empty())
			vout.push_back(hold);
		begin=(end==string::npos)? string::npos : str.find_first_not_of(' ',end);
	}
}

string parseName(string str){
	size_t begin=str.find_first_not_of(' '),end;
	string out="noname";
	if(begin!=string::npos){
		end=str.find_first_of(' ');
		if(end==string::npos)
			out=(str.find_last_not_of(' ')==begin)? str.substr(begin,1) : str.substr(begin,str.find_last_not_of(' ')-begin);
		else
			out=str.substr(begin,end-begin);
	}
	return out;
}
string getFrameName(string str){
	size_t end=str.find_last_of('_');
	return str.substr(0,end);
}
void insertSeq(const vector<string>& vin,vector<string>& vout){
	string seq="";
	size_t begin=0,end=vin.size();
	while(begin<vin.size()){
		if(vin[begin].compare("L")==0)
			begin++;
		else
			break;
	}
	while(end>0){
		if(vin[end-1].compare("L")==0)
			end--;
		else
			break;
	}
	string c_str="",n_str;
	for(size_t t=begin;t<end;++t){
		n_str=vin[t];
		if(n_str.compare(c_str)!=0){
			seq=seq+n_str;
			c_str=n_str;
		}
	}
	vout.push_back(seq);
}
void trim(vector<string>& in){
	int center=2;//wsize=5
	while(center+2<in.size()){
		if( (in[center-2]==in[center-1] && in[center]!=in[center-1]) &&( in[center+1]==in[center+2] && in[center-1]==in[center+1]) )
			in[center]=in[center-1];
		else{
			if(in[center-2]==in[center]&&in[center-1]!=in[center])
				in[center-1]=in[center-2];
			if(in[center-1]==in[center+1]&&in[center]!=in[center-1])
				in[center]=in[center-1];
			if(in[center]==in[center+2]&&in[center+1]!=in[center])
				in[center+1]=in[center];
		}
		center=center+2;
	}
}
vector<string> delRepeat(vector<string>& in, size_t repeatNum){
	vector<string> in_delRepeat;
	string prevStr = "";
	size_t repeat = 1;
	for(size_t i=0;i<in.size();i++){	
		if(in[i].compare(prevStr)==0){
			 repeat++;
		}
		else if(in[i].compare(prevStr)!=0 && i!=0){
			if(repeat>repeatNum){
				for(size_t j=0;j<repeat;j++){
					in_delRepeat.push_back(prevStr);
				}	
			}
			repeat=1;					
		} 	
		if(i==in.size()-1){
			if(repeat>repeatNum){
				for(size_t j=0;j<repeat;j++){
					in_delRepeat.push_back(prevStr);
				}
			}
		}
		prevStr = in[i];
	}
	return in_delRepeat;
}

void myUsage(){
	cout<<"trimming.app <labelSeq> <test.ark> <mapfile> <outfile>"<<endl;
}
int main(int argc, char *argv[])
{
	if(argc!=5){myUsage();return 1;}
	char * in = argv[1];
	char* name = argv[2];
	string mapFile(argv[3]);
	char * out = argv[4];	
	string str;
	ifstream file(mapFile.c_str());
	vector<string> v1;
	map<int,string> labelMap;
	if(!file){cerr<<"ERROR:no mapping file...\n";return 1;}
	cout<<"reading mapping file...";
	for(size_t line=0;getline(file,str);line++){
		v1.clear();
		parseOptions(str,v1);
		labelMap.insert(pair<int,string>(atoi(v1[2].c_str()),v1[3]));
	}
	file.close();
	cout<<"done!"<<endl;
	//Test Name
	
	file.open(name);
	if(!file){cerr<<"ERROR:no testing frame name...\n";return 1;}
	vector<string> nameSet;
	string c_str="",n_str;
	cout<<"reading frame name...";
	for(size_t line=0;getline(file,str);++line){
		n_str=getFrameName(parseName(str));
		if(n_str.compare(c_str)!=0){
			nameSet.push_back(n_str);
			c_str=n_str;
		}
	}
	file.close();
	cout<<"done"<<endl;
	//Frame Sequence

	FILE* fid;
	char buf[80];
	int fsize,label,check,count=0;
	size_t repeatNum = 3;
	vector<string> labChar;
	vector<string> labSeq;
	vector<string> labChar_delRepeat;
	map<int,string>::iterator it;
	fid=fopen(in,"r");
	if(!fid){cerr<<"ERROR: fail opening frame file!\n";return 1;}
	cout<<"reading frame file...";
	while(fscanf(fid,"%s %d\n",buf,&fsize)!=EOF){
		labChar.clear();
		for(size_t t =0;t<fsize;++t){
			check=fscanf(fid," %d",&label);
			it=labelMap.find(label);
			if(it==labelMap.end()){cerr<<"unknown label...aborted"<<endl;return 1;}
			labChar.push_back(it->second);
		}
		trim(labChar);
		labChar = delRepeat(labChar, repeatNum);
		insertSeq(labChar,labSeq);
		check=fscanf(fid," \n");
	}
	fclose(fid);
	cout<<"done!"<<endl;
	
	ofstream fout(out);
	if(!fout.is_open()){cerr<<"ERROR: fail writing file, please check directory..."<<endl;return 1;}
	if(labSeq.size()!=nameSet.size()){cerr<<"ERROR: framesize unmatched...(#labelseq:"<<labSeq.size()<<" #framename:"<<nameSet.size()<<")"<<endl;return 1;}
	cout<<"writing phone sequence...";
	fout<<"id,phone_sequence"<<endl;	
	for(size_t t=0;t<nameSet.size();++t)
		fout<<nameSet[t]<<","<<labSeq[t]<<endl;
	fout.close();
	cout<<"done!"<<endl;

	return 0;
}

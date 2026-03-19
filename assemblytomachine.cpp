#include <fstream>
#include <iostream>
#include <sstream>
#include <bitset>
using namespace std;

string controlPoint(string line){
    stringstream ss(line);
    string command, word1, word2, word3;
    int word1int, word2int, word3int;
    string instruction = "0000000000000000";
    ss >> command >> word1 >> word2 >> word3;
    if(command == "ADD"){
        instruction.replace(0,4,"0001");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<3>(word2int).to_string();
        instruction.replace(7,3,word2);
        if(word3[0]=='#'){
            //addi
            word3.erase(0,1);
            word3int = stoi(word3);
            word3 = bitset<5>(word3int).to_string();
            instruction.replace(10,3,"1");
            instruction.replace(11,5,word3);
        }else{
            word3.erase(0,1);
            word3int = stoi(word3);
            word3 = bitset<3>(word3int).to_string();
            instruction.replace(10,3,"0");
            instruction.replace(13,3,word3);
        }
    }
    if(command == "AND"){
        instruction.replace(0,4,"0101");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<3>(word2int).to_string();
        instruction.replace(7,3,word2);
        if(word3[0]=='#'){
            //addi
            word3.erase(0,1);
            word3int = stoi(word3);
            word3 = bitset<5>(word3int).to_string();
            instruction.replace(10,3,"1");
            instruction.replace(11,5,word3);
        }else{
            word3.erase(0,1);
            word3int = stoi(word3);
            word3 = bitset<3>(word3int).to_string();
            instruction.replace(10,3,"0");
            instruction.replace(13,3,word3);
        }
    }
    if(command[0] == 'B' && command[1] == 'R'){
        if(command.find('n') != string::npos){
            instruction.replace(4,1,"1");
        }
        if(command.find('z') != string::npos){
            instruction.replace(5,1,"1");
        }
        if(command.find('p') != string::npos){
            instruction.replace(6,1,"1");
        }
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<9>(word1int).to_string();
        instruction.replace(7,9,word1);
    }
    if(command=="JMP"){
        instruction.replace(0,4,"1100");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(7,3,word1);
    }
    if(command[0]=='J' && command[1]=='S' && command[2]=='R'){
        instruction.replace(0,4,"0100");
        if(command[3]=='R'){
            word1.erase(0,1);
            word1int = stoi(word1);
            word1 = bitset<3>(word1int).to_string();
            instruction.replace(7,3,word1);
        }else{
            word1.erase(0,1);
            word1int = stoi(word1);
            word1 = bitset<11>(word1int).to_string();
            instruction.replace(5,11,word1);
        }
    }
    if(command=="LD"){
        instruction.replace(0,4,"0010");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<9>(word2int).to_string();
        instruction.replace(7,9,word2);
    }
    if(command=="LDI"){
        instruction.replace(0,4,"1010");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<9>(word2int).to_string();
        instruction.replace(7,9,word2);
    }
    if(command=="LDR"){
        instruction.replace(0,4,"0110");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<3>(word2int).to_string();
        instruction.replace(7,3,word2);
        word3.erase(0,1);
        word3int = stoi(word3);
        word3 = bitset<6>(word3int).to_string();
        instruction.replace(10,6,word3);
    }
    if(command=="LEA"){
        instruction.replace(0,4,"1110");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<9>(word2int).to_string();
        instruction.replace(7,9,word2);
    }
    if(command=="NOT"){
        instruction.replace(0,4,"1001");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<3>(word2int).to_string();
        instruction.replace(7,3,word2);
        instruction.replace(10,6,"111111");
    }
    //I aint writing RET
    if(command=="RTI"){
        instruction = "1000000000000000";
    }
    if(command=="ST"){
        instruction.replace(0,4,"0011");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<9>(word2int).to_string();
        instruction.replace(7,9,word2);
    }
    if(command=="STI"){
        instruction.replace(0,4,"1011");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<9>(word2int).to_string();
        instruction.replace(7,9,word2);
    }
    if(command=="STR"){
        instruction.replace(0,4,"0111");
        word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<3>(word1int).to_string();
        instruction.replace(4,3,word1);
        word2.erase(0,1);
        word2int = stoi(word2);
        word2 = bitset<3>(word2int).to_string();
        instruction.replace(7,3,word2);
        word3.erase(0,1);
        word3int = stoi(word3);
        word3 = bitset<6>(word3int).to_string();
        instruction.replace(10,6,word3);
    }
    if(command=="TRAP"){
        instruction.replace(0,4,"1111");
         word1.erase(0,1);
        word1int = stoi(word1);
        word1 = bitset<8>(word1int).to_string();
        instruction.replace(8,8,word1);
    }
    return instruction;
}
int main(){
    ifstream assembler("sample.txt");
    ofstream machineCode("ugabuga.hex");
    string line, instruction;
    if (assembler.is_open()){
        while(getline(assembler, line)){
            instruction = controlPoint(line);
            cout << instruction <<endl;
            machineCode << instruction <<endl;
        }
    }
    return 0;
}
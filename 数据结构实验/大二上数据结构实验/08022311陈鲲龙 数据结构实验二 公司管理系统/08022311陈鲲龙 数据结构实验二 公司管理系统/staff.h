#pragma once
#include<string>
#include<vector>
using namespace std;

class staff
{
private:
	int num;
	int level;
	string name;
	int age;
	string position;
	string phone;
	staff* fellow[100];
	int fellownum = 0;
	staff* boss;
public:
	staff();
	~staff() {};
	void setname(string n);
	void setposition(string n);
	void setlevel(int n);
	void setnum(int n);
	void setage(int n);
	int getage() { return age; }
	void setphone(string n);
	void addfellow(staff* n);
	void setboss(staff* n);
	int getnum() { return num; }
	string getphone(){return phone;}
	string getname() { return name; };
	int getfellownum() { return fellownum; }
	staff* getfellow(int i) { return fellow[i]; }
	void setfellow(int i,staff* n) { fellow[i] = n; }
	staff* getboss() { return boss; }
};


#pragma once
#include"staff.h"

class company
{
private:
	staff* root = nullptr;
	staff* foundstaff = nullptr;
	int staffnumber = 0;
public:
	company() ;
	~company() {};
	void run();
	void traversalprint(staff * n);
	void traversalfind35(staff* n);
	void addstaff(staff* boss);
	void deletestaff(string& n);
	staff* findstaff(staff* start, string& n);
	void changestaffinform(string& n);
	void printfstaff(staff* n);
	int getstaffnumber() { return staffnumber; }
};


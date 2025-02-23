#include "company.h"
#include"staff.h"
#include<iostream>
using namespace std;

company::company()
{
	staff* boss = new staff;
	staffnumber++;
	root = boss;
}

void company::run()
{
	while (1)
	{
		cout << "1.添加员工信息" << endl;
		cout << "2.按级别输出全部员工" << endl;
		cout << "3.查找员工信息" << endl;
		cout << "4.删除员工信息" << endl;
		cout << "5.修改员工信息" << endl;
		cout << "6.输出所有超过35岁的员工" << endl;
		cout << "7.统计公司里面的所有员工数量" << endl;
		string a;
		int c = 0;
		cin >> c;
		if (c > 0 && c < 8)
		{
			switch (c)
			{
			case 1:
				cout << "他是谁的下属" << endl;
				cin >> a;
				addstaff(findstaff(root, a));
				break;
			case 2:
				cout << "以下按级别输出全部员工" << endl;
				traversalprint(root);
				break;
			case 3:
				cout << "输入所查找的员工名字" << endl;
				cin >> a;
				//findstaff(root, a);
				printfstaff(findstaff(root, a));
				break;
			case 4:
				cout << "输入所删除的员工名字" << endl;
				cin >> a;
				deletestaff(a);
				break;
			case 5:
				cout << "输入所要修改的员工名字" << endl;
				cin >> a;
				changestaffinform(a);
				break;
			case 6:
				traversalfind35(root);
				break;
			case 7:
				cout << "公司里面的所有员工数量为：" << getstaffnumber() << endl;
				break;
			}
		}
	}
}

void company::addstaff(staff* boss)
{
	staff* newstaff = new staff;
	staffnumber++;
	if (boss != nullptr)
	{
		boss->addfellow(newstaff);
		newstaff->setboss(boss);
	}

	cout << "员工有几个下属" << endl;
	int fellownumber;
	cin >> fellownumber;
	for (int i = 0; i < fellownumber; i++)
	{
		addstaff(newstaff);
	}
}

staff* company::findstaff(staff* start, string& n)
{
	if (start == nullptr)
	{
		return foundstaff;
	}
	else
	{
		if (start->getname() == n)
		{
			//printfstaff(start);
			foundstaff = start;
			return foundstaff;
		}
		else
		{
			for (int i = 0; i < start->getfellownum(); i++)
			{
				findstaff(start->getfellow(i), n);
			}
			return foundstaff;
		}
	}
	return foundstaff;
}

void company::changestaffinform(string& n)
{
	//findstaff(root ,n);
	while (1)
	{
		cout << "1.修改员工电话" << endl;
		cout << "2.修改员工年龄" << endl;
		string a;
		int b;
		int c = 0;
		cin >> c;
		if (c > 0 && c < 3)
		{
			switch (c)
			{
			case 1:
				cout << "修改的电话" << endl;
				cin >> a;
				findstaff(root, n)->setphone(a);
				break;
			case 2:
				cout << "修改的年龄" << endl;
				cin >> b;
				findstaff(root, n)->setage(b);
				break;
			}
		}
		else
		{
			return;
		}
	}
}

void company::deletestaff(string& n)
{
	for (int i = 0; i < ((findstaff(root, n)->getboss()->getfellownum()) + 1); i++)
	{
		cout << "已删除1" << endl;
		if (findstaff(root, n)->getboss()->getfellow(i)->getname() == n)
		{
			cout << "已删除2" << endl;
			findstaff(root, n)->getboss()->setfellow(i, nullptr);
			cout << "已删除3" << endl;
			return;
		}
	}
}

void company::printfstaff(staff* n)
{
	cout << "名字：" << n->getname() << endl;
	cout << "工号：" << n->getnum() << endl;
	cout << "电话：" << n->getphone() << endl;
	if (n != root)
	{
		cout << "上司：" << n->getboss()->getname() << endl;
		if (n->getboss()->getfellownum() != 0)
		{
			cout << "同事：";
			for (int i = 0; i < n->getboss()->getfellownum(); i++)
			{
				if (n->getboss()->getfellow(i)->getname() != n->getname())
				{
					cout << n->getboss()->getfellow(i)->getname() << " ";
				}
			}
		}
		cout << endl;
	}
}

void company::traversalprint(staff* n)
{
	cout << "名字：" << n->getname() << endl;
	for (int i = 0; i < n->getfellownum(); i++)
	{
		traversalprint(n->getfellow(i));
	}
	return;
}


void company::traversalfind35(staff* n)
{
	if (n->getage() > 35)
	{
		cout << "名字：" << n->getname() << " "<< n->getage() <<endl;
	}
	for (int i = 0; i < n->getfellownum(); i++)
	{
		traversalfind35(n->getfellow(i));
	}
	return;
}
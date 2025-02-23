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
		cout << "1.���Ա����Ϣ" << endl;
		cout << "2.���������ȫ��Ա��" << endl;
		cout << "3.����Ա����Ϣ" << endl;
		cout << "4.ɾ��Ա����Ϣ" << endl;
		cout << "5.�޸�Ա����Ϣ" << endl;
		cout << "6.������г���35���Ա��" << endl;
		cout << "7.ͳ�ƹ�˾���������Ա������" << endl;
		string a;
		int c = 0;
		cin >> c;
		if (c > 0 && c < 8)
		{
			switch (c)
			{
			case 1:
				cout << "����˭������" << endl;
				cin >> a;
				addstaff(findstaff(root, a));
				break;
			case 2:
				cout << "���°��������ȫ��Ա��" << endl;
				traversalprint(root);
				break;
			case 3:
				cout << "���������ҵ�Ա������" << endl;
				cin >> a;
				//findstaff(root, a);
				printfstaff(findstaff(root, a));
				break;
			case 4:
				cout << "������ɾ����Ա������" << endl;
				cin >> a;
				deletestaff(a);
				break;
			case 5:
				cout << "������Ҫ�޸ĵ�Ա������" << endl;
				cin >> a;
				changestaffinform(a);
				break;
			case 6:
				traversalfind35(root);
				break;
			case 7:
				cout << "��˾���������Ա������Ϊ��" << getstaffnumber() << endl;
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

	cout << "Ա���м�������" << endl;
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
		cout << "1.�޸�Ա���绰" << endl;
		cout << "2.�޸�Ա������" << endl;
		string a;
		int b;
		int c = 0;
		cin >> c;
		if (c > 0 && c < 3)
		{
			switch (c)
			{
			case 1:
				cout << "�޸ĵĵ绰" << endl;
				cin >> a;
				findstaff(root, n)->setphone(a);
				break;
			case 2:
				cout << "�޸ĵ�����" << endl;
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
		cout << "��ɾ��1" << endl;
		if (findstaff(root, n)->getboss()->getfellow(i)->getname() == n)
		{
			cout << "��ɾ��2" << endl;
			findstaff(root, n)->getboss()->setfellow(i, nullptr);
			cout << "��ɾ��3" << endl;
			return;
		}
	}
}

void company::printfstaff(staff* n)
{
	cout << "���֣�" << n->getname() << endl;
	cout << "���ţ�" << n->getnum() << endl;
	cout << "�绰��" << n->getphone() << endl;
	if (n != root)
	{
		cout << "��˾��" << n->getboss()->getname() << endl;
		if (n->getboss()->getfellownum() != 0)
		{
			cout << "ͬ�£�";
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
	cout << "���֣�" << n->getname() << endl;
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
		cout << "���֣�" << n->getname() << " "<< n->getage() <<endl;
	}
	for (int i = 0; i < n->getfellownum(); i++)
	{
		traversalfind35(n->getfellow(i));
	}
	return;
}
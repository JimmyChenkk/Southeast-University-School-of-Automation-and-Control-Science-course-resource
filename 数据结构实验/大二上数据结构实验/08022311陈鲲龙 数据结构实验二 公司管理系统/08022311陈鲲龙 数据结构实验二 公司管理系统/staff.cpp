#include "staff.h"
#include<iostream>

using namespace std;

staff::staff()
{
	cout << "������Ա������" << endl;
	string n;
	for (;;)
	{
		cin >> n;
		if (std::cin.fail()) {
			std::cout << "��������룬����������" << std::endl;
			// �������״̬
			std::cin.clear();
			// ���Ի������е���Ч����
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setname(n);

	cout << "������Ա��ְλ" << endl;
	string position;
	for (;;)
	{
		cin >> position;
		if (std::cin.fail()) {
			std::cout << "��������룬����������" << std::endl;
			// �������״̬
			std::cin.clear();
			// ���Ի������е���Ч����
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setposition(n);

	cout << "������Ա������" << endl;
	int num;
	for (;;)
	{
		cin >> num;
		if (std::cin.fail()) {
			std::cout << "��������룬����������" << std::endl;
			// �������״̬
			std::cin.clear();
			// ���Ի������е���Ч����
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setnum(num);


	cout << "������Ա���绰" << endl;
	string phone;
	for (;;)
	{
		cin >> phone;
		if (std::cin.fail()) {
			std::cout << "��������룬����������" << std::endl;
			// �������״̬
			std::cin.clear();
			// ���Ի������е���Ч����
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setphone(phone);

	cout << "������Ա������" << endl;
	int level;
	for (;;)
	{
		cin >> level;
		if (std::cin.fail()) {
			std::cout << "��������룬����������" << std::endl;
			// �������״̬
			std::cin.clear();
			// ���Ի������е���Ч����
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setlevel(level);

	cout << "������Ա������" << endl;
	int age;
	for (;;)
	{
		cin >> age;
		if (std::cin.fail()) {
			std::cout << "��������룬����������" << std::endl;
			// �������״̬
			std::cin.clear();
			// ���Ի������е���Ч����
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setage(age);

}

void staff::setname(string n)
{
	name = n;
}

void staff::setposition(string n)
{
	position = n;
}

void staff::setlevel(int n)
{
	level = n;
}

void staff::setnum(int n)
{
	num = n;
}

void staff::setage(int n)
{
	age = n;
}

void staff::setphone(string n)
{
	phone = n;
}


void staff::setboss(staff* n)
{
	boss = n;
}

void staff::addfellow(staff* n)
{
	//n->setboss(this);
	fellow[fellownum]=n;
	fellownum++;
}

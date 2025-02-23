#include "staff.h"
#include<iostream>

using namespace std;

staff::staff()
{
	cout << "请输入员工姓名" << endl;
	string n;
	for (;;)
	{
		cin >> n;
		if (std::cin.fail()) {
			std::cout << "错误的输入，请重新输入" << std::endl;
			// 清除错误状态
			std::cin.clear();
			// 忽略缓冲区中的无效输入
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setname(n);

	cout << "请输入员工职位" << endl;
	string position;
	for (;;)
	{
		cin >> position;
		if (std::cin.fail()) {
			std::cout << "错误的输入，请重新输入" << std::endl;
			// 清除错误状态
			std::cin.clear();
			// 忽略缓冲区中的无效输入
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setposition(n);

	cout << "请输入员工工号" << endl;
	int num;
	for (;;)
	{
		cin >> num;
		if (std::cin.fail()) {
			std::cout << "错误的输入，请重新输入" << std::endl;
			// 清除错误状态
			std::cin.clear();
			// 忽略缓冲区中的无效输入
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setnum(num);


	cout << "请输入员工电话" << endl;
	string phone;
	for (;;)
	{
		cin >> phone;
		if (std::cin.fail()) {
			std::cout << "错误的输入，请重新输入" << std::endl;
			// 清除错误状态
			std::cin.clear();
			// 忽略缓冲区中的无效输入
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setphone(phone);

	cout << "请输入员工级别" << endl;
	int level;
	for (;;)
	{
		cin >> level;
		if (std::cin.fail()) {
			std::cout << "错误的输入，请重新输入" << std::endl;
			// 清除错误状态
			std::cin.clear();
			// 忽略缓冲区中的无效输入
			std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
		}
		else {
			break;
		}
	}
	setlevel(level);

	cout << "请输入员工年龄" << endl;
	int age;
	for (;;)
	{
		cin >> age;
		if (std::cin.fail()) {
			std::cout << "错误的输入，请重新输入" << std::endl;
			// 清除错误状态
			std::cin.clear();
			// 忽略缓冲区中的无效输入
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

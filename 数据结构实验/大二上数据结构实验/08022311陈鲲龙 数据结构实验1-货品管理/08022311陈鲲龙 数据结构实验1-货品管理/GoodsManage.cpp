#include "GoodsManage.h"


GoodsManage::GoodsManage()//定义构造函数
{
	amount = 0;
	DeleteAmount = 0;
	head = new Goods;
	head->next = NULL;
	DeleteHead = new Goods;
	DeleteHead->next = NULL;
}

void GoodsManage::DisplayMainMenu()//定义主菜单函数
{
	cout << " --------------------------------------------------------------------\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                   欢迎使用商品库存管理系统                     ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                        【商品进货】…(a)                       ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                        【商品删除】…(b)                       ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                        【按照编号查询】…(c)                   ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                        【按照名称查询】…(d)                   ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                        【商品出货】…(e)                       ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                        【商品统计】…(f)                       ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                        【信息保存】…(g)                       ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " ┋                          退出系统…(h)                         ┋\n";
	cout << " ┋                                                                ┋\n";
	cout << " --------------------------------------------------------------------\n";
	cout << "\n                      请输入你要进行的操作编号:";
}


void GoodsManage::AddGoodsInfo()//定义添加商品信息函数
{
	char c = 'y', c1;
	Goods* tail = head, * p;
	bool flag;
	cout << "          ------现在进行商品信息的添加------          " << endl;
	while (tail->next != NULL)
		tail = tail->next;//令tail指向链表中最后一个节点
	do
		//while (c == 'y')
	{
		flag = 0;
		p = new Goods;
		cout << "请选择商品类别:" << endl;
		cout << "1.食品 2.文具 3.日用品 4.饮料" << endl;
		cout << "请输入相应编号:";
		do
		{
			cin >> c1;
			if (c1 >= '1' && c1 <= '4')//判断用户输入编号是否存在
				flag = 1;
			else
			{
				cout << "您输入的编号不存在！" << endl;
				cout << "请选择正确的商品类别:" << endl;
			}
		} while (flag == 0);//输入编号存在时跳出循环
		if (c1 == '1')p->type = Food;
		if (c1 == '2')p->type = Stationery;
		if (c1 == '3')p->type = Commodity;
		if (c1 == '4')p->type = Drink;
		cout << "商品类别(" << p->type << ")" << endl;//表示商品类别
		cout << "请输入商品编号: ";
		cin >> p->code;
		do
		{
			Goods* q = head->next;
			while (q != NULL && q->code != p->code)//当q指向NULL或输入的编号与之前编号重复时跳出循环
				q = q->next;
			if (q == NULL)//当p指向NNULL且编号不重复时
				flag = 1;
			else//编号重复时
			{
				cout << "存在该编号的货物!!!请重新输入编号:";
				cin >> p->code;
			}
		} while (flag == 0);
		cout << "请输入商品名称：";
		cin >> p->name;
		cout << "请输入生产厂家：";
		cin >> p->brand;
		cout << "请输入商品价格：";
		cin >> p->price;
		cout << "请输入商品数量：";
		cin >> p->num;
		cout << "请输入入库时间（年/月/日）：";
		cin >> p->date.year >> p->date.month >> p->date.day;
		tail->next = p;//将p插入链表
		p->next = NULL;
		tail = p;
		amount++;//商品量加一
		cout << "数据输入成功！！！想继续添加吗(y/n):";
		cin >> c;
		while (c != 'y' && c != 'n')
		{
			cout << "指令错误！！！！！<请输入y/n>" << endl;
			cout << "数据添加成功！！！想继续输入吗(y/n):";
			cin >> c;
		}
	} while (c == 'y');
	cout << endl;
	cout << "……信息处理完毕……" << endl;
	cout << "……按任意键返回主菜单……" << endl;
	getchar();
	getchar();
}

void GoodsManage::DisplayGoodsInfo()//定义商品信息浏览函数
{
	Goods* p = head;
	cout << "          ------现在进行商品信息的浏览------          " << endl;
	cout << setiosflags(ios::left) << setw(10) << "编号" << setw(16) << "名称" << setw(10) << "生产厂家" << setw(10) << "价格" << setw(10) <<
		"商品类别" << setw(10) << "数量" << setw(10) << "入库时间" << endl;
	while (p->next != NULL)//直到p指向链表中最后一个结点
	{
		p = p->next;
		cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
		cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
		cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
	}
	cout << endl;
	cout << "……信息统计完毕……" << endl;
	cout << "……按任意键返回主菜单……" << endl;
	getchar();
	getchar();
}



void GoodsManage::SearchByCode()//按照商品编号查找商品信息
{
	Goods* p;
	bool flag;
	string FoundCode;
	cout << "          ------现在进行商品信息的查找------          " << endl;
	p = head;
	flag = 0;
	cout << "请输入您要查找的商品编号：";
	cin >> FoundCode;
	while (p->next != NULL)
	{
		p = p->next;
		if (p->code == FoundCode)//找到相应编号的商品
		{
			flag = 1;
			cout << setiosflags(ios::left) << setw(10) << "编号" << setw(16) << "名称" << setw(10) << "生产厂家" << setw(10) << "价格" << setw(10) <<
				"商品类别" << setw(10) << "数量" << setw(10) << "入库时间" << endl;
			cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
			cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
			cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
			break;
		}
	}
	if (flag == 0)
	{
		cout << "对不起，您查询的商品不存在！！！" << endl;
	}
	cout << endl;
	cout << "……信息查找完毕……" << endl;
	cout << "……按任意键返回主菜单……" << endl;
	getchar();
	getchar();
}

void GoodsManage::SearchByName()//按照商品名称查找商品信息
{
	Goods* p;
	bool flag;
	string FoundName;
	cout << "          ------现在进行商品信息的查找------          " << endl;
	p = head;
	flag = 0;
	cout << "请输入您要查找的商品名称：";
	cin >> FoundName;
	while (p->next != NULL)
	{

		p = p->next;
		if (p->name == FoundName)//找到相应名称的商品
		{
			flag = 1;
			cout << setiosflags(ios::left) << setw(10) << "编号" << setw(16) << "名称" << setw(10) << "生产厂家" << setw(10) << "价格" << setw(10) <<
				"商品类别" << setw(10) << "数量" << setw(10) << "入库时间" << endl;
			cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
			cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
			cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
			break;
		}
	}
	if (flag == 0)
	{
		cout << "对不起，您查询的商品不存在！！！" << endl;
	}
	cout << endl;
	cout << "……信息查找完毕……" << endl;
	cout << "……按任意键返回主菜单……" << endl;
	getchar();
	getchar();
}




void GoodsManage::DeleteGoodsInfo()//定义商品信息删除函数
{
	Goods* q = head, * p, * tail = DeleteHead;
	p = new Goods;
	char c;
	string Dename;
	bool flag = 0;
	while (tail->next != NULL)//令tail指向链表中最后一个节点
		tail = tail->next;
	cout << "          ------现在进行商品信息的删除------          " << endl;
	do
	{

		cout << "请输入您要删除的商品名称：";
		cin >> Dename;
		while (q->next != NULL && q->next->name != Dename)//直到q指向链表中最后一个节点或者找到相应名称的商品时跳出循环
			q = q->next;
		if (q->next != NULL)//找到相应名称的商品
		{
			flag = 1;
			cout << "确认删除吗？<y/n>";
			cin >> c;
			while (c != 'y' && c != 'n')
			{
				cout << "指令错误！！！！<请输入y/n>:";
				cin >> c;
			}
			if (c == 'y')
			{
				p = q->next;
				q->next = q->next->next;//q的下一个节点指向其后的节点
				tail->next = p;
				tail = p;
				tail->next = NULL;//在链表中删除指定节点
				DeleteAmount++;
				amount--;//商品量减一
				cout << "删除成功！！" << endl;
			}
			else cout << "取消成功！！！" << endl;

		}
		if (flag == 0)
		{
			cout << "对不起，您删除的商品不存在！！！" << endl;

		}
		cout << "您想要继续删除吗？(y/n):";
		cin >> c;
		while (c != 'y' && c != 'n')
		{
			cout << "指令错误！！！<请输入y/n>:" << endl;
			cout << "您想要继续删除吗？(y/n):";
			cin >> c;
		}
		flag = 0;
		q = head;//令q指向链表中第一个结点再次搜索相应名称的商品

	} while (c == 'y');
	cout << endl;
	cout << "……信息删除完毕……" << endl;
	cout << "……按任意键返回主菜单……" << endl;
	getchar();
	getchar();
}


void GoodsManage::SellGoodsInfo()//定义商品出库函数
{
	int sellNum, year, month, day;
	double sellPrice, sum = 0.0, profit = 0.0;
	char c;
	Goods* p;
	bool flag = 0;
	string SellName;
	cout << "          ------现在进行商品的出售------          " << endl;
	do
	{
		p = head->next;
		flag = 0;
		cout << "请输入您要出售的商品名称：";
		cin >> SellName;
		while (p->next != NULL && p->name != SellName)
			p = p->next;
		if (p->name == SellName)
		{
			flag = 1;
			cout << setiosflags(ios::left) << setw(10) << "编号" << setw(16) << "名称" << setw(10) << "生产厂家" << setw(10) << "价格" << setw(10) <<
				"商品类别" << setw(10) << "数量" << setw(10) << "入库时间" << endl;

			cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
			cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
			cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
			cout << "确认出售吗？<y/n>";
			cin >> c;
			while (c != 'y' && c != 'n')
			{
				cout << "指令错误！！！！<请输入y/n>:";
				cin >> c;
			}
			if (c == 'y')
			{

				cout << "请输入出售的商品数量：";
				cin >> sellNum;
				if (sellNum <= p->num)//库存量充足
				{
					p->num = p->num - sellNum;//计算商品出库后商品的库存量
					cout << "请输入出售的商品价格：";
					cin >> sellPrice;
					cout << "请输入出货日期：";
					cin >> year >> month >> day;
					sum = sellNum * sellPrice;//计算销售金额
					profit = sellNum * (sellPrice - p->price);//计算利润
					cout << "此次销售额为： " << sum << endl;
					cout << "此次利润为： " << profit << endl;
					cout << "出货日期为：" << year << "/" << month << "/" << day << endl;
				}
				else
				{
					cout << "库存不足！出库失败！" << endl;
				}
			}
			else cout << "取消成功！" << endl;
		}
		if (flag == 0)
		{
			cout << "对不起，您出售的货物不存在！！" << endl;

		}
		cout << "您想要继续出售吗？(y/n):";
		cin >> c;
		while (c != 'y' && c != 'n')
		{
			cout << "指令错误！！！<请输入y/n>:" << endl;
			cout << "您想要继续出售吗？(y/n):";
			cin >> c;
		}
	} while (c == 'y');
	cout << endl;
	cout << "……出库完毕……" << endl;
	cout << "……按任意键返回主菜单……" << endl;
	getchar();
	getchar();

}


void GoodsManage::SaveGoodsInfo()//定义商品信息保存函数
{
	Goods* p = head;
	cout << "          ------现在进行商品信息的保存------          " << endl;
	ofstream output("货物信息.txt", ios::out);//定义输出文件"货物信息.txt"
	if (!output)
	{
		cerr << "打开文件<货物信息.txt>失败！！！" << endl;
	}
	cout << setiosflags(ios::left) << setw(10) << "编号" << setw(16) << "名称" << setw(10) << "生产厂家" << setw(10) << "价格" << setw(10) <<
		"商品类别" << setw(10) << "数量" << setw(10) << "入库时间" << endl;
	output << "商品总量为: " << amount << "\n";
	output << setiosflags(ios::left) << setw(10) << "编号" << setw(16) << "名称" << setw(10) << "生产厂家" << setw(10) << "价格" << setw(10) <<
		"商品类别" << setw(10) << "数量" << setw(10) << "入库时间" << endl;
	while (p->next != NULL)
	{
		p = p->next;
		cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
		cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
		cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
		output << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;//在文件中显示相应商品信息
		output << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
		output << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
	}
	cout << endl;
	cout << "成功将货物信息保存到<货物信息.txt>" << endl;
	cout << "……信息保存完毕……" << endl;
	cout << "……按任意键返回主菜单……" << endl;
	getchar();
	getchar();
	output.close();//关闭输出文件
}

void GoodsManage::Run()
{
	char c;
	int i = 0;
	bool flag = 0;
	DisplayMainMenu();
	for (;;)
	{
		do
		{
			cin >> c;
			if (c >= 'a' && c <= 'k')//判断用户输入编号是否存在
				flag = 1;
			else
			{
				cout << "您输入的编号不存在！" << endl;
				cout << "请选择相应的数字进行操作:" << endl;
			}
		} while (flag == 0);//输入编号存在时跳出循环进行相应操作
		system("cls");//清屏
		switch (c)
		{
		case'a':AddGoodsInfo();
			break;
		case'b':DeleteGoodsInfo();
			break;
		case'c':SearchByCode();
			break;
		case'd':SearchByName();
			break;
		case'e':SellGoodsInfo();
			break;
		case'f':DisplayGoodsInfo();
			break;
		case'g':SaveGoodsInfo();
			break;
		case'h':exit(0);
			break;
		}
		system("cls");
		DisplayMainMenu();
	}
}
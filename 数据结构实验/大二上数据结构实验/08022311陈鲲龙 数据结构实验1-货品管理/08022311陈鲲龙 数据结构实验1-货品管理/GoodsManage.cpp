#include "GoodsManage.h"


GoodsManage::GoodsManage()//���幹�캯��
{
	amount = 0;
	DeleteAmount = 0;
	head = new Goods;
	head->next = NULL;
	DeleteHead = new Goods;
	DeleteHead->next = NULL;
}

void GoodsManage::DisplayMainMenu()//�������˵�����
{
	cout << " --------------------------------------------------------------------\n";
	cout << " ��                                                                ��\n";
	cout << " ��                   ��ӭʹ����Ʒ������ϵͳ                     ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                        ����Ʒ��������(a)                       ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                        ����Ʒɾ������(b)                       ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                        �����ձ�Ų�ѯ����(c)                   ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                        ���������Ʋ�ѯ����(d)                   ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                        ����Ʒ��������(e)                       ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                        ����Ʒͳ�ơ���(f)                       ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                        ����Ϣ���桿��(g)                       ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                                                                ��\n";
	cout << " ��                          �˳�ϵͳ��(h)                         ��\n";
	cout << " ��                                                                ��\n";
	cout << " --------------------------------------------------------------------\n";
	cout << "\n                      ��������Ҫ���еĲ������:";
}


void GoodsManage::AddGoodsInfo()//���������Ʒ��Ϣ����
{
	char c = 'y', c1;
	Goods* tail = head, * p;
	bool flag;
	cout << "          ------���ڽ�����Ʒ��Ϣ�����------          " << endl;
	while (tail->next != NULL)
		tail = tail->next;//��tailָ�����������һ���ڵ�
	do
		//while (c == 'y')
	{
		flag = 0;
		p = new Goods;
		cout << "��ѡ����Ʒ���:" << endl;
		cout << "1.ʳƷ 2.�ľ� 3.����Ʒ 4.����" << endl;
		cout << "��������Ӧ���:";
		do
		{
			cin >> c1;
			if (c1 >= '1' && c1 <= '4')//�ж��û��������Ƿ����
				flag = 1;
			else
			{
				cout << "������ı�Ų����ڣ�" << endl;
				cout << "��ѡ����ȷ����Ʒ���:" << endl;
			}
		} while (flag == 0);//�����Ŵ���ʱ����ѭ��
		if (c1 == '1')p->type = Food;
		if (c1 == '2')p->type = Stationery;
		if (c1 == '3')p->type = Commodity;
		if (c1 == '4')p->type = Drink;
		cout << "��Ʒ���(" << p->type << ")" << endl;//��ʾ��Ʒ���
		cout << "��������Ʒ���: ";
		cin >> p->code;
		do
		{
			Goods* q = head->next;
			while (q != NULL && q->code != p->code)//��qָ��NULL������ı����֮ǰ����ظ�ʱ����ѭ��
				q = q->next;
			if (q == NULL)//��pָ��NNULL�ұ�Ų��ظ�ʱ
				flag = 1;
			else//����ظ�ʱ
			{
				cout << "���ڸñ�ŵĻ���!!!������������:";
				cin >> p->code;
			}
		} while (flag == 0);
		cout << "��������Ʒ���ƣ�";
		cin >> p->name;
		cout << "�������������ң�";
		cin >> p->brand;
		cout << "��������Ʒ�۸�";
		cin >> p->price;
		cout << "��������Ʒ������";
		cin >> p->num;
		cout << "���������ʱ�䣨��/��/�գ���";
		cin >> p->date.year >> p->date.month >> p->date.day;
		tail->next = p;//��p��������
		p->next = NULL;
		tail = p;
		amount++;//��Ʒ����һ
		cout << "��������ɹ�����������������(y/n):";
		cin >> c;
		while (c != 'y' && c != 'n')
		{
			cout << "ָ����󣡣�������<������y/n>" << endl;
			cout << "������ӳɹ������������������(y/n):";
			cin >> c;
		}
	} while (c == 'y');
	cout << endl;
	cout << "������Ϣ������ϡ���" << endl;
	cout << "������������������˵�����" << endl;
	getchar();
	getchar();
}

void GoodsManage::DisplayGoodsInfo()//������Ʒ��Ϣ�������
{
	Goods* p = head;
	cout << "          ------���ڽ�����Ʒ��Ϣ�����------          " << endl;
	cout << setiosflags(ios::left) << setw(10) << "���" << setw(16) << "����" << setw(10) << "��������" << setw(10) << "�۸�" << setw(10) <<
		"��Ʒ���" << setw(10) << "����" << setw(10) << "���ʱ��" << endl;
	while (p->next != NULL)//ֱ��pָ�����������һ�����
	{
		p = p->next;
		cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
		cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
		cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
	}
	cout << endl;
	cout << "������Ϣͳ����ϡ���" << endl;
	cout << "������������������˵�����" << endl;
	getchar();
	getchar();
}



void GoodsManage::SearchByCode()//������Ʒ��Ų�����Ʒ��Ϣ
{
	Goods* p;
	bool flag;
	string FoundCode;
	cout << "          ------���ڽ�����Ʒ��Ϣ�Ĳ���------          " << endl;
	p = head;
	flag = 0;
	cout << "��������Ҫ���ҵ���Ʒ��ţ�";
	cin >> FoundCode;
	while (p->next != NULL)
	{
		p = p->next;
		if (p->code == FoundCode)//�ҵ���Ӧ��ŵ���Ʒ
		{
			flag = 1;
			cout << setiosflags(ios::left) << setw(10) << "���" << setw(16) << "����" << setw(10) << "��������" << setw(10) << "�۸�" << setw(10) <<
				"��Ʒ���" << setw(10) << "����" << setw(10) << "���ʱ��" << endl;
			cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
			cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
			cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
			break;
		}
	}
	if (flag == 0)
	{
		cout << "�Բ�������ѯ����Ʒ�����ڣ�����" << endl;
	}
	cout << endl;
	cout << "������Ϣ������ϡ���" << endl;
	cout << "������������������˵�����" << endl;
	getchar();
	getchar();
}

void GoodsManage::SearchByName()//������Ʒ���Ʋ�����Ʒ��Ϣ
{
	Goods* p;
	bool flag;
	string FoundName;
	cout << "          ------���ڽ�����Ʒ��Ϣ�Ĳ���------          " << endl;
	p = head;
	flag = 0;
	cout << "��������Ҫ���ҵ���Ʒ���ƣ�";
	cin >> FoundName;
	while (p->next != NULL)
	{

		p = p->next;
		if (p->name == FoundName)//�ҵ���Ӧ���Ƶ���Ʒ
		{
			flag = 1;
			cout << setiosflags(ios::left) << setw(10) << "���" << setw(16) << "����" << setw(10) << "��������" << setw(10) << "�۸�" << setw(10) <<
				"��Ʒ���" << setw(10) << "����" << setw(10) << "���ʱ��" << endl;
			cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
			cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
			cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
			break;
		}
	}
	if (flag == 0)
	{
		cout << "�Բ�������ѯ����Ʒ�����ڣ�����" << endl;
	}
	cout << endl;
	cout << "������Ϣ������ϡ���" << endl;
	cout << "������������������˵�����" << endl;
	getchar();
	getchar();
}




void GoodsManage::DeleteGoodsInfo()//������Ʒ��Ϣɾ������
{
	Goods* q = head, * p, * tail = DeleteHead;
	p = new Goods;
	char c;
	string Dename;
	bool flag = 0;
	while (tail->next != NULL)//��tailָ�����������һ���ڵ�
		tail = tail->next;
	cout << "          ------���ڽ�����Ʒ��Ϣ��ɾ��------          " << endl;
	do
	{

		cout << "��������Ҫɾ������Ʒ���ƣ�";
		cin >> Dename;
		while (q->next != NULL && q->next->name != Dename)//ֱ��qָ�����������һ���ڵ�����ҵ���Ӧ���Ƶ���Ʒʱ����ѭ��
			q = q->next;
		if (q->next != NULL)//�ҵ���Ӧ���Ƶ���Ʒ
		{
			flag = 1;
			cout << "ȷ��ɾ����<y/n>";
			cin >> c;
			while (c != 'y' && c != 'n')
			{
				cout << "ָ����󣡣�����<������y/n>:";
				cin >> c;
			}
			if (c == 'y')
			{
				p = q->next;
				q->next = q->next->next;//q����һ���ڵ�ָ�����Ľڵ�
				tail->next = p;
				tail = p;
				tail->next = NULL;//��������ɾ��ָ���ڵ�
				DeleteAmount++;
				amount--;//��Ʒ����һ
				cout << "ɾ���ɹ�����" << endl;
			}
			else cout << "ȡ���ɹ�������" << endl;

		}
		if (flag == 0)
		{
			cout << "�Բ�����ɾ������Ʒ�����ڣ�����" << endl;

		}
		cout << "����Ҫ����ɾ����(y/n):";
		cin >> c;
		while (c != 'y' && c != 'n')
		{
			cout << "ָ����󣡣���<������y/n>:" << endl;
			cout << "����Ҫ����ɾ����(y/n):";
			cin >> c;
		}
		flag = 0;
		q = head;//��qָ�������е�һ������ٴ�������Ӧ���Ƶ���Ʒ

	} while (c == 'y');
	cout << endl;
	cout << "������Ϣɾ����ϡ���" << endl;
	cout << "������������������˵�����" << endl;
	getchar();
	getchar();
}


void GoodsManage::SellGoodsInfo()//������Ʒ���⺯��
{
	int sellNum, year, month, day;
	double sellPrice, sum = 0.0, profit = 0.0;
	char c;
	Goods* p;
	bool flag = 0;
	string SellName;
	cout << "          ------���ڽ�����Ʒ�ĳ���------          " << endl;
	do
	{
		p = head->next;
		flag = 0;
		cout << "��������Ҫ���۵���Ʒ���ƣ�";
		cin >> SellName;
		while (p->next != NULL && p->name != SellName)
			p = p->next;
		if (p->name == SellName)
		{
			flag = 1;
			cout << setiosflags(ios::left) << setw(10) << "���" << setw(16) << "����" << setw(10) << "��������" << setw(10) << "�۸�" << setw(10) <<
				"��Ʒ���" << setw(10) << "����" << setw(10) << "���ʱ��" << endl;

			cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
			cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
			cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
			cout << "ȷ�ϳ�����<y/n>";
			cin >> c;
			while (c != 'y' && c != 'n')
			{
				cout << "ָ����󣡣�����<������y/n>:";
				cin >> c;
			}
			if (c == 'y')
			{

				cout << "��������۵���Ʒ������";
				cin >> sellNum;
				if (sellNum <= p->num)//���������
				{
					p->num = p->num - sellNum;//������Ʒ�������Ʒ�Ŀ����
					cout << "��������۵���Ʒ�۸�";
					cin >> sellPrice;
					cout << "������������ڣ�";
					cin >> year >> month >> day;
					sum = sellNum * sellPrice;//�������۽��
					profit = sellNum * (sellPrice - p->price);//��������
					cout << "�˴����۶�Ϊ�� " << sum << endl;
					cout << "�˴�����Ϊ�� " << profit << endl;
					cout << "��������Ϊ��" << year << "/" << month << "/" << day << endl;
				}
				else
				{
					cout << "��治�㣡����ʧ�ܣ�" << endl;
				}
			}
			else cout << "ȡ���ɹ���" << endl;
		}
		if (flag == 0)
		{
			cout << "�Բ��������۵Ļ��ﲻ���ڣ���" << endl;

		}
		cout << "����Ҫ����������(y/n):";
		cin >> c;
		while (c != 'y' && c != 'n')
		{
			cout << "ָ����󣡣���<������y/n>:" << endl;
			cout << "����Ҫ����������(y/n):";
			cin >> c;
		}
	} while (c == 'y');
	cout << endl;
	cout << "����������ϡ���" << endl;
	cout << "������������������˵�����" << endl;
	getchar();
	getchar();

}


void GoodsManage::SaveGoodsInfo()//������Ʒ��Ϣ���溯��
{
	Goods* p = head;
	cout << "          ------���ڽ�����Ʒ��Ϣ�ı���------          " << endl;
	ofstream output("������Ϣ.txt", ios::out);//��������ļ�"������Ϣ.txt"
	if (!output)
	{
		cerr << "���ļ�<������Ϣ.txt>ʧ�ܣ�����" << endl;
	}
	cout << setiosflags(ios::left) << setw(10) << "���" << setw(16) << "����" << setw(10) << "��������" << setw(10) << "�۸�" << setw(10) <<
		"��Ʒ���" << setw(10) << "����" << setw(10) << "���ʱ��" << endl;
	output << "��Ʒ����Ϊ: " << amount << "\n";
	output << setiosflags(ios::left) << setw(10) << "���" << setw(16) << "����" << setw(10) << "��������" << setw(10) << "�۸�" << setw(10) <<
		"��Ʒ���" << setw(10) << "����" << setw(10) << "���ʱ��" << endl;
	while (p->next != NULL)
	{
		p = p->next;
		cout << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;
		cout << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
		cout << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
		output << setiosflags(ios::left) << setw(10) << p->code << setw(16) << p->name;//���ļ�����ʾ��Ӧ��Ʒ��Ϣ
		output << setw(10) << p->brand << setw(10) << p->price << setw(10) << p->type;
		output << setw(10) << p->num << p->date.year << "/" << p->date.month << "/" << p->date.day << endl;
	}
	cout << endl;
	cout << "�ɹ���������Ϣ���浽<������Ϣ.txt>" << endl;
	cout << "������Ϣ������ϡ���" << endl;
	cout << "������������������˵�����" << endl;
	getchar();
	getchar();
	output.close();//�ر�����ļ�
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
			if (c >= 'a' && c <= 'k')//�ж��û��������Ƿ����
				flag = 1;
			else
			{
				cout << "������ı�Ų����ڣ�" << endl;
				cout << "��ѡ����Ӧ�����ֽ��в���:" << endl;
			}
		} while (flag == 0);//�����Ŵ���ʱ����ѭ��������Ӧ����
		system("cls");//����
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
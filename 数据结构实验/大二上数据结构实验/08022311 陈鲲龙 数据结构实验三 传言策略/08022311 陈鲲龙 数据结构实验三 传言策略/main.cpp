#include <iostream>
#include <stack>
#include <vector>
#include <queue>
//#include "massagepath.h"
//#include "massageperson.h"
using namespace std;

int path[15][3] =
{
	    { 4,  7,  7},
	    { 2,  8,  8},
		{ 0,  1, 10},
		{ 0,  5, 11},
		{ 1,  8, 12},
		{ 1,  6, 16},
		{ 3,  7, 16},
		{ 5,  6, 17},
		{ 1,  2, 18},
		{ 6,  7, 19},
		{ 3,  4, 20},
		{ 3,  8, 21},
		{ 2,  3, 22},
		{ 3,  6, 24},
		{ 4,  5, 26}
};//�ñ߼����� ͼ�ṹ ���ص����ڱ� ������kruskal������Ҫ�Աߴ�����㷨

//int massagepathvalue[9][9] =
//{
//		{ 0, 10,  0,  0,  0, 11,  0,  0,  0},
//		{10,  0, 18,  0,  0,  0, 16,  0, 12},
//		{ 0, 18,  0, 22,  0,  0,  0,  0,  8},
//		{ 0,  0, 22,  0, 20,  0, 24, 16, 21},
//		{ 0,  0,  0, 20,  0, 26,  0,  7,  0},
//		{11,  0,  0,  0, 26,  0, 17,  0,  0},
//		{ 0, 16,  0, 24,  0, 17,  0, 19,  0},
//		{ 0,  0,  0, 16,  7,  0, 19,  0,  0},
//		{ 0, 12,  8, 21,  0,  0,  0,  0,  0}
//};//�ڽӾ��󴢴�ͼ�ṹ��������ʱ��ֱ�Ӹ�ֵ�������
int massagepathvalue[8][8] =
{
		{ 0,  2,  0,  0,  0,  0,  6,  0, },
		{ 2,  0,  7,  0,  2,  0,  0,  0, },
		{ 0,  7,  0,  3,  0,  3,  0,  0, },
		{ 0,  0,  3,  0,  0,  0,  0,  2, },
		{ 0,  2,  0,  0,  0,  2,  1,  0, },
		{ 0,  0,  3,  0,  2,  0,  0,  2, },
		{ 6,  0,  0,  0,  1,  0,  0,  4, },
		{ 0,  0,  0,  2,  0,  2,  4,  0, }
};//�ڽӾ��󴢴�ͼ�ṹ��������ʱ��ֱ�Ӹ�ֵ�������

int a = 0;

int Dijkstrapathvalue[8][8] = { 0 };//��Dijkstra�㷨ʹ�ã����޸ľ����е�ֵ��
int Dijkstracolmin = 100;//����Dijkstra�㷨��������Сֵ
int Dijkstrarowmin = 100;//����Dijkstra�㷨��������Сֵ
int dijkstra[8][8] = { 0 };
int flag = 0;
int location = 0;
queue<int> key;

void Dijkstrainit()
{
	Dijkstracolmin = 100;
	Dijkstrarowmin = 100;
	flag = 0;
	location = 0;
	for (int i = 0; i < 8; i++)
	{
		for (int j = 0; j < 8; j++)
		{
			Dijkstrapathvalue[i][j] = massagepathvalue[i][j];
			dijkstra[i][j] = 0;
		}
	}
}

void Dijkstra()
{
	Dijkstracolmin = 100;
	if (flag == 7)
		return;
	if (flag == 0)
	{
		for (int i = 0; i < 8; i++)
		{
			dijkstra[i][flag] = Dijkstrapathvalue[location][i];
		}
	}
	for (int i = 0; i < 8; i++)
	{
		Dijkstrapathvalue[i][location] = 0;
	}
	for (int i = 0; i < 8; i++)
	{
		if (dijkstra[i][flag] != 0 && dijkstra[i][flag] < Dijkstracolmin)
		{
			Dijkstracolmin = dijkstra[i][flag];
		}
	}
	for (int i = 0; i < 8; i++)
	{
		if (dijkstra[i][flag] == Dijkstracolmin)
		{
			location = i;
		}
	}
	key.push(location);
	for (int i = 0; i < 8; i++)
	{
		Dijkstrapathvalue[i][location] = 0;
	}
	for (int i = 0; i < 8; i++)
	{
		if (Dijkstrapathvalue[location][i] != 0)
		{
			Dijkstrarowmin = Dijkstracolmin + Dijkstrapathvalue[location][i];
			for (int j = 0; j < flag + 1; j++)
			{
				if (dijkstra[i][j] != 0 && dijkstra[i][j] < Dijkstrarowmin)
				{
					Dijkstrarowmin = dijkstra[i][j];
				}
			}
			dijkstra[i][flag + 1] = Dijkstrarowmin;
		}
		else
		{
			if (i != location)
				dijkstra[i][flag + 1] = dijkstra[i][flag];
			else
			{
				dijkstra[i][flag + 1] = 0;
			}
		}
	}
	flag++;
	Dijkstra();
}

int floyd[9][9] = { 0 };
int floyd_k = 0;
int floydcolmin = 100;
int floydrowmax = 0;
int floydstart = 0;
void floydinit()
{
	for (int i = 0; i < 9; i++)
	{
		for (int j = 0; j < 9; j++)
		{
			if (massagepathvalue[i][j] != 0)
				floyd[i][j] = massagepathvalue[i][j];
			else
			{
				floyd[i][j] = 100;
			}
		}
	}
	for (int i = 0; i < 9; i++)
	{
		floyd[i][i] = 0;
	}
}
void Floyd()
{
	for (floyd_k = 0; floyd_k < 9; floyd_k++)
	{
		for (int i = 0; i < 9; i++)
		{
			for (int j = 0; j < 9; j++)
			{
				if (i != floyd_k && j != floyd_k)
				{
					if (floyd[i][j] <= floyd[floyd_k][j] + floyd[i][floyd_k])
						floyd[i][j] = floyd[i][j];
					if (floyd[i][j] > floyd[floyd_k][j] + floyd[i][floyd_k])
						floyd[i][j] = floyd[floyd_k][j] + floyd[i][floyd_k];
				}
			}
		}
	}
	for (int i = 0; i < 9; i++)
	{
		floydrowmax = 0;
		for (int j = 0; j < 9; j++)
		{
			if (floyd[i][j] > floydrowmax)
				floydrowmax = floyd[i][j];
		}
		if (floydrowmax < floydcolmin)
		{
			floydcolmin = floydrowmax;
			floydstart = i;
		}
	}
}

void printnet()
{
	for (int i = 0; i < 9; i++)
	{
		cout << i << "�ŵĹ�����ԱΪ��";
		for (int j = 0; j < 9; j++)
		{
			if (massagepathvalue[i][j] != 0)
			{
				cout << j << ",";
			}
		}
		cout << endl;
	}
}

void find(int n)
{
	cout << n << "�ŵĹ�����ԱΪ��";
	for (int j = 0; j < 9; j++)
	{
		if (massagepathvalue[n][j] != 0)
		{
			cout << j << ",";
		}
	}
	cout << endl << "���������ҵ���" << endl;
	cin >> a;
	if (a >= 0 && a < 9)
	{
		find(a);
		cout << endl;
	}
	else
	{
		return;
	}
}

void kruskal()
{
	int path[15] = { 0 };
	int count = 0;
	for (int i = 0; i < 9; i++)
	{
		for (int j = i; j < 9; j++)
		{
			if (massagepathvalue[i][j] != 0)
			{
				path[count] = massagepathvalue[i][j];
				count++;
			}
		}
	}
	for (int i = 0; i < 15; i++)
	{
		for (int j = i + 1; j < 15; j++)
		{
			if (path[i] > path[j])
			{
				int temp = path[i];
				path[i] = path[j];
				path[j] = temp;
			}
		}
	}
	int ifpath[9] = { 0,0,0,0,0,0,0,0,0 };
	int sumpath = 0;
	count = 0;
	int lastpath = 0;
	for (int u = 0; u < 15; u++)
	{
		for (int i = 0; i < 9; i++)
		{
			for (int j = 0; j < 9; j++)
			{
				if ((massagepathvalue[i][j] == path[u]) && ((ifpath[i] + ifpath[j] == 0) || (ifpath[i] != ifpath[j])))
				{
					int lasti = ifpath[i];
					int lastj = ifpath[j];
					lastpath = path[u];
					for (int v = 0; v < 9; v++)
					{
						if ((ifpath[v] == lasti) || (ifpath[v] == lastj))
						{
							if (ifpath[v] != 0)
							{
								ifpath[v] = path[u] + count;
							}
						}
					}
					ifpath[i] = path[u] + count;
					ifpath[j] = path[u] + count;
					sumpath += path[u];
					count++;
					cout << i << ',' << j << ',' << path[u] << "  ";
				}
			}
		}
	}
	cout << endl << "��Сʱ�䣨���ѣ�Ϊ�� " << sumpath;
}


int main()
{
	while (1)
	{
		cout << endl;
		cout << "1.��ӡ��Ա��Ϣ" << endl;
		cout << "2.��ĳ�˹�����������" << endl;
		cout << "3.kruskal" << endl;
		cout << "4.Dijkstra" << endl;
		cout << "5.Floyd" << endl;
		int c = 0;
		cin >> c;
		if (c > 0 && c < 6)
		{
			switch (c)
			{
			case 1:
				cout << "��ӡ��Ա������Ϣ" << endl;
				printnet();
				break;
			case 2:
				cout << "���������ҵ���" << endl;
				cin >> a;
				if (a >= 0 && a < 9)
				{
					find(a);
					cout << endl;
				}
				else
				{
					break;
				}
				break;
			case 3:
				cout << "kruskal" << endl;
				cout << "���漰��·��Ϊ���˵���ţ��˵���ţ�����ʱ�䣨���ѣ����� " << endl;
				kruskal();
				break;
			case 4:
				Dijkstrainit();
				cout << "Dijkstra" << endl;
				cout << "�Ӽ��ſ�ʼ" << endl;
				cin >> a;
				location = a;
				Dijkstra();
				cout << "���·����ֵΪ��" << dijkstra[key.back()][6] << endl;
				cout << "Dijkstra�ҵ������·������Ϊ��" << endl;
				cout << " " << a << " ";
				while (!key.empty())
				{
					cout << " " << key.front() << " ";
					key.pop();
				}
				cout << endl << "Dijkstra�����ڲ����ݴ��������̴�ӡ����" << endl;
				for (int j = 0; j < 8; j++)
				{
					for (int i = 0; i < 7; i++)
					{
						cout << "     " << dijkstra[j][i] << "     ";
					}
					cout << endl;
				}
				break;
			case 5:
				floydinit();
				cout << "floyd" << endl;
				Floyd();
				cout << "floyd���Ϊ��" << floydstart << endl;
				cout << "�������floyd���·����ֵΪ��" << floydcolmin << endl;
				cout << endl << "Floyd�����ӡ����" << endl;
				for (int j = 0; j < 9; j++)
				{
					for (int i = 0; i < 9; i++)
					{
						cout << "     " << floyd[j][i] << "     ";
					}
					cout << endl;
				}
				break;
			}
		}
	}
}


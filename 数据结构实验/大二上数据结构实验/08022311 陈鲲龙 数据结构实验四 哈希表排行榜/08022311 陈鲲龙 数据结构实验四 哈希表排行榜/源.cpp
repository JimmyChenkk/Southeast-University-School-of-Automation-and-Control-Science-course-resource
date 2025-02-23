#include <stdio.h>
#include <time.h>   
#include <stdlib.h> 
#include <ctype.h>  
#include <string.h> 
#include <windows.h>
#include <iostream>
#include <fstream> 

#define HASH_LEN 20 //��ϣ��ĳ���
#define P 17        //С�ڹ�ϣ���ȵ�P
using namespace std;

//��ȡ������ ASCII ֮��
int calculateAsciiSum(const std::string& str)
{
	int sum = 0;

	for (char c : str) {
		sum += static_cast<int>(c);
	}

	return sum;
}

// ������Ϣ�ṹ��
class Singer {
public:
	int HASH = 0;
	int ASL = 0;
	string name;
	string song;
	int votes = 0;

	// Ĭ�Ϲ��캯��
	Singer() {}
	// ���캯��
	Singer(string& n, string& song, int v)
		: name(n), song(song), votes(v) {}
};

Singer* SingerHash[HASH_LEN] = { nullptr };

void vote(string& n, string& song, int v)
{
	int flag = 0;
	for (int i = 0; i < HASH_LEN; i++)
	{
		if (SingerHash[i] != nullptr)
		{
			if (SingerHash[i]->name == n)
			{
				SingerHash[i]->votes += v;
				flag = 1;
			}
		}
	}

	if (flag == 0)
	{
		Singer* newsinger = new Singer(n, song, v);
		newsinger->HASH = calculateAsciiSum(n) % P;
		newsinger->ASL++;
		if (SingerHash[newsinger->HASH] == nullptr)
		{
			SingerHash[newsinger->HASH] = newsinger;

			ofstream outFile("vote.dat", ios::out | ios::binary);//������д���ļ�
			outFile.write((char*)&newsinger, sizeof(newsinger));
			outFile.close();
		}
		else
		{
			for (int i = newsinger->HASH + 1;; i++)
			{
				newsinger->ASL++;
				if (SingerHash[i % HASH_LEN] == nullptr)
				{
					SingerHash[i % HASH_LEN] = newsinger;

					ofstream outFile("vote.dat", ios::out | ios::binary);//������д���ļ�
					outFile.write((char*)&newsinger, sizeof(newsinger));
					outFile.close();

					break;
				}

			}
		}
	}
}

void find(string& n)
{
	for (int i = calculateAsciiSum(n) % P;; i++)
	{
		if (SingerHash[i]->name == n)
		{
			cout << i
				<< "  ���֣�" << SingerHash[i]->name
				<< "  ������" << SingerHash[i]->song
				<< "  Ʊ����" << SingerHash[i]->votes
				<< "  ���ң�" << SingerHash[i]->ASL
				<< "  " << endl;
			break;
		}
	}
}

class node
{
public:
	int value = 0;
	node* left = nullptr;
	node* right = nullptr;
	Singer* index;
	node(Singer* idx, int v) { value = v; index = idx; }
};

int inordercount = 0;
void inOrder(node* root) {//����
	if (inordercount < 9)
	{
		if (root == nullptr) {}
		else
		{
			inOrder(root->right);
			cout
				<< "  ���֣�" << root->index->name
				<< "  ������" << root->index->song
				<< "  Ʊ����" << root->index->votes
				<< "  ���ң�" << root->index->ASL
				<< "  " << endl;
			inordercount++;
			inOrder(root->left);
		}
	}
}

void createtree(Singer* i,node* newnode,node* root)
{
	if (i->votes != root->index->votes)
	{
		if (i->votes < root->index->votes)
		{
			if (root->left != nullptr)
			{
				createtree(i,newnode, root->left);
			}
			else
			{
				root->left = newnode;
				return;
			}
		}
		else if (i->votes > root->index->votes)
		{
			if (root->right != nullptr)
			{
				createtree(i, newnode, root->right);
			}
			else
			{
				root->right = newnode;
				return;
			}
		}
	}
}

void view() //��������
{
	printf("=======================================================\n");
	printf("=                   08022311������                    =\n");
	printf("=                   ��ϣ���������                    =\n");
	printf("=                                                     =\n");
	printf("=  1: ͶƱ                       2: ��ӡ��ϣ��        =\n");
	printf("=                                                     =\n");
	printf("=  3: ����                       4: ���а�            =\n");
	printf("=  5:��ȡ�ļ�                                         =\n");
	printf("=======================================================\n");
}

void readfile()
{
	for (int i = 0; i < HASH_LEN; i++)
	{
		if (SingerHash[i]!=nullptr)
		{
			Singer s = *SingerHash[i];
			ifstream inFile("vote.dat", ios::in | ios::binary);//�����ƶ�ȡ�ļ�
			if (!inFile)
			{
				cout << "error" << endl;
				return;
			}
			while (inFile.read((char*)&s, sizeof(s)))
			{
				cout <<i
					<< "  ���֣�" << s.name
					<< "  ������" << s.song
					<< "  Ʊ����" << s.votes
					<< "  ���ң�" << s.ASL
					<< "  " << endl;
			}
			inFile.close();
		}
		else
		{
			cout << i << "   " << "NULL" << endl;
		}
	}
}

int main() //������
{
	string  n;
	string song;
	int v;
	int a = 0;
	view();       //���ý������溯��
	while (1)
	{
		printf("\n����ѡ��:");
		cin >> a;
		if (a > 0 && a < 6)
		{
			switch (a) //����ѡ������жϣ�ֱ��ѡ���˳�ʱ�ſ����˳�
			{
			case 1:
				cout << "���֣�" << endl;
				cin >> n;
				cout << "������" << endl;
				cin >> song;
				cout << "Ʊ����" << endl;
				cin >> v;
				vote(n, song, v);
				break;
			case 2:
				cout << "��ϣ��" << endl;
				for (int i = 0; i < HASH_LEN; i++)
				{
					if (SingerHash[i] != nullptr)
					{
						cout << i
							<< "  ���֣�" << SingerHash[i]->name
							<< "  ������" << SingerHash[i]->song
							<< "  Ʊ����" << SingerHash[i]->votes
							<< "  ���ң�" << SingerHash[i]->ASL
							<< "  " << endl;
					}
					else
					{
						cout << i << "   " << "NULL" << endl;
					}
				}
				break; //��ӡ��ϣ��
			case 3:
				cout << "���֣�" << endl;
				cin >> n;
				find(n);
				break;
			case 4:
			{node* root = new node(SingerHash[12], SingerHash[12]->votes);
			for (int i = 0; i < HASH_LEN; i++)
			{
				if (SingerHash[i] != nullptr)
				{
					node* newnode = new node(SingerHash[i], SingerHash[i]->votes);
					createtree(SingerHash[i], newnode, root);
				}
			}

			inOrder(root);
			}//ѧ���� switchcase��Ҫ���������Ҫ�Ӵ����� ���򱨴�case��ǩ����������ʼ��
				break;
			case 5:
				readfile();
				break;
			}
		}
	}
	return 0;
}


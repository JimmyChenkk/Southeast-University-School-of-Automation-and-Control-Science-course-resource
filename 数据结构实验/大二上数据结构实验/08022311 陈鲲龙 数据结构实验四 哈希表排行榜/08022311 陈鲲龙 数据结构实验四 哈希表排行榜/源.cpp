#include <stdio.h>
#include <time.h>   
#include <stdlib.h> 
#include <ctype.h>  
#include <string.h> 
#include <windows.h>
#include <iostream>
#include <fstream> 

#define HASH_LEN 20 //哈希表的长度
#define P 17        //小于哈希表长度的P
using namespace std;

//获取姓名的 ASCII 之和
int calculateAsciiSum(const std::string& str)
{
	int sum = 0;

	for (char c : str) {
		sum += static_cast<int>(c);
	}

	return sum;
}

// 歌手信息结构体
class Singer {
public:
	int HASH = 0;
	int ASL = 0;
	string name;
	string song;
	int votes = 0;

	// 默认构造函数
	Singer() {}
	// 构造函数
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

			ofstream outFile("vote.dat", ios::out | ios::binary);//二进制写入文件
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

					ofstream outFile("vote.dat", ios::out | ios::binary);//二进制写入文件
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
				<< "  歌手：" << SingerHash[i]->name
				<< "  歌名：" << SingerHash[i]->song
				<< "  票数：" << SingerHash[i]->votes
				<< "  查找：" << SingerHash[i]->ASL
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
void inOrder(node* root) {//中序
	if (inordercount < 9)
	{
		if (root == nullptr) {}
		else
		{
			inOrder(root->right);
			cout
				<< "  歌手：" << root->index->name
				<< "  歌名：" << root->index->song
				<< "  票数：" << root->index->votes
				<< "  查找：" << root->index->ASL
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

void view() //交互界面
{
	printf("=======================================================\n");
	printf("=                   08022311陈鲲龙                    =\n");
	printf("=                   哈希表歌手排行                    =\n");
	printf("=                                                     =\n");
	printf("=  1: 投票                       2: 打印哈希表        =\n");
	printf("=                                                     =\n");
	printf("=  3: 查找                       4: 排行榜            =\n");
	printf("=  5:读取文件                                         =\n");
	printf("=======================================================\n");
}

void readfile()
{
	for (int i = 0; i < HASH_LEN; i++)
	{
		if (SingerHash[i]!=nullptr)
		{
			Singer s = *SingerHash[i];
			ifstream inFile("vote.dat", ios::in | ios::binary);//二进制读取文件
			if (!inFile)
			{
				cout << "error" << endl;
				return;
			}
			while (inFile.read((char*)&s, sizeof(s)))
			{
				cout <<i
					<< "  歌手：" << s.name
					<< "  歌名：" << s.song
					<< "  票数：" << s.votes
					<< "  查找：" << s.ASL
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

int main() //主函数
{
	string  n;
	string song;
	int v;
	int a = 0;
	view();       //调用交互界面函数
	while (1)
	{
		printf("\n输入选项:");
		cin >> a;
		if (a > 0 && a < 6)
		{
			switch (a) //根据选择进行判断，直到选择退出时才可以退出
			{
			case 1:
				cout << "歌手：" << endl;
				cin >> n;
				cout << "歌名：" << endl;
				cin >> song;
				cout << "票数：" << endl;
				cin >> v;
				vote(n, song, v);
				break;
			case 2:
				cout << "哈希表：" << endl;
				for (int i = 0; i < HASH_LEN; i++)
				{
					if (SingerHash[i] != nullptr)
					{
						cout << i
							<< "  歌手：" << SingerHash[i]->name
							<< "  歌名：" << SingerHash[i]->song
							<< "  票数：" << SingerHash[i]->votes
							<< "  查找：" << SingerHash[i]->ASL
							<< "  " << endl;
					}
					else
					{
						cout << i << "   " << "NULL" << endl;
					}
				}
				break; //打印哈希表
			case 3:
				cout << "歌手：" << endl;
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
			}//学到了 switchcase中要定义变量就要加大括号 否则报错：case标签跳过变量初始化
				break;
			case 5:
				readfile();
				break;
			}
		}
	}
	return 0;
}


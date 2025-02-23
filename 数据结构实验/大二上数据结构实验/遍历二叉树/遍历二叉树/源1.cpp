#include<iostream>
#include<stdio.h>
#include<malloc.h>
#include<string>
using namespace std;
#define ElemType int

int maxnum = 0;//储存树中最大值

class Node//每个结点包含结点存放的数据以及指向此结点的左、右孩子结点的指针
{
public:
	ElemType data;
	Node* lchild, * rchild;
};

void createTree(Node* &root) {//这里的&十分重要 不可删去 否则值传递无法修改主函数中的tr变量
	int ch;
	cout << "请输入结点中存放的数据：";
	cin >> ch;
	if (ch == 0)
	{
		root = nullptr;
	}
	else
	{
		root = new(Node);
		root->data = ch;
		createTree(root->lchild);//递归，直到结点的左右孩子都被赋0即nullptr才停止
		createTree(root->rchild);
	}
}

void findmax(int t) {//比大小找树中最大值
	if (t > maxnum)
		maxnum = t;
}

void preOrder(Node* root) {//先序
	if (root == nullptr) {}
	else
	{
		findmax(root->data);//(三种)遍历时顺便比较找最大值

		cout << root->data << "  ";
		preOrder(root->lchild);
		preOrder(root->rchild);

	}
}

void inOrder(Node* root) {//中序
	if (root == nullptr) {}
	else
	{
		findmax(root->data);

		inOrder(root->lchild); 
		cout << root->data << "  ";
		inOrder(root->rchild);
	}
}

void postOrder(Node* root) {//后序
	if (root == nullptr) {}
	else
	{
		findmax(root->data);

		postOrder(root->lchild);
		postOrder(root->rchild);
		cout << root->data << "  ";

	}
}

int main() {
	Node* tr = nullptr;
	cout << "先序创建树（需要用0补成完全二叉树！）：\n";
	createTree(tr);
	cout << "先序遍历：\n";
	preOrder(tr);
	cout << "\n中序遍历：\n";
	inOrder(tr);
	cout << "\n后序遍历：\n";
	postOrder(tr);
	cout << endl;
	cout << "最大值为：" << maxnum;
	return 0;
}
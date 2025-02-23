#include<iostream>
#include<stdio.h>
#include<malloc.h>
#include<string>
using namespace std;
#define ElemType int

int maxnum = 0;//�����������ֵ

class Node//ÿ������������ŵ������Լ�ָ��˽������Һ��ӽ���ָ��
{
public:
	ElemType data;
	Node* lchild, * rchild;
};

void createTree(Node* &root) {//�����&ʮ����Ҫ ����ɾȥ ����ֵ�����޷��޸��������е�tr����
	int ch;
	cout << "���������д�ŵ����ݣ�";
	cin >> ch;
	if (ch == 0)
	{
		root = nullptr;
	}
	else
	{
		root = new(Node);
		root->data = ch;
		createTree(root->lchild);//�ݹ飬ֱ���������Һ��Ӷ�����0��nullptr��ֹͣ
		createTree(root->rchild);
	}
}

void findmax(int t) {//�ȴ�С���������ֵ
	if (t > maxnum)
		maxnum = t;
}

void preOrder(Node* root) {//����
	if (root == nullptr) {}
	else
	{
		findmax(root->data);//(����)����ʱ˳��Ƚ������ֵ

		cout << root->data << "  ";
		preOrder(root->lchild);
		preOrder(root->rchild);

	}
}

void inOrder(Node* root) {//����
	if (root == nullptr) {}
	else
	{
		findmax(root->data);

		inOrder(root->lchild); 
		cout << root->data << "  ";
		inOrder(root->rchild);
	}
}

void postOrder(Node* root) {//����
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
	cout << "���򴴽�������Ҫ��0������ȫ������������\n";
	createTree(tr);
	cout << "���������\n";
	preOrder(tr);
	cout << "\n���������\n";
	inOrder(tr);
	cout << "\n���������\n";
	postOrder(tr);
	cout << endl;
	cout << "���ֵΪ��" << maxnum;
	return 0;
}
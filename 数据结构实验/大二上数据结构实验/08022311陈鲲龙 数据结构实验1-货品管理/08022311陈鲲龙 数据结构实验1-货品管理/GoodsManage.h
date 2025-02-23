#pragma once
#include<iostream>
#include<fstream>
#include<string>
#include<iomanip>
#include<windows.h>
using namespace std;

enum GoodsType//��Ʒ���
{
	Food = 1,//ʳƷ
	Stationery,//�ľ�
	Commodity,//����Ʒ
	Drink//����
};

struct Date
{
	int year;
	int month;
	int day;
};

struct Goods//��Ʒ������Ϣ
{
	string code;//��Ʒ���
	string name;//��Ʒ����
	string brand;//��������
	double price;//��Ʒ�۸�
	int num;//��Ʒ����
	GoodsType type;//��Ʒ���
	Date date;//���ʱ��
	Goods* next;
};

class GoodsManage
{
public:
	GoodsManage();
	~GoodsManage() {}
	void DisplayMainMenu();//���˵���ʾ
	void AddGoodsInfo();//�����Ʒ��Ϣ
	void DisplayGoodsInfo();//�����Ʒ��Ϣ
	void SearchByCode();//������Ʒ���������Ʒ��Ϣ
	void SearchByName();//������Ʒ����������Ʒ��Ϣ
	void DeleteGoodsInfo();//ɾ����Ʒ��Ϣ
	void SellGoodsInfo();//������Ʒ��Ϣ
	void SaveGoodsInfo();//������Ʒ��Ϣ
	void Run();//��Ӫ��װ����������
private:
	int amount;//��Ʒ��
	int DeleteAmount;
	Goods* head;
	Goods* DeleteHead;
};


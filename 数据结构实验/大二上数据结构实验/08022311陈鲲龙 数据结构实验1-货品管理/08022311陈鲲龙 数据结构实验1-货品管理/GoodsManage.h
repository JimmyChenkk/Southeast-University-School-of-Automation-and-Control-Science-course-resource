#pragma once
#include<iostream>
#include<fstream>
#include<string>
#include<iomanip>
#include<windows.h>
using namespace std;

enum GoodsType//商品类别
{
	Food = 1,//食品
	Stationery,//文具
	Commodity,//日用品
	Drink//饮料
};

struct Date
{
	int year;
	int month;
	int day;
};

struct Goods//商品基本信息
{
	string code;//商品编号
	string name;//商品名称
	string brand;//生产厂家
	double price;//商品价格
	int num;//商品数量
	GoodsType type;//商品类别
	Date date;//入库时间
	Goods* next;
};

class GoodsManage
{
public:
	GoodsManage();
	~GoodsManage() {}
	void DisplayMainMenu();//主菜单显示
	void AddGoodsInfo();//添加商品信息
	void DisplayGoodsInfo();//浏览商品信息
	void SearchByCode();//按照商品编号搜索商品信息
	void SearchByName();//按照商品名称搜索商品信息
	void DeleteGoodsInfo();//删除商品信息
	void SellGoodsInfo();//出售商品信息
	void SaveGoodsInfo();//保存商品信息
	void Run();//运营封装（主函数）
private:
	int amount;//商品量
	int DeleteAmount;
	Goods* head;
	Goods* DeleteHead;
};


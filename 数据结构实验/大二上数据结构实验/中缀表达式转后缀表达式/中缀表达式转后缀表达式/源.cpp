#include<iostream>
using namespace std;
template<class T>
class Stack
{
private:
	int top;
	T* elements;
	int MaxSize;
public:
	Stack(int Maxsize);
	~Stack() {
		delete[]elements;
	}
	int push(const T& x);
	int size();
	T pop();
	T gettop();
	void MakeEmpty() {
		top = -1;
	}
	bool empty() {
		return top == -1;
	}
	bool full() {
		return top == MaxSize - 1;
	}
};
template<class T>
int Stack<T>::size()
{
	return top + 1;
}
template<class T>
Stack<T>::Stack(int Maxsize)
{
	top = -1;
	elements = new T[MaxSize];
	MaxSize = Maxsize;
}
template<class T>
int Stack<T>::push(const T& x)
{
	if (!full()) {
		elements[++top] = x;
		return 0;
	}
	return -1;
}
template<class T>
T Stack<T>::pop()
{
	return elements[top--];
}
template<class T>
T Stack<T>::gettop()
{

	return elements[top];
}
int rnk(char x)
{
	if (x == '*' || x == '/')return 2;
	if (x == '+' || x == '-')return 1;
	if (x == '(')return 0;
	else return -1;
}
int isoperator(char x)//判断一个字符是否为操作符； 
{
	if (x == '+' || x == '-' || x == '*' || x == '/' || x == '(' || x == ')')return 1;
	else return 0;
}
int main()
{
	Stack<char> ins(100);//存放操作符的栈；
	char exp[100];//中缀表达式；
	char res[200];//存放后缀表达式；
	int i = 0;
	cin.getline(exp, 100);//使用getline防止输入空格时cin无法读取全部表达式；
	for (int k = 0; exp[k] != '\0'; k++)
	{
		int a = ins.size();
		if (exp[k] == ' ')continue;//防止误输入空格；
		if (!isoperator(exp[k]))
		{
			res[i++] = exp[k];
			continue;
		}
		else
		{
			if (ins.empty()) {
				ins.push(exp[k]);
				continue;
			}
			if (exp[k] == '(')
			{
				ins.push(exp[k]);
				continue;
			}
			if (exp[k] == ')')
			{
				while (ins.gettop() != '(')
				{
					res[i++] = ins.pop();
				}
				ins.pop();//去除'(';
				continue;
			}
			else
			{
				while ((rnk(ins.gettop()) >= rnk(exp[k])) && !ins.empty())
				{
					res[i++] = ins.pop();
				}
				ins.push(exp[k]);
			}

		}

	}
	while (ins.size() != 0)
	{
		res[i++] = ins.pop();
	}
	for (int j = 0; j < i; j++)
	{
		cout << res[j];
	}
}
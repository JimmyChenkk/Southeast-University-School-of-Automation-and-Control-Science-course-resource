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
int isoperator(char x)//�ж�һ���ַ��Ƿ�Ϊ�������� 
{
	if (x == '+' || x == '-' || x == '*' || x == '/' || x == '(' || x == ')')return 1;
	else return 0;
}
int main()
{
	Stack<char> ins(100);//��Ų�������ջ��
	char exp[100];//��׺���ʽ��
	char res[200];//��ź�׺���ʽ��
	int i = 0;
	cin.getline(exp, 100);//ʹ��getline��ֹ����ո�ʱcin�޷���ȡȫ�����ʽ��
	for (int k = 0; exp[k] != '\0'; k++)
	{
		int a = ins.size();
		if (exp[k] == ' ')continue;//��ֹ������ո�
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
				ins.pop();//ȥ��'(';
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
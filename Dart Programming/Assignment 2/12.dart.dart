import 'dart:io';

void main()
{
  int n,i,a=0;
  stdout.write("Enter Number:");
  n = int.parse(stdin.readLineSync()!);

  if(n==0 || n==1)
	a = 1;
	for(i=2;i<=n/2;++i)
	{
		if(n%i==0)
		{
			a = 1;
			break;
		}
	}
	if(a==0)
  {
	  print("is a prime number.");
  }
	else
  {
	  print("is not a prime number.");
  }
}
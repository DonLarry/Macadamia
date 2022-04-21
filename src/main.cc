#define MAIN_DEBUG 0

#if !MAIN_DEBUG

#include <stdio.h>
#include "driver.hh"

int main(int argc, char *argv[])
{
  driver drv;
  std::string file;
  for (int i=1; i<argc; ++i)
  {
    if (argv[i] == std::string("-d"))
      drv.trace_parsing = true;
    else if (argv[i] == std::string("-s"))
      drv.trace_scanning = true;
    else if (file.empty())
      file = argv[i];
    else
      std::cerr << "Usage: " << argv[0] << " [-d] [-s] file.txt" << std::endl;
  }
  std::cout << "The input is " + std::string(!drv.parse(file) ? "valid" : "invalid") << std::endl;
  return drv.result;
}

#else

#include "types.hh"

#include <iostream>

using namespace std;


int main()
{
  Number *a = new IntegerNumber(14);
  Number *b = new FloatNumber(3.14159);
  Number *c = new IntegerNumber(2);
  Number *d = new FloatNumber(8.71828);
  cout << ((FloatNumber*)add(*a, *b))->value << endl;
  cout << ((FloatNumber*)sub(*a, *b))->value << endl;
  cout << ((FloatNumber*)mul(*a, *b))->value << endl;
  cout << ((FloatNumber*)div(*a, *b))->value << endl;
  cout << ((IntegerNumber*)add(*a, *c))->value << endl;
  cout << ((IntegerNumber*)sub(*a, *c))->value << endl;
  cout << ((IntegerNumber*)mul(*a, *c))->value << endl;
  cout << ((IntegerNumber*)div(*a, *c))->value << endl;
  cout << ((FloatNumber*)add(*a, *d))->value << endl;
  cout << ((FloatNumber*)sub(*a, *d))->value << endl;
  cout << ((FloatNumber*)mul(*a, *d))->value << endl;
  cout << ((FloatNumber*)div(*a, *d))->value << endl;
  return 0;
}

#endif

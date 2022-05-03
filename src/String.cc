#include "String.hh"


String::String() : Expression(STRING)
{
  // empty
}

String::String(std::string value) : Expression(STRING), value(value.substr(1, value.size() - 2))
{
  // empty
}

String* add(String &a, String &b)
{
  auto valueA = ((String*)&a)->value;
  auto valueB = ((String*)&b)->value;

  return new String(valueA + valueB);
}

void String::print(std::ostream& os)
{
  os << value;
}

std::string String::codegen()
{
  return "\"" + value + "\"";
}

std::ostream& operator<<(std::ostream& os, String& str)
{
  str.print(os);
  return os;
}

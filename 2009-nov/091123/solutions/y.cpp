#include <fstream.h>
#include <string.h>

int main(){
  ifstream in("y.in"); // Открываем входной файл
  ofstream out("y.out"); // Открываем выходной файл
  char s[1000000]; // Заводим место для строки
  in >> s; // Вводим строку из входного файла
  for(int i=0;i<strlen(s);i++) // Выводим перевёрнутую строку
    out << s[strlen(s)-i-1];
  in.close(); out.close(); // Закрываем входной и выходной файлы
  return 0;
}

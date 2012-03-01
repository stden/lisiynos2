using System;
using System.Collections.Generic;
using System.Text;

namespace SolGen
{
  class Task
  {
    public string Name;
    public string TaskShortName;
    public string Vars;
    public string InExample;
    public string OutExample;
    public string Read;
    /// <summary>
    /// Ограничения из условия задачи
    /// </summary>
    public string Limits;
    /// <summary>
    /// Если есть очевидное решение, то не нужно писать Тупые решения
    /// </summary>
    public bool notBF = false;
    /// <summary>
    /// Решение
    /// </summary>
    public string Solve;
    /// <summary>
    /// Запись ответа
    /// </summary>
    public string WriteAnswer;
  }
}

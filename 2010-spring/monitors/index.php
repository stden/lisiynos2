<html>
<head>
<title>Тренировки в СПбГЭТУ</title>
<style type="text/css">
    .c  { text-align: center }
    .j  { text-align: justify }
    .r  { text-align: right }
    em  { color: red }
    .attention { text-align: center; font-family: arial; font-size: big; }
    h1 { text-align: center; font-family: arial; font-size: 20 }
    h2 { text-align: center; font-family: arial; margin-top: 36; font-size: 18 }
    h3 { text-align: center; font-family: arial; font-size: 16 }
    table.main {
	width: 80%;
	border-collapse: collapse;
	border: 1px black solid;
	background-color: #CCFFFF;
    }
    td {
        border: 1px black solid;
        padding: 5pt;
        text-align: left;
    }
    th {
        border: 1px black solid;
        padding: 3pt;
    }
  </style>
</head>
<body>
    <h1>Тренировки в СПбГЭТУ</h1>
    
    <h2>Расписание:</h2>

    <p class="c">
    <center>
        <table class="main" >
            <tr>
                <th bgcolor="#FFFFCC">Мероприятие</th>
                <th bgcolor="#FFFFCC">День недели</th>
                <th bgcolor="#FFFFCC">Время</th>
                <th bgcolor="#FFFFCC">Место</th>
            </tr>
            <tr>
                <td class="main">Разбор задач / лекция</td>
                <td>Понедельник</td>
                <td>18:30</td>
                <td>Ауд. 216</td>
            </tr>
            <tr>
                <td>Тренировка</td>
                <td>Вторник</td>
                <td>18:30</td>
                <td>ЦИТ-1</td>
            </tr>
            <tr>
                <td>Тренировка</td>
                <td>Пятница</td>
                <td>16:45</td>
                <td>ЦИТ-3</td>
            </tr>
        </table>
    </center>
    </p>


    <h2>Список мониторов:</h2>
<center>
<?
  $l=file("files.txt");
  for ($i=0;$i<count($l);$i++){
    $l[$i] = trim($l[$i]);
    if (substr($l[$i],-4)==".dat") 
      echo "<a href=\"show.php?FN=$l[$i]\">$l[$i]</a><br>";
  };

/*  $dn = opendir("");
  $files = array();
  while(gettype($file=readdir($dn))!=boolean){
    if($file!="." && $file!=".." && $file!="links.txt" &&
       $file!="index.php" &&
       !is_dir($file) && substr($file,-4)==".dat"){
      array_push($files,$file);
    };
  };
  closedir($dn);
  //
  sort($files);
  // 
  for($line=0;$line<count($files);$line++){
    $link = str_replace("<b>","",$files[$line]);
    $link = str_replace("</b>","",$link);
    echo("<a href=\"show.php?FN=$link\">$files[$line]</a><br>");
    if (($line+1) % 15 == 0) echo("<td Width=\"200\">"); 
  }; */
?>

К сожалению, материалы второй тренировки (17.09.2004) были утеряны из-за того, что
кто-то удалил их в ЦИТ'е.
</body>
</html>

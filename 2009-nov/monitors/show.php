<?
  function debug( $x ){
    print "<pre>";
    print_r ($x);
    print "</pre>";
  };
  function del_empty( $x ){
    foreach ($x as $key => $value) {
      if(trim($value)!="")
        $res[] = trim($value);
    };
    return $res;
  };
  if(!isset($FN)){ $FN = "jm040914.dat"; };
  assert(file_exists($FN));
  $f = file($FN);
  // Извлечение параметров
  for($i=0;$i<count($f);$i++){
    $par = explode(" ",$f[$i]); // Разбираем очередную строку по пробелам
    $allPar = str_replace($par[0],"",$f[$i]); // Убираем только оператор - считаем, что параметр до конца строки
    $r = explode(",",$par[1]); // Разбиваем $par[1] по запятым
    foreach ($r as $key => $value) { $r[$key]=trim($value); };
    switch ($par[0]){
      case "@contest": $contest = trim($allPar); break;
      // @startat 28.09.2004 18:47:16
      case "@startat": $now_date = $par[1]; $now_time = $par[2]; break;
      // @problems 5
      case "@problems": $problems = $par[1]; break;
      // @teams 10
      case "@teams": $teams = $par[1]; break;
      // @submissions 6
      case "@submissions": $submissions = $par[1]; break;
      // @p A,Азбука для слепых,20,0
      case "@p": $letter=$r[0]; $problem[$letter] = $r[1]; 
        $runs[$letter] = 0; $accepted[$letter] = 0; break;
      // @t 08,0,1,SPb ETU #4
      case "@t": $team[$r[0]] = str_replace($r[0].",".$r[1].",".$r[2].",","",$allPar);
         $team[$r[0]] = trim(str_replace("\"","",$team[$r[0]])); break; 
           // Хитрым replace выделяем имя команды
      // @s 08,A,1,1043,OK
      case "@s": $s_id[]=$r[0]; $s_letter[]=$r[1];
        $s_time[]=$r[3]; $s_result[]=$r[4];
        assert( (count($s_id) == count($s_letter)) &&
                (count($s_letter) == count($s_time)) &&
                (count($s_time) == count($s_result)) );
        break;
    };
  };
  // Подсчёт характеристик
  assert( $submissions = count($s_id));
  $total_accepted = 0;
  unset($AC);
  for($i=0;$i<$submissions;$i++){
    $letter = $s_letter[$i];
    $team_id = $s_id[$i];
    // После первого AC ничего не считаем
    if(isset($AC[$team_id][$letter])) continue;
    // иначе считаем
    $runs[$letter]++;
    if ($s_result[$i]=="OK"){
      $total_accepted++;
      $accepted[$letter]++;
      $last_success = $i;
      $AC[$team_id][$letter] = true;
    };
    $submit_time[$team_id][$letter] = date("H:i:s",mktime(0,0,$s_time[$i],1,1,2000));
    // debug($s_letter[$i]);
    // debug($runs);
  }; 
  // Перерисовка монитора
  $idx = 0;
  for($i=3;trim($f[$i])!=chr(26);$i++){
    $x = del_empty(explode(" ",$f[$i]));
    $mon[$idx]["id"] = $x[0];
    $xi = count($x)-3-$problems;
    foreach ($problem as $p_letter => $p_name) {
      $mon[$idx]["problem ".$p_letter] = $x[$xi];
      $xi++;
    };
    $mon[$idx]["solved"] = $x[count($x)-3];
    $mon[$idx]["time"] = $x[count($x)-2];
    $mon[$idx]["rank"] = $x[count($x)-1];
    $idx++;
  };
  // Расчёт цветов
  $color_flag = true;
  for($i=count($mon)-1;$i>=0;$i--){
    if($mon[$i]["solved"]!=$mon[$i+1]["solved"])
      $color_flag = !$color_flag;
    $mon[$i]["color"] = $color_flag;
  };
  // debug($problem);
  // debug($runs);
?>
<HTML><HEAD><TITLE>Standings</TITLE>
<META http-equiv=Content-Type content="text/html; charset=windows-1251">
<LINK href="standings.css" rel=stylesheet>
</HEAD>
<BODY>
<H2><? print "CПбГЭТУ - ".$contest." - ".$now_date ?></H2>
<P>runs: <? print $submissions ?>, accepted: <? print $total_accepted ?><BR>
last success: <?
  // SarSU: Ivan Romanov, G, 4:59:14
  print $team[$s_id[$last_success]].", ";
  print $s_letter[$last_success].", ";
  print date("H:i:s",mktime(0,0,$s_time[$last_success],1,1,2000)); 
?>
<BR></P>
<P align=center>
<TABLE cellSpacing=0 cellPadding=1 align=center border=0>
  <TBODY>
  <TR>
    <TH class=party>Team</TH>
    <? foreach ($problem as $p_letter => $p_name){ ?>
    <TH class=problem><? print $p_letter; ?></TH>
    <? }; ?>
    <TH class=solved>=</TH>
    <TH class=penalty>Time</TH>
    <TH class=rank>R</TH></TR>
  <TR height=3>
    <TD colSpan=13>
      <HR color=#000000 SIZE=1>
    </TD></TR>
  <? for($t=0;$t<count($mon);$t++) {
       $m = $mon[$t];
       // Выбираем цвет полосы
       if ((!$m["color"]) && ($t % 2 == 0)) $Color = "#ffffff";
       if ((!$m["color"]) && ($t % 2 == 1)) $Color = "#fafafa";
       if (($m["color"]) && ($t % 2 == 0)) $Color = "#e3e3e3";
       if (($m["color"]) && ($t % 2 == 1)) $Color = "#e8e8e8";
       ?>
  <TR bgColor=<? print $Color ?>>
    <TD class=party><? print $team[$m["id"]]; ?></TD>
    <? foreach ($problem as $p_letter => $p_name){ ?>
    <TD><? echo $m["problem ".$p_letter];
      if(isset($submit_time[$m["id"]][$p_letter])){
        echo "&nbsp;<font size=-2><br>".$submit_time[$m["id"]][$p_letter]."</font>&nbsp;";
      };
      ?></TD>
    <? }; ?>
    <TD><? echo $m["solved"]; ?></TD>
    <TD class=penalty><? echo $m["time"]; ?></TD>
    <TD class=rank><? echo $m["rank"]; ?></TD></TR>
  <? }; ?>
  <TR height=3>
    <TD colSpan=13>
      <HR color=#000000 SIZE=1>
    </TD></TR>
  <TR>
    <TD>Total runs</TD>
    <? foreach ($problem as $p_letter => $p_name){ ?>
    <TD align=right><?
      assert( isset($runs[$p_letter]) );
      echo $runs[$p_letter]; ?></TD>
    <? }; ?></TR>
  <TR>
    <TD>Accepted</TD>
    <? foreach ($problem as $p_letter => $p_name){ ?>
    <TD align=right><? echo $accepted[$p_letter]; ?></TD>
    <? }; ?></TR>
  <TR>
    <TD>Rejected</TD>
    <? foreach ($problem as $p_letter => $p_name){ ?>
    <TD align=right><? echo $runs[$p_letter]-$accepted[$p_letter]; ?></TD>
    <? }; ?></TR>

    </TBODY></TABLE></P></BODY></HTML>

#file to kill the process after there signatures have been recorded after running call program.pl

my $file="/home/sanch/Desktop/filemonitoring/files/MSCD/abc11"; 
open(INFO, "$file")|| die "can't open";

	$file = $file . $array[0];           
	open(INFO, "$file")|| die "can't open";  

foreach $line (<INFO>)
{  
$key=$line; 

  
@array=split(' ',$key);
$key=$array[0];
sleep(5);
system("killall -9 ".$key);
sleep(5);
system("killall -9 ".$key);
sleep(5);
system("killall -9 ".$key);
}

exit(0);

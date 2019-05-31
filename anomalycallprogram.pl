my $file="/home/sanch/Desktop/filemonitoring/files/MSCD/abc11"; 
open(INFO, "$file")|| die "can't open";


	$file = $file . $array[0];           
	open(INFO, "$file")|| die "can't open";    

foreach $line (<INFO>)
{  
$key=$line;   
system("strace -o /home/sanch/Desktop/filemonitoring/files/MSCD/abcd ".$key);

system("perl anomalydetection.pl abcd abcd1 abcd2 $key");

}
exit(0);

#file to run each program as specified by the abc11 file three times and store their results in abc1 abc2 and abc3 for further analysis

	my $file="/home/sanch/Desktop/filemonitoring/files/MSCD/abc11"; 
	open(INFO, "$file")|| die "can't open";


	$file = $file . $array[0];           
	open(INFO, "$file")|| die "can't open";  

foreach $line (<INFO>)
{  
$key=$line;   
system("strace -o /home/sanch/Desktop/filemonitoring/files/MSCD/abc1 ".$key);

system("strace -o /home/sanch/Desktop/filemonitoring/files/MSCD/abc2 ".$key);

system("strace -o /home/sanch/Desktop/filemonitoring/files/MSCD/abc3 ".$key);

system("perl syscall.pl abc1 abc2 abc3 abc4 abc5 abc6 abc7 abc8 abc9 abc10 $key");

}
exit(0);

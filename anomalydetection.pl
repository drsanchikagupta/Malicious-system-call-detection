#anomaly detection

use POSIX;
use SDBM_File;

	my %dbm;
	while (my $arg = shift) {       
 		 $array[$g]=$arg;             
 		 $g++; 
	}
	my $db_file=$array[3].".dbm";
	$db_file="/home/sanch/Desktop/filemonitoring/files/MSCD/Database/".$db_file;
	tie %dbm, 'SDBM_File', $db_file, O_CREAT|O_RDWR, 0644;

	if(tied %dbm){sanch
		print "FILE $db_file now open\n";
	}
	else
	{
		die " sorry unable to open $db_file\n";
	}
	$_="";

	my $file="/home/sanch/Desktop/filemonitoring/files/MSCD/";     
	$file = $file . $array[0];  
	open(INFO, "$file")|| die "can't open"; 

	my $file1="/home/sanch/Desktop/filemonitoring/files/MSCD/";    
	$file1=$file1 . $array[1];  
	open(INFO1, "+>$file1") || die "Can't Open File: $file1\n";

	my $file11="/home/sanch/Desktop/filemonitoring/files/MSCD/";    
	$file11 = $file11 . $array[2];
	open(INFOO1, "+>$file11")|| die "can't open";

	$i=0;
	$string="";
	foreach $line (<INFO>)  {
		if($line =~/(.*?)\(/)  
		{
			$i1++; 
			$string[0]=$string[0].$1." "; 
			if($i1%2==0) 
			{
				print INFO1 $string[0]."\n"; 
				$string[0]="";  
			}
			if (exists $hashing{$1})  
			{
				$hashing{$1}+=1;   
			}
			else
			{
				$hashing{$1}=1;  
			}
		}
	}

	print INFO1 "cryptoendcas\n"; 

	close(INFO1);
	open(INFO2, "+<$file1")|| die "can't open";


	#opening the file and reading till "cryptoendcas" and creating a hash that comtains unique system call as key and value as a concatenated string of all syscalls 		found immediate to it this is because in file we have displayed two syscalls separated by a line.
	foreach $line (<INFO2>)  { 

		if($line =~ /(.*)cryptoendcas(.*)/)
		{
			goto END;
		}
		@values= split(' ', $line);

		if (exists $hash{$values[0]})
		{
			$hash{$values[0]}=$hash{$values[0]}." ".$values[1];
		}
		else
		{
			$hash{$values[0]}=$values[1];
		}
	}
	END:

	#creating a file that display syscall followed by all syscalls that are just immediate to it
	my $uniquehash;
	my $stringunique="";

	foreach (keys %hash) {
		@values=split(' ',$hash{$_});
		foreach my $facs (@values) {
  			$uniquehash{$facs} = 1;
		}
		foreach (keys %uniquehash) {

			$stringunique=$stringunique.$_." ";
		}
		$hash{$_}=$stringunique;
		$stringunique="";
		printf INFO2 ("%-30s %-5s", $_, $hash{$_});
		printf INFOO1 ("%-30s %-5s", $_, $hash{$_});
		print INFO2 "\n";
		print INFOO1 "\n";
		$array1[$c]=$hash{$_};
		$c++;
}


	#this code matches the execution of a program immediate syscall signatures with the syscall signatures gathered after two consectuive execution of same 	program

	#this logic counts for matching betwen two executions of program..... matches the immediate sinatures after a particular sinature that are stored in abc5 and 		abc6

	$count=0;
	$countpositive=0;

	$c=0;
	#print %hash;
	foreach (keys %hash) {
		if (exists $dbm{$_})
		{
			@compare=split(' ',$hash{$_});
			@compare1=split(' ',$dbm{$_});
		}

		foreach my $facs (@compare) {
  			$hashh{$facs} = 1;
		}

		foreach my $facs (@compare1) {
 			 $hashh1{$facs} = 1;
		}

		foreach (keys %hashh) {
			if (exists $hashh1{$_})
			{
				$countpositive++;
			}
			$count++;
		}
		$matchingper=($countpositive/$count)*100;
		printf ("%-20s %-15s %-10s %-4s %-20s %-4s %30s %-4s", "NAME OF SYSCALL: ", $_, "COUNT= ", $count, " COUNT MATCH= ", $countpositive, " IMMEDIATE 			SYCALL MATCHING %  ", $matchingper);
		printf " \n";
		$count=0;
		$countpositive=0;
	}

close(INFO);
close(INFO1);
close(INFO2);
close(INFOO1);
open(INFO, "+>$file")|| die "can't open"; 
open(INFO1, "+>$file1") || die "Can't Open File: $file1\n"; 
open(INFOO1, "+>$file11")|| die "can't open";
close(INFO);
close(INFO1);
close(INFO2);
close(INFOO1);


sanchuse POSIX;
use SDBM_File;

	my %dbm;
	while (my $arg = shift) {          
 		 $array[$g]=$arg;              
  		 $g++; 
	}

	my $db_file=$array[10].".dbm";
	$db_file="/home/sanch/Desktop/filemonitoring/files/MSCD/Database/".$db_file;

	tie %dbm, 'SDBM_File', $db_file, O_CREAT|O_RDWR, 0644;

	if(tied %dbm){
		print "FILE $db_file now open\n";
	}
	else
	{
		die " sorry unable to open $db_file\n";
	}
	$_="";
	#Functions that writes to database
	sub writedb {

		my $keyname=$_[0];
		my $keyval= $_[1];              

		if(exists $dbm{$keyname})
		{
			$dbm{$keyname}=$keyval;
		}
		else
		{
			$dbm{$keyname}=$keyval;
		}
	}


	my $g=0;
	my $c=0;
	my $line;
	my @string;
	my $i=0;
	my %hash;
	my %hash1;
	my %hash2;
	my @values;
	my $i1=0;
	$string[0]="";
	$string[1]="";
	my @array1;
	my @array2;
	my @array3;
	my %hashing;  
	my %hashing1;
	my %hashing2; 



#opening 6 files two containing strace log of same program execution two to store intermediate processed call logs data and two for final system call seuence 

	my $file="/home/sanch/Desktop/filemonitoring/files/MSCD/";     
	$file = $file . $array[0];           
	open(INFO, "$file")|| die "can't open";         

	my $fila="/home/sanch/Desktop/filemonitoring/files/MSCD/";    
	$fila=$fila . $array[1];               
	open(HAND, "$fila") || die "Can't Open File: $fila\n";  

        my $file11="/home/sanch/Desktop/filemonitoring/files/MSCD/";     
	$file11 = $file11 . $array[2];
	open(INFOT, "$file11")|| die "can't open";

        my $file1="/home/sanch/Desktop/filemonitoring/files/MSCD/";     
	$file1 = $file1 . $array[3];
	open(INFO1, "+>$file1")|| die "can't open";

	my $fila1="/home/sanch/Desktop/filemonitoring/files/MSCD/";    
	$fila1=$fila1 . $array[4];
	open(HAND1, "+>$fila1") || die "Can't Open File: $fila\n";   

        my $file12="/home/sanch/Desktop/filemonitoring/files/MSCD/";    
	$file12 = $file12 . $array[5];
	open(INFO1T, "+>$file12")|| die "can't open";

	my $filee1="/home/sanch/Desktop/filemonitoring/files/MSCD/";   
	$filee1 = $filee1 . $array[6]; 
	open(INFOO1, "+>$filee1")|| die "can't open";

	my $filaa1="/home/sanch/Desktop/filemonitoring/files/MSCD/";  
	$filaa1=$filaa1 . $array[7];
	open(HANDD1, "+>$filaa1") || die "Can't Open File: $filaa1\n";

        my $file13="/home/sanch/Desktop/filemonitoring/files/MSCD/";  
	$file13 = $file13 . $array[8];
	open(INFO2T, "+>$file13")|| die "can't open";

        my $filaa2="/home/sanch/Desktop/filemonitoring/files/MSCD/";  
	$filaa2=$filaa2 . $array[9];
	open(HANDD3, "+>$filaa2") || die "Can't Open File: $filaa1\n";

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
	$i1=0;
	$string[0]="";

	foreach $line (<HAND>)  {  
     
		if($line =~/(.*?)\(/)
		{
			$i1++;
			$string[0]=$string[0].$1." ";
			if($i1%2==0)
			{
				print HAND1 $string[0]."\n";
				$string[0]="";
			}
			if (exists $hashing1{$1})
			{
				$hashing1{$1}+=1;
			}
			else
			{
				$hashing1{$1}=1;
			}
		}    
	}
	$i1=0;
	$string[0]="";
	foreach $line (<INFOT>)  { 
     
		if($line =~/(.*?)\(/)   
		{
			$i1++;        
			$string[0]=$string[0].$1." ";   
			if($i1%2==0)   
			{
				print INFO1T $string[0]."\n"; 
				$string[0]="";  
			}
			if (exists $hashing2{$1})    
			{
				$hashing2{$1}+=1;  
			}
			else
			{
				$hashing2{$1}=1;  
			}
		}    
	}
	print INFO1 "~~~~~ sys call logs ends here~~~~~~\n";  
# to discriminate between the syscall logs and the logs of frequency 

#we are now creating the frequency of each unique value and store it you can see it is here

	foreach (keys %hashing) {
		printf INFO1 ("%-30s %-5s", $_, $hashing{$_});
		print INFO1 "\n";
	}
	foreach (keys %hashing) {
		$hashing{$_}=0;
	 }

	
	print HAND1 "~~~~~ unique system call~~~~~~\n";
	foreach (keys %hashing1) {
		printf HAND1 ("%-30s %-5s", $_, $hashing1{$_});
		print HAND1 "\n";
	}
	foreach (keys %hashing1) {
		$hashing1{$_}=0;
	}

	#make a layer between data printed and the processed data that contains uniue system calls and there freuency of occurence in log
	print INFO1T "~~~~~ unique system call~~~~~~\n";
	foreach (keys %hashing2) {	
		printf INFO1T ("%-30s %-5s", $_, $hashing2{$_});
		print INFO1T "\n";
	}
	foreach (keys %hashing2) {
		$hashing2{$_}=0;
	}

	close(INFO1);
	open(INFO2, "+<$file1")|| die "can't open";


	#opening the file and reading till "SANCHI" and creating a hash that comtains unique system call as key and value as a concatenated string of all syscalls 		found immediate to it this is because in file we have displayed two syscalls separated by a line.
	foreach $line (<INFO2>)  { 
		if($line =~ /(.*)~~~~~ unique system call~~~~~~(.*)/)
		{
			goto END;
		}
		@values= split(' ', $line);

		if (exists $hash{$values[0]})
		{
			hash{$values[0]}=$hash{$values[0]}." ".$values[1];
		}
		else
		{
			$hash{$values[0]}=$values[1];
		}
	}
	END:

	#creating a file that display syscall followed by all syscalls (only once) that are just immediate to it
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
	close(HAND1);
	#Similarly Doing for second file
	open(HAND2, "+<$fila1")|| die "can't open";
	my @values;
	$c=0;
	foreach $line (<HAND2>)  { 
		if($line =~ /(.*)~~~~~ unique system call~~~~~~(.*)/)
		{
			goto START;
		}
		@values= split(' ', $line);

		if (exists $hash1{$values[0]})
		{
			$hash1{$values[0]}=$hash1{$values[0]}." ".$values[1];
		}
		else
		{
			$hash1{$values[0]}=$values[1];
		}
	}
	START:

	my $uniquehash1;
	my $stringunique1="";

	foreach (keys %hash1) {
		@values=split(' ',$hash1{$_});
		foreach my $facs (@values) {
 			 $uniquehash1{$facs} = 1;
		}
		foreach (keys %uniquehash1) {
		$stringunique1=$stringunique1.$_." ";
	}
	$hash1{$_}=$stringunique1;
	$stringunique1="";
	printf HAND2 ("%-30s %-5s", $_, $hash1{$_});
	printf HANDD1 ("%-30s %-5s", $_, $hash1{$_});
	print HAND2 "\n";
	print HANDD1 "\n";
	$array2[$c]=$hash1{$_};
	$c++;
	}
	close(INFO1T);
	open(INFOTT, "+<$file12")|| die "can't open";
	
       #Similarly for third file
	foreach $line (<INFOTT>)  { 
		if($line =~ /(.*)~~~~~ unique system call~~~~~~(.*)/)
		{
			goto END1;
		}
		@values= split(' ', $line);
		if (exists $hash2{$values[0]})
		{
			$hash2{$values[0]}=$hash2{$values[0]}." ".$values[1];
		}
		else
		{
			$hash2{$values[0]}=$values[1];
		}
	}
	END1:

	#creating a file that display syscall followed by all syscalls that are just immediate to it
	my $uniquehash2="";
	my $stringunique2="";

	foreach (keys %hash2) {
		@values=split(' ',$hash2{$_});
		foreach my $facs (@values) {
 			 $uniquehash2{$facs} = 1;
		}
		foreach (keys %uniquehash2) {
			$stringunique2=$stringunique2.$_." ";
	}
	$hash2{$_}=$stringunique2;
	$stringunique2="";
	printf INFOTT ("%-30s %-5s", $_, $hash2{$_});
	printf INFO2T ("%-30s %-5s", $_, $hash2{$_});
	print INFOTT "\n";
	print INFO2T "\n";
	$array2[$c]=$hash2{$_};
	$c++;
	}
	#this logic counts for matching betwen two executions of program..... matches the immediate sinatures after a particular signature that are stored in abc5 and abc6
	my %hashh;
	my %hashh1;
	my %hashh2;
	my $count=0;
	my $countpositive=0;
	my @compare;
	my @compare1;
	my @comapre2;
	my $matchingper;
	$c=0;

	foreach (keys %hash) {
		if (exists $hash1{$_})
		{
		if( exists $hash2{$_})
		{
			@compare=split(' ',$hash{$_});
			@compare1=split(' ',$hash1{$_});
			@compare2=split(' ',$hash2{$_});
		}
	}


	foreach my $facs (@compare) {
 		 $hashh{$facs} = 1;
	}
	foreach my $facs (@compare1) {
  		$hashh1{$facs} = 1;
	}
	foreach my $facs (@compare2) {
 		 $hashh2{$facs} = 1;
	}

	foreach (keys %hashh) {
		if (exists $hashh1{$_}|| exists $hashh2{$_})
		{
			$countpositive++;
		}
		$count++;
	}
	$matchingper=($countpositive/$count)*100;
	printf HANDD3 ("%-20s %-15s %-10s %-4s %-20s %-4s %30s %-4s", "NAME OF SYSCALL: ", $_, "COUNT= ", $count, " COUNT MATCH= ", $countpositive, " IMMEDIATE SYCALL MATCHING %  ", $matchingper);
	print HANDD3  " \n";
	$count=0;
	$countpositive=0;
}

#calculating a single hash that contains the unique syscalls from both the hashes and will concatenate the syscalls generated by them
	my $hashingfinal;
	my $hashhh;
	my $unique1="";
	foreach (keys %hash){
		if(exists $hash1{$_})
		{
			if(exists $hash2{$_}){
				$hashingfinal{$_}= $hash{$_}.$hash1{$_}.$hash2{$_};
			}
		}
	}
	foreach (keys %hashingfinal){
		@compare= split(' ',$hashingfinal{$_});
		foreach my $facs (@compare) {
 			 $hashhh{$facs} = 1;
	}
	foreach (keys %hashhh){
		$unique1=$unique1.$_." ";
	}

	$hashingfinal{$_}=$unique1;
        #writing final syscall signature to DB
	writedb($_, $unique1);
	$unique1="";
}


	foreach (keys %hashingfinal)
	{
		printf HANDD3 ("%-20s %-100s", $_, $hashingfinal{$_});
		print HANDD3 "\n";
	}


#for an example matching 
#this code matches the execution of a program immediate syscall signatures with the syscall signatures gathered after two consectuive execution of same program

#this logic counts for matching betwen two executions of program..... matches the immediate sinatures after a particular sinature that are stored in abc5 and abc6

	$count=0;
	$countpositive=0;

	$c=0;

	foreach (keys %hash) {
		if (exists $hashingfinal{$_})
		{
			@compare=split(' ',$hash{$_});
			@compare1=split(' ',$hashingfinal{$_});
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
		printf HANDD3 ("%-20s %-15s %-10s %-4s %-20s %-4s %30s %-4s", "NAME OF SYSCALL: ", $_, "COUNT= ", $count, " COUNT MATCH= ", $countpositive, " IMMEDIATE SYCALL MATCHING %  ", $matchingper);
		print HANDD3  " \n";
		$count=0;
		$countpositive=0;

}

	untie %dbm;
	close(INFO);

	close(INFO01);

	close(HAND);
	close(HANDD3);
	close(HANDD1);



open(INFO, "+>$file")|| die "can't open"; 
open(HAND, "+>$fila") || die "Can't Open File: $fila\n"; 
open(INFOT, "+>$file11")|| die "can't open";
open(INFO1, "+>$file1")|| die "can't open";
open(HAND1, "+>$fila1") || die "Can't Open File: $fila\n";   
open(INFO1T, "+>$file12")|| die "can't open";
open(INFOO1, "+>$filee1")|| die "can't open";
open(HANDD1, "+>$filaa1") || die "Can't Open File: $filaa1\n";
open(INFO2T, "+>$file13")|| die "can't open";
open(HANDD3, "+>$filaa2") || die "Can't Open File: $filaa1\n";
close(INFO);
close(HAND);
close(INFOT);
close(INFO1);
close(HAND1);
close(INFO1T);
close(INFOO1);
close(HANDD1);
close(INFO2T);
close(HANDD3);







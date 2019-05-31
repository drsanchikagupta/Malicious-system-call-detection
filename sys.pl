	
	#This is the file to initiate System Call Database Creation

	my $file="/home/sanch/Desktop/filemonitoring/files/MSCD/abc11"; 
	open(INFO, "$file")|| die "can't open";


	die "could not fork: $!" unless defined (my $first_pid = fork);

	#first child
		exec $^X, "callprogram.pl" unless $first_pid;
		die "could not fork: $!" unless defined (my $second_pid = fork);

	#second child
		exec $^X, "callexittimer.pl" unless $second_pid;

	waitpid $first_pid,  0;  #wait for first child to finish
	waitpid $second_pid, 0;  #wait for second child to finish

	print "calling display.pl";

	system("perl display.pl");


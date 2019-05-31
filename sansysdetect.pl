#sansysdetect.pl



my $g=0;
while (my $arg = shift) {
  $array[$g]=$arg;
  $g++; 
}


my $file="/home/gaurav/Desktop/abc11"; 
open(INFO, "$file")|| die "can't open";

#foreach $line (<INFO>){
#$key=$line;
#print $key;  
#my $keycall="abc".$i." ".$key;  #this is for make it proper for calling by strace
#print $keycall;

die "could not fork: $!" unless defined (my $first_pid = fork);

#first child
exec $^X, "anomalycallprogram.pl" unless $first_pid;

die "could not fork: $!" unless defined (my $second_pid = fork);

#second child
exec $^X, "anomalycallexittimer.pl" unless $second_pid;

waitpid $first_pid,  0;  #wait for first child to finish
waitpid $second_pid, 0;  



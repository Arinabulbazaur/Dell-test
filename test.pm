use strict;
use warnings;
use DateTime;


sub str_to_Date{
   my ($str)=@_;
   my ($d,$m,$y,$h,$min,$s) = $str =~ /^(\d{2})\.(\d{2})\.(\d{4}) (\d{2}):(\d{2}):(\d{2})/;
   my $dt = DateTime->new(
   	year      => $y,
   	month     => $m,
   	day       => $d,
   	hour      => $h,
   	minute    => $min,
   	second    => $s,
   	time_zone => 'local',
   ); 
   return $dt;
}


sub analyse_of_log{
    my $sys = 1;
    my %start=();
    my %stop=();
    while (my $fname = shift @_)
    {
        open my $fh, "<", $fname;                                   
    	while (my $line = <$fh>){
     		if ($line =~/SYSTEM/){  
          		for my $key ( keys %start )
            		{
            			print "$key start didn’t end\n";
            		}
          		for my $key ( keys %stop )
            		{
            			print "$key stop didn’t end\n";
           		}  
          		%start=();
          		%stop=();
         		print "Start $sys:\n"; 
          		$sys++;
        	}        
     		elsif($line=~/([\d\. :]+) (\w+): START STARTED/)
       		{
        		$start{$2}=$1;
        	}
     		elsif ($line=~/([\d\. :]+) (\w+): STOP STARTED/)
      		{
        		$stop{$2}=$1;
       		}
     		elsif ($line=~/([\d\. :]+) (\w+): STOP COMPLETE/)
       		{
        		my $dt1 = str_to_Date($1);
        		my $dt2 = str_to_Date($stop{$2}); 
        		my $dur = $dt1->subtract_datetime($dt2);
        		my @non = grep { $$dur{$_} ne "0" && $_ ne"end_of_month"} keys(%$dur);
        		print "$2 stoped";
        		for my $c(@non){print " $$dur{$c} $c";}
        		print "\n"; 
        		delete ($stop{$2});
   		}
     		elsif($line=~/([\d\. :]+) (\w+): START COMPLETE/)
       		{        
        		my $dt1 = str_to_Date($1);
        		my $dt2 = str_to_Date($start{$2}); 
        		my $dur = $dt1->subtract_datetime($dt2);    
        		my @non = grep { $$dur{$_} ne "0" && $_ ne"end_of_month"} keys(%$dur);    
        		print "$2 started";
        		for my $c(@non){print " $$dur{$c} $c";}
        		print "\n"; 
        		delete ($start{$2});
        	} 
    	}
    	close $fh;
   }
}


analyse_of_log(@ARGV);
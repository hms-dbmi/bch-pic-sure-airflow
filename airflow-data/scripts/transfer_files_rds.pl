#!/usr/bin/perl
use DBI;
use warnings;
use strict;

my $input_files = $ARGV[0];
my @files = split(',', $input_files);

foreach my $file_to_transfer (@files) {
	# RDS instance info
	my $RDS_PORT=1521; 
	my $RDS_HOST=$ENV{'ORACLE_HOST'}; 
	my $RDS_LOGIN="$ENV{'ORACLE_USER'}/$ENV{'ORACLE_PASSWORD'}"; 
	
	my $RDS_SID=$ENV{'ORACLE_DATABASE'};
	
	# #The $file_to_transfer is a parameter you pass into the script
	my $dirname = "DATA_PUMP_DIR";
	my $fname = $file_to_transfer;
	
	my $data = "dummy";
	my $chunk = 8192;
	
	my $sql_open = "BEGIN perl_global.fh := utl_file.fopen(:dirname, :fname, 'wb', :chunk); END;";
	my $sql_write = "BEGIN utl_file.put_raw(perl_global.fh, :data, true); END;";
	my $sql_close = "BEGIN utl_file.fclose(perl_global.fh); END;";
	my $sql_global = "create or replace package perl_global as fh utl_file.file_type; end;";
	
	my $conn = DBI->connect('dbi:Oracle:host='.$RDS_HOST.';sid='.$RDS_SID.';port='.$RDS_PORT,$RDS_LOGIN, '') || die ( $DBI::errstr . "\n");
	
	my $updated=$conn->do($sql_global);
	my $stmt = $conn->prepare ($sql_open);
	$stmt->bind_param_inout(":dirname", \$dirname, 12);
	$stmt->bind_param_inout(":fname", \$fname, 12);
	$stmt->bind_param_inout(":chunk", \$chunk, 4);
	$stmt->execute() || die ( $DBI::errstr . "\n");
	
	open (INF, $fname) || die "\nCan't open $fname for reading: $!\n";
	binmode(INF);
	$stmt = $conn->prepare ($sql_write);
	my %attrib = ('ora_type','24');
	 my $val=1;
	 while ($val> 0) {
	   $val = read (INF, $data, $chunk);
	     $stmt->bind_param(":data", $data , \%attrib);
	       $stmt->execute() || die ( $DBI::errstr . "\n") ;
	 };
	       die "Problem copying: $!\n" if $!;
	       close INF || die "Can't close $fname: $!\n";
	         $stmt = $conn->prepare ($sql_close);
	         $stmt->execute() || die ( $DBI::errstr . "\n") ;
}	         
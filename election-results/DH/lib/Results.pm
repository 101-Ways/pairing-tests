package Results;

use strict;
use warnings;

use Text::CSV;
use Data::Dumper;
use Carp;


use FindBin qw($Bin);
use lib "$Bin/lib";
use Results;


sub new {
  my $class = shift;
  my $self = {};
  bless $self, $class;
  
  return $self;
}

my %parties = (
	       "C" =>    "Conservative Party",
	       "L" =>    "Labour Party",
	       "UKIP" => "UKIP",
	       "LD" =>   "Liberal Democrats",
	       "G" =>    "Green Party",
	       "Ind" =>  "Independent",
	       "SNP" =>  "SNP",
) ;

sub readfile {
  my ($self,$filename) = @_;
  
  my %results;
  my $csv = Text::CSV->new ( { binary => 1 } ) # should set binary attribute.
    or croak "Cannot use CSV: ".Text::CSV->error_diag ();

  open my $fh, "<:encoding(utf8)", "$filename" or croak "Can't open $filename: $!";
  while ( my $result = $csv->getline( $fh ) ) {
    my $constituency = shift $result;
    while ($result) {
      my $total = shift $result;
      last if ! $total;
      my $party = shift $result;
      if (!$party) {
	carp "No party for $constituency";
	exit 1;
      }
      $results{$constituency}{$party} = $total;
    }
  }
  $csv->eof or $csv->error_diag();
  close $fh;
  return %results;
}

1;

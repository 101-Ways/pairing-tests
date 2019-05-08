#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Results;

my $r = Results->new();

my %results  = $r->readfile("etc/results.csv");
my %results1 = $r->readfile("etc/override.csv");

foreach (my $const = keys %results1) {
  $results{$const} = $results1{$const} if exists $results1{$const};
}

carp Dumper(\%results);


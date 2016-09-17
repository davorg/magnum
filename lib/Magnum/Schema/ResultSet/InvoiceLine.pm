package Magnum::Schema::ResultSet::InvoiceLine;

use strict;
use warnings;
use Moose;
use MooseX::NonMoose;
extends 'DBIx::Class::ResultSet';

sub BUILDARGS { $_[2] }

has default_vat_type => (
  is => 'ro',
  isa => 'Str',
  default => 'standard',
);

sub filter_by_vat_type {
  my $self = shift;
  my ($vat_type) = @_;

  $vat_type //= $self->default_vat_type;

  $self->search({
    vat => $vat_type,
  });
}

sub filter_standard_vat {
  my $self = shift;

  return $self->filter_by_vat_type('standard');
}

sub filter_zero_vat {
  my $self = shift;

  return $self->filter_by_vat_type('zero');
}

sub filter_exempt_vat {
  my $self = shift;

  return $self->filter_by_vat_type('exempt');
}

1;

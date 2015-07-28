package Magnum::Schema::ResultSet::InvoiceLine;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

sub filter_by_vat_type {
  my $self = shift;
  my ($vat_type) = @_;

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
